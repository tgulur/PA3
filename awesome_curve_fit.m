function [theta, R] = awesome_curve_fit(theta_data, R_data)
% Returns a curve fit for the inputed data that stays within the desired
% operating range of the robot
% 
% Note on Input: Data must be inputed as equal sized column vectors
%
% Note on Output: Output is a set of R & theta values that follows the
% curve going through the inputed points

% Define parameters 
% (Independent of inputs, based on the specific robot in use)
L1 = 1;
L2 = 0.5;

r1 = abs(L1-L2);
r2 = L1+L2;

% Find the number of elements
num_points = numel(theta_data);

% Store inputed data into one array
polarP_raw = [theta_data, R_data];

% Sort data into ascending order
polarP = sortrows(polarP_raw);

% Find theta range for data points
theta = min(polarP(:,1)):0.001:max(polarP(:,1));

check = true;  % Check marker for if the spline goes out of bounds (initialized as true so the loop will start)
loop = 0;   % Loop number limiter

while check && loop < 20
    % Generate curve fit
    curve_fit = griddedInterpolant(polarP(:,1), polarP(:,2), 'spline');

    % Check if all the points of the spline are within the range
    outside = cell(numel(polarP(:,1)),1);   % Cell containing vectors of the index of points outside the outer range
    inside = cell(numel(polarP(:,1)),1);    % Cell containing vectors of the index of points inside the inner range

    r_out = 1;  % Initalize which cell element to add OOB points to
    r_in = 1;   

    check = false;  % Assume the spline stays in-bounds until proven otherwise
    for i=1:numel(theta)
        % Check if spline goes outside the outer circle
        if curve_fit(theta(i)) > r2
            if isempty(outside{r_out})  % Check if its the first time going outside
                outside{r_out} = i; % Initialize vector
            elseif max(outside{r_out}) == i-1   % Check if consectutive data points
                outside{r_out} = [outside{r_out}, i];   % Add value to vector
            else    % If not consectutive data points, start a new vector for a new segment goint out of bounds
                r_out = r_out+1;
                outside{r_out} = [outside{r_out}, i];
            end
            check = true;   % Mark that the spline has gone out of bounds
        end
        % Check if the spline goes inside the inner circle
        if curve_fit(theta(i)) < r1
            % Check if its the first time going inside
            if isempty(inside{r_in})
                inside{r_in} = i;   % Initialize vector vector
            elseif max(inside{r_in}) == i-1 % Check if these are consectutive data points
                inside{r_in} = [inside{r_in}, i];   % Add index to vector
            else    % If not consectutiv data points, start a new vector for a new segment going out of bounds
                r_in = r_in+1;
                inside{r_in} = [inside{r_in}, i];
            end
            check = true;   % Mark that the spline has gone out of bounds
        end
    end

    % Find peaks & valleys outside of range
    peak_idx = [];
    val_idx = [];

    for i=1:num_points
        if ~isempty(outside{i}) % Check if the spline has gone outside the outer bound
            [peak_val, peak] = max(curve_fit(theta(outside{i})));   % Find index of peak
            peak_idx = [peak_idx; peak+outside{i}(1)-1];  % Add index of peak to beginning index of the OOB segment to find the overall index
        end
        if ~isempty(inside{i})  % Check if the spline has gone inside the inner bound
            [vall_val, val] = min(curve_fit(theta(inside{i}))); % Find the index of the valley
            val_idx = [val_idx; val+inside{i}(1)-1];  % Add index of valley to the beginning indedx of the OOB segment to find the overall index
        end
    end

    % Set new peaks & valleys to same theta value but on the limits, then and add new
    % points to current data set

    for i=1:numel(peak_idx)
        polarP = [polarP; theta(peak_idx(i)), r2];
    end
    for i=1:numel(val_idx)
        polarP = [polarP; theta(val_idx(i)), r1];
    end

    % Re-sort the data points into ascending order
    polarP = sortrows(polarP);

    % Remove any repeated values in the data
    polarP = unique(polarP, 'rows');

    % Increment loop counter
    loop = loop +1;
end
R = curve_fit(theta);
end