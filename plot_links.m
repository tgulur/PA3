function h = plot_links(j1,j2)
hold on
L1 = 1;
L2 = 0.5;

x1 = [0 L1*cos(j1)];
y1 = [0 L1*sin(j1)];

x2 = [L1*cos(j1) L1*cos(j1)+L2*cos(j2)];
y2 = [L1*sin(j1) L1*sin(j1)+L2*sin(j2)];

h = plot(x1,y1,x2,y2);
hold off