function [Ex,Ey,Ez] = Efield_surface(obs, surface_fun, sigma_fun, ...
                                     u_start, u_end, v_start, v_end)
% obs        : Mx3 observation points
% surface_fun: function handle r(u,v) -> [x y z]
% sigma_fun  : function handle σ(u,v)
% u_start, u_end : u limits
% v_start, v_end : v limits
epsilon0 = 8.854e-12;

%Discretization
Nu = 120;
Nv = 120;

%Steps
du = (u_end - u_start) / Nu;
dv = (v_end - v_start) / Nv;

u = linspace(u_start + du/2, u_end - du/2, Nu);
v = linspace(v_start + dv/2, v_end - dv/2, Nv);

[U,V] = meshgrid(u,v);

%Surface Points
r_surface = surface_fun(U,V);   
xq = r_surface(:,1)';
yq = r_surface(:,2)';
zq = r_surface(:,3)';

%Surface Element
ru = (surface_fun(U+du,V) - surface_fun(U-du,V)) / (2*du);
rv = (surface_fun(U,V+dv) - surface_fun(U,V-dv)) / (2*dv);
cross_prod = cross(ru, rv, 2);
dS = vecnorm(cross_prod, 2, 2) * du * dv;

%Charge
sigma = sigma_fun(U,V);
dq = sigma(:)' .* dS';

%Obs points
xo = obs(:,1);
yo = obs(:,2);
zo = obs(:,3);

%Field
Rx = xo - xq;
Ry = yo - yq;
Rz = zo - zq;
R = sqrt(Rx.^2 + Ry.^2 + Rz.^2) + 1e-12;

coef = 1/(4*pi*epsilon0);
Ex = coef * sum(dq .* (Rx ./ R.^3), 2);
Ey = coef * sum(dq .* (Ry ./ R.^3), 2);
Ez = coef * sum(dq .* (Rz ./ R.^3), 2);
end