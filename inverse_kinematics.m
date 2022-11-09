% Close everything 
clc
clear
close all

% Get the user input
% points = 5;
points = input('Type in how many points you are entering: ');

% Open figure 1 for our user input 
figure(1)

% Initialize column vector variables for graphical inputs
x_num = zeros(points,1); 
y_num = zeros(points,1);


% Loop thru amount of inputs and store them
for i = 1:points
    plot_circle(0,0,1);
    plot_circle(0,0,1.5);
    title(['Click  on ' num2str(points-i+1) ' points'])
    [x,y] = ginput(1);


    x_num(i) = x;
    y_num(i) = y;
    if (x_num(i) == 0 && y_num(i) == 0)
        continue
    else 
        plot(x_num,y_num, 'Color', 'k')
    end 

    
end 

% Convert the column vectors to a theta and rho that are defined in polar
[theta,rho] = cart2pol(x_num, y_num);

% figure(2)

% Resulting curve  function returned
[T, R]  = awesome_curve_fit(theta,rho);

% Getting radius values for the curve 
[j1, j2] =  spline_disc(T, R);

% polarplot(theta,R)







