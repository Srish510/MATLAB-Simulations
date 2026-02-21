clc; clear; close all;

% ---- Observation grid ----
[x,y,z] = meshgrid(-2:0.5:2, -2:0.5:2, 0:0.25:2);
obs = [x(:), y(:), z(:)];

% ---- Curve definition ----
curve = @(s) [cos(4*pi*s)', ...
              sin(4*pi*s)', ...
              (2*s)'];

% ---- Charge density ----
lambda_fun = @(s) 1e-9*(1 + 0*s);   % constant density

% ---- Compute field ----
[Ex,Ey,Ez] = Efield_1D(obs, curve, lambda_fun);

% ---- Reshape for plotting ----
Ex = reshape(Ex, size(x));
Ey = reshape(Ey, size(y));
Ez = reshape(Ez, size(z));

% ---- Normalize for display ----
mag = sqrt(Ex.^2 + Ey.^2 + Ez.^2);
Ex = Ex ./ mag;
Ey = Ey ./ mag;
Ez = Ez ./ mag;

s_plot = linspace(0,1,800);
r_plot = curve(s_plot);

x_curve = r_plot(:,1);
y_curve = r_plot(:,2);
z_curve = r_plot(:,3);

figure 
quiver3(x,y,z,Ex,Ey,Ez)
hold on

plot3(x_curve, y_curve, z_curve, ...
      'r', 'LineWidth', 3)

grid on
axis equal
alpha(0.2)
title('Electric Field of Arbitrary Charged Curve')
xlabel('X')
ylabel('Y')
zlabel('Z')