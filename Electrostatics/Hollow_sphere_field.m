[x,y,z] = meshgrid(-2:0.5:2, -2:0.5:2, -2:0.5:2);
obs = [x(:), y(:), z(:)];

R = 1;              % Sphere radius
sigma0 = 1e-6;      % Surface charge density

surface_fun = @(theta,phi) ...
    [ R*sin(theta(:)).*cos(phi(:)), ...
      R*sin(theta(:)).*sin(phi(:)), ...
      R*cos(theta(:)) ];

sigma_fun = @(theta,phi) ...
    ones(numel(theta),1) * sigma0;

[Ex,Ey,Ez] = Efield_surface(obs, surface_fun, sigma_fun, ...
                            0, pi, 0, 2*pi);

% Reshape field
Ex = reshape(Ex, size(x));
Ey = reshape(Ey, size(y));
Ez = reshape(Ez, size(z));


%Gauss Law Mask
R_obs = sqrt(x.^2 + y.^2 + z.^2);
inside_mask = R_obs < (0.99 * R); 
Ex(inside_mask) = 0;
Ey(inside_mask) = 0;
Ez(inside_mask) = 0;

% Normalize
mag = sqrt(Ex.^2 + Ey.^2 + Ez.^2);
Ex = Ex ./ (1 + mag);
Ey = Ey ./ (1 + mag);
Ez = Ez ./ (1 + mag);

%Plot
Nplot = 80;
theta_plot = linspace(0,pi,Nplot);
phi_plot   = linspace(0,2*pi,Nplot);
[Theta_plot, Phi_plot] = meshgrid(theta_plot, phi_plot);

Xsurf = R*sin(Theta_plot).*cos(Phi_plot);
Ysurf = R*sin(Theta_plot).*sin(Phi_plot);
Zsurf = R*cos(Theta_plot);

figure;
quiver3(x,y,z,Ex,Ey,Ez);
hold on;
surf(Xsurf, Ysurf, Zsurf, ...
     'FaceColor','red', ...
     'EdgeColor','none', ...
     'FaceAlpha',0.3);
grid on;
axis equal;
title('Electric Field of Uniformly Charged Hollow Sphere');
xlabel('X');
ylabel('Y');
zlabel('Z');