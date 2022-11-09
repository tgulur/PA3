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
    
    F(i) = getFrame();  % Capture the current plot as a animation frame
    
end

% Play back the animation
figure();
movie(F, 1, 100);


