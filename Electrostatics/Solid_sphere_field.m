[x,y,z] = meshgrid(-2:0.5:2, -2:0.5:2, -2:0.5:2);
obs = [x(:), y(:), z(:)];

R = 1;              %radius
rho0 = 1e-6;        %Volume charge density
epsilon0 = 8.854e-12;

rho_fun = @(xq, yq, zq) rho0 .* (sqrt(xq.^2 + yq.^2 + zq.^2) <= R);

%Field
[Ex, Ey, Ez] = Efield_3D(obs, rho_fun, [-R R], [-R R], [-R R], 30);
Ex = reshape(Ex, size(x));
Ey = reshape(Ey, size(y));
Ez = reshape(Ez, size(z));

%Gauss Law Mask
R_obs = sqrt(x.^2 + y.^2 + z.^2);
inside_mask = R_obs < R; 
coef_inside = rho0 / (3 * epsilon0);
Ex(inside_mask) = coef_inside * x(inside_mask);
Ey(inside_mask) = coef_inside * y(inside_mask);
Ez(inside_mask) = coef_inside * z(inside_mask);

%Normalize
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
     'FaceColor','blue', ...
     'EdgeColor','none', ...
     'FaceAlpha',0.2); 
grid on;
axis equal;
title('Electric Field of Uniformly Charged Solid Sphere');
xlabel('X');
ylabel('Y');
zlabel('Z');