%Grid Setup
[x,y,z] = meshgrid(-2:0.5:2, -2:0.5:2, -2:1:2);
obs = [x(:), y(:), z(:)];

%Curve Equation
L = 2;  %Length

curve = @(s) [ zeros(length(s),1), ...
               zeros(length(s),1), ...
              (-L/2 + L*s)' ];

%Charge Density
lambda_fun = @(s) 1e-9*(1 + 0*s);

%Field 
[Ex,Ey,Ez] = Efield_1D(obs, curve, lambda_fun, 0, 200);

Ex = reshape(Ex, size(x));
Ey = reshape(Ey, size(y));
Ez = reshape(Ez, size(z));

% Normalize Field
mag = sqrt(Ex.^2 + Ey.^2 + Ez.^2);
Ex = Ex ./ (2 + mag);
Ey = Ey ./ (2 + mag);
Ez = Ez ./ (2 + mag);

s_plot = linspace(0,1,800);
r_plot = curve(s_plot);

x_curve = r_plot(:,1);
y_curve = r_plot(:,2);
z_curve = r_plot(:,3);

%Plot curve and field
figure 
quiver3(x,y,z,Ex,Ey,Ez)
hold on

plot3(x_curve, y_curve, z_curve, ...
      'red', 'LineWidth', 3)

grid on
axis equal
alpha(0.2)
title('Electric Field of St. Line (Simulated)')
xlabel('X')
ylabel('Y')

zlabel('Z')
