%Setup coordinate system
x = -5:0.5:5;
y = -5:0.5:5;
z = -5:0.5:5;
[X1, Y1] = meshgrid(x,y);
[X, Y, Z] = meshgrid(x,y,z);

R_planar = sqrt(X1 .^2 + Y1 .^2);
R = sqrt(X .^2 + Y .^2 + Z .^2);
R(R==0) = 1e-3;
R_planar(R_planar==0) = 1e-3;

%Computing Field components along axes for 2D 
Ex_planar = X1 ./ (R_planar .^ 3);
Ey_planar = Y1 ./ (R_planar .^ 3);

%Computing Field components along axes for 3D
Ex = X ./ (R .^ 3);
Ey = Y ./ (R .^ 3);
Ez = Z ./ (R .^ 3);

%% Plotting Vector Fields

%2D Plot with field lines
figure;
hold on;

quiver(X1,Y1,Ex_planar,Ey_planar, 0);

theta = linspace(0,2*pi,10);
radius = 0.5;

startx = radius*cos(theta);
starty = radius*sin(theta);
h = streamline(X1,Y1,Ex_planar,Ey_planar,startx,starty);
set(h,'Color','red','LineWidth',0.75)

xlabel("x");
ylabel("y");
title("Electric Field");

hold off;

%3D Plot
figure;
quiver3(X,Y,Z,Ex,Ey,Ez, 0);
axis equal;
xlabel('X')
ylabel('Y')
zlabel('Z')
title('3D Electric Field');