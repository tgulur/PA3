%% PA3 - Inverse Kinematics - Atish Ananth, Tejas Gulur, Max Lemon, James Farrell


% Close everything 
clc
clear
close all

% Get the user input
% points = 5;
points = input('Type in how many points you are entering: ');
while(~isnumeric(points) || points <= 1)
    fprintf("Invalid input!\n")
    points = input('Type in how many points you are entering: ');
end 

% Open figure 1 for our user input 
figure(1)

% Initialize column vector variables for graphical inputs
x_num = zeros(points,1); 
y_num = zeros(points,1);

% Set line property for the points
line_property = plot(0,0,'k.-');
% Loop thru amount of inputs and store them
for i = 1:points
    
    % Plot circle function which gives the workspace
    plot_circle(0,0, 0.5);
    plot_circle(0,0, 1.5);
    
    % Gives the circles
    title(['Click  on ' num2str(points-i+1) ' points'])
    [x,y] = ginput(1);
    
    % Initialize radioos (radius) and prompt user to select inside the
    % workspace
    radioos = sqrt(x^2 + y^2);
    while( radioos < 0.5 || radioos > 1.5)
        title(sprintf('Point must be in the workspace! Try again'))
        [x,y] = ginput(1);
        radioos = sqrt(x^2 + y^2);
    end 

    % Write to array
    x_num(i) = x;
    y_num(i) = y;

    % Set array val
    set(line_property, 'xdata', x_num(1:i), 'ydata', y_num(1:i));

     

end 

% Convert the column vectors to a theta and rho that are defined in polar
[theta,rho] = cart2pol(x_num, y_num);



figure(2)

% Resulting curve  function returned w/ circles 
[T, R]  = awesome_curve_fit(theta,rho);
plot(x_num, y_num);
plot(R.*cos(T), R.*sin(T));

plot_circle(0,0,0.5);
plot_circle(0,0,1.5);

 

% Getting radius values for the curve 
[j1, j2] =  spline_disc(T, R);

clf

%animating the path of the robot

frames = length(j1);
F(frames) = struct('cdata', [], 'colormap', []); %initialize Frames for movie

for i=1:length(j1)
    
    plot(R.*cos(T), R.*sin(T));
    plot_circle(0,0,0.5);
    plot_circle(0,0,1.5);
    plot_links(j1(i),j2(i));
    
    F(i) = getframe();  % Capture the current plot as a animation frame
    
end

% Play back the animation
figure();
movie(F, 1, 100);

%%
% One of the biggest challenges we faced in this was definitely in
% smoothing out the algorithm to fit the curve. We ended up taking a unique
% approach in utilizing polar coordinates in order to draw the spline curve
% which allowed for a simplification of calculations. These simplifications
% carried on into the rest of the calculations that we performed, including
% the inverse kinematics! Another challenge that we faced was working
% together and sending each other code, but we ended up using GitHub and
% used GitHub desktop to keep track of changes, commits, and changes to
% code so we can work on it in real time as well as make sure code
% collisions wouldn't occur. Finally, we attempted to break the code up
% more by utilizing MatLab functions to do the curve algorithm, circle
% plotting, invesrse kinematics, and link plotting
