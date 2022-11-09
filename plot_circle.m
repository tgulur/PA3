function h = plot_circle(x,y,r) % Function to plot a circle 
% Referenced from here: https://www.mathworks.com/matlabcentral/answers/98665-how-do-i-plot-a-circle-with-a-given-radius-and-center

hold on
th = 0:pi/50:2*pi; %  Array of eqns
xunit = r * cos(th) + x; % X val
yunit = r * sin(th) + y; % Y val
h = plot(xunit, yunit); % Plotting circle 
hold off