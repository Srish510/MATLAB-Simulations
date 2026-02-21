[x,y,z] = meshgrid(-2:0.7:2, -2:0.7:2, -1.5:0.7:1.5);
obs = [x(:), y(:), z(:)];

%Mobius parameters
R_major = 1.2;  
w = 0.4;        

surface_fun = @(u,v) [ ...
    (R_major + v(:).*cos(u(:)/2)) .* cos(u(:)), ...
    (R_major + v(:).*cos(u(:)/2)) .* sin(u(:)), ...
    v(:).*sin(u(:)/2) ];

sigma_fun = @(u,v) ones(numel(u), 1) * 1e-6;

%Field
[Ex, Ey, Ez] = Efield_surface(obs, surface_fun, sigma_fun, ...
                              0, 2*pi, -w, w);

Ex = reshape(Ex, size(x));
Ey = reshape(Ey, size(y));
Ez = reshape(Ez, size(z));

%Normalize
mag = sqrt(Ex.^2 + Ey.^2 + Ez.^2);
Ex_norm = Ex ./ (2 + mag);
Ey_norm = Ey ./ (2 + mag);
Ez_norm = Ez ./ (2 + mag);

%Plot
Nu_plot = 80;
Nv_plot = 40;
u_p = linspace(0, 2*pi, Nu_plot);
v_p = linspace(-w, w, Nv_plot);
[Up, Vp] = meshgrid(u_p, v_p);
Xsurf = (R_major + Vp.*cos(Up/2)) .* cos(Up);
Ysurf = (R_major + Vp.*cos(Up/2)) .* sin(Up);
Zsurf = Vp.*sin(Up/2);

figure;
quiver3(x,y,z, Ex_norm, Ey_norm, Ez_norm); 
hold on;

surf(Xsurf, Ysurf, Zsurf);

grid on;
axis equal;
title('Electric Field of Charged Mobius Strip');
xlabel('X');
ylabel('Y');
zlabel('Z');