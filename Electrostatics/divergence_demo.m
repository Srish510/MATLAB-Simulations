%% To display the divergence of a radial field

% Grid
[x,y] = meshgrid(-2:0.2:2, -2:0.2:2);
r2 = x.^2 + y.^2 + 1e-6;   

% Radial field
Fx = x ./ r2;
Fy = y ./ r2;

% Plot vector field
figure;
quiver(x,y,Fx,Fy,'k');
axis equal;
title('Radial Field');
xlabel('x'); ylabel('y');

% Compute divergence
divF = divergence(x,y,Fx,Fy);

% Plot divergence
figure;
imagesc([-2 2],[-2 2],divF);
axis xy equal;
colorbar;
title('Divergence');
xlabel('x'); ylabel('y');