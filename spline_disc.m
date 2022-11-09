function [j1, j2] = spline_disc(theta, R)
%Function takes in angles and corresponding radii to perform inverse
%kinematics and output corresponding joint variable positions

[x, y] = pol2cart(theta, R); %converts theta and R to cartesian x and y
L1 = 1; %Link 1
L2 = 0.5; %Link 2 length

sz = size(theta); %Gets the size of the angles vector - assumes that angles and R are the same size
j1 = zeros(sz); %Initializes joint variable vectors with zeros
j2 = zeros(sz);

for i = 1:length(theta) %Repeating loop that performs inverse kinematic relation for end effector position (x,y)
j1(i) = theta(i) - acos((x(i)^2+y(i)^2+L1^2-L2^2)/(2*L1*sqrt(x(i)^2+y(i)^2)));

j2(i) = pi - acos((L1^2+L2^2-x(i)^2-y(i)^2)/(2*L1*L2));
end