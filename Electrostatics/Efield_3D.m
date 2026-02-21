function [Ex, Ey, Ez] = Efield_3D(obs, rho_fun, x_lim, y_lim, z_lim, N)

epsilon0 = 8.854e-12;

%Discretisation
x = linspace(x_lim(1), x_lim(2), N);
y = linspace(y_lim(1), y_lim(2), N);
z = linspace(z_lim(1), z_lim(2), N);

%Differential elements
dx = x(2) - x(1);
dy = y(2) - y(1);
dz = z(2) - z(1);
dV = dx * dy * dz;

[X, Y, Z] = meshgrid(x, y, z);
xq = X(:)';
yq = Y(:)';
zq = Z(:)';

%Charge
rho = rho_fun(xq, yq, zq);          
dq = rho .* dV;                     

%Obs points
xo = obs(:,1);
yo = obs(:,2);
zo = obs(:,3);

%Distances
Rx = xo - xq;    
Ry = yo - yq;
Rz = zo - zq;
R = sqrt(Rx.^2 + Ry.^2 + Rz.^2) + 1e-12;

%Integrating (approximately by Riemann)
coef = 1 / (4 * pi * epsilon0);

Ex = coef * sum(dq .* (Rx ./ R.^3), 2);
Ey = coef * sum(dq .* (Ry ./ R.^3), 2);
Ez = coef * sum(dq .* (Rz ./ R.^3), 2);
end