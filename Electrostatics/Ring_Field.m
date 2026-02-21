%Grid Setup
[x,y,z] = meshgrid(-2:0.5:2, -2:0.5:2, -2:1:2);
obs = [x(:), y(:), z(:)];

%Radius
R = 1;   

%Curve Equation (xy plane)
curve = @(t) [ R*cos(t(:)), ...
               R*sin(t(:)), ...
               zeros(length(t),1) ];

%Charge Density
lambda_fun = @(t) 1e-9*(1 + 0*t);

%Field
[Ex,Ey,Ez] = Efield_1D(obs, curve, lambda_fun, 0, 2*pi);

Ex = reshape(Ex, size(x));
Ey = reshape(Ey, size(y));
Ez = reshape(Ez, size(z));

% Normalize Field
mag = sqrt(Ex.^2 + Ey.^2 + Ez.^2);
Ex = Ex ./ (2 + mag);
Ey = Ey ./ (2 + mag);
Ez = Ez ./ (2 + mag);

%Plot Ring
t_plot = linspace(0,2*pi,800);
r_plot = curve(t_plot);
x_curve = r_plot(:,1);
y_curve = r_plot(:,2);
z_curve = r_plot(:,3);

%Plot curve and field
figure;
quiver3(x,y,z,Ex,Ey,Ez);
hold on;
plot3(x_curve, y_curve, z_curve, ...
      'red', 'LineWidth', 3);
grid on;
axis equal;
alpha(0.2);
title('Electric Field of Charged Ring');
xlabel('X');
ylabel('Y');
zlabel('Z');