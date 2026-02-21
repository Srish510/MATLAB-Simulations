%Grid Setup
[x,y,z] = meshgrid(-2:0.5:2, -2:0.5:2, -2:1:2);
obs = [x(:), y(:), z(:)];

%Radius
R = 1;   

%Curve Equation
surface_fun = @(r,theta) ...
    [ (r(:).*cos(theta(:))), ...
      (r(:).*sin(theta(:))), ...
      zeros(numel(r),1) ];

%Charge Density
sigma_fun = @(r,theta) ones(numel(r),1)*1e-6;

[Ex,Ey,Ez] = Efield_surface(obs, surface_fun, sigma_fun, ...
                            0,R, 0,2*pi);

Ex = reshape(Ex, size(x));
Ey = reshape(Ey, size(y));
Ez = reshape(Ez, size(z));

% Normalize Field
mag = sqrt(Ex.^2 + Ey.^2 + Ez.^2);
Ex = Ex ./ (2 + mag);
Ey = Ey ./ (2 + mag);
Ez = Ez ./ (2 + mag);

%Plot Disc
Nr_plot = 80;
Ntheta_plot = 160;

r_plot = linspace(0, R, Nr_plot);
theta_plot = linspace(0, 2*pi, Ntheta_plot);

[R_plot, Theta_plot] = meshgrid(r_plot, theta_plot);

Xsurf = R_plot .* cos(Theta_plot);
Ysurf = R_plot .* sin(Theta_plot);
Zsurf = zeros(size(Xsurf));

figure;
quiver3(x,y,z,Ex,Ey,Ez);
hold on;

surf(Xsurf, Ysurf, Zsurf, ...
     'FaceColor', 'red', ...
     'EdgeColor', 'none', ...
     'FaceAlpha', 0.4);

grid on;
axis equal;
title('Electric Field of Charged Disk');
xlabel('X');
ylabel('Y');
zlabel('Z');