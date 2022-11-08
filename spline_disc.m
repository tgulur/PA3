function [joint_angles] = spline_disc(theta, R)
%function takes a series of spline angle and theta values (polar) and
%uses these values to generate a series of corresponding joint variable
%values
%satisfy spline motion of end effector - proven by the spline function
%Input is a polar spline function
angles = theta; %Array of angles that go into the joint angle calculator

radii = R; %derived from the spline function in ascending order. This R is used to determine x and y positions in inverse kinematics

L1 = 1; %Link 1
L2 = 0.5; %Link 2 length
r1 = R; %Radial distance from base (I didn't need another variable but I am too lazy to change the formula :))

sz = size(angles); %Gets the size of the angles vector - assumes that angles and R are the same size
j1 = zeros(sz); %Initializes joint variable vectors with zeros
j2 = zeros(sz);

for i = 1:length(angles) %Repeating loop that performs inverse kinematic relation for each polar coordinate (r, theta)
j1(i) = arctan((radii(i)*sin(angles(i)))/(radii(i)*cos(angles(i)))) - arccos((L2^2 - L1^2 - r1^2)/(-2 * L1 * r1));

j2(i) = pi - arccos((r1^2 - L1^2 - L2^2)/(-2 * L1 * L2))
end

joint_angles = [j1 j2] %final output array of j1 and j2