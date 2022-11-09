function [j1, j2] = spline_disc(theta, R)
%function takes a series of spline angle and theta values (polar) and
%uses these values to generate a series of corresponding joint variable
%values
%satisfy spline motion of end effector - proven by the spline function
%Input is a theta and r for spline
% angle = theta; %Array of angles that the spline function crosses through

% radii = R; %array of corresponding radii

[x, y] = pol2cart(theta, R)
L1 = 1; %Link 1
L2 = 0.5; %Link 2 length
r1 = sqrt(x.^2 + y.^2); %Radial distance from base (I didn't need another variable but I am too lazy to change the formula :))

sz = size(theta); %Gets the size of the angles vector - assumes that angles and R are the same size
j1 = zeros(sz); %Initializes joint variable vectors with zeros
j2 = zeros(sz);

for i = 1:length(theta) %Repeating loop that performs inverse kinematic relation for each polar coordinate (r, theta)
j1(i) = atan2(y(i),x(i)) - acos((L2^2-L1^2-r1(i)^2)/(-2*L1*r1(i)));

j2(i) = pi - acos((r1(i)^2-L1^2-L2^2)/(-2*L1*L2));
end
% j1 = transpose(j1);
% j2 = transpose(j2);
% joint_angles = [j1 j2]; %final output array of j1 and j2