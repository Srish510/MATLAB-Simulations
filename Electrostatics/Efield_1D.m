function [Ex,Ey,Ez] = Efield_1D(obs, curve, lambda_fun, t_start, t_end)

epsilon0 = 8.854e-12;

%Discretisation
N = 600;                         
s = linspace(t_start, t_end, N); % FIX: Now uses dynamic boundaries
ds = s(2)-s(1);

%Curve positions
r_curve = curve(s);              

%Charge and charge density
lambda = lambda_fun(s);          
dq = lambda * ds;                

%Charge points
xq = r_curve(:,1)';
yq = r_curve(:,2)';
zq = r_curve(:,3)';

%Obs points
xo = obs(:,1);
yo = obs(:,2);
zo = obs(:,3);

%Distances
Rx = xo - xq;    
Ry = yo - yq;
Rz = zo - zq;
R = sqrt(Rx.^2 + Ry.^2 + Rz.^2) + 1e-12;

%Integrating (approximately)
coef = 1/(4*pi*epsilon0);
Ex = coef * sum(dq .* (Rx ./ R.^3), 2);
Ey = coef * sum(dq .* (Ry ./ R.^3), 2);
Ez = coef * sum(dq .* (Rz ./ R.^3), 2);
end