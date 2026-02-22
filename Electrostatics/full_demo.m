%% To display the divergence and curl of a vector field

% 3D grid 
[x,y,z] = meshgrid(-2:0.2:2, -2:0.2:2, -0.1:0.1:0.1);

r2 = x.^2 + y.^2 + 1e-6;

% Field
Fx = x./r2 - y;
Fy = y./r2 + x;
Fz = zeros(size(x));

mid = ceil(size(z,3)/2);

% Plot vector field
figure;
quiver(x(:,:,mid), y(:,:,mid), Fx(:,:,mid), Fy(:,:,mid));
axis equal tight;
title('Combined Field');
xlabel('x'); ylabel('y');

% Divergence
divF = divergence(x,y,z,Fx,Fy,Fz);

figure;
imagesc([-2 2],[-2 2], divF(:,:,mid));
axis xy equal;
colorbar;
title('Divergence');

% Curl
[curlx, curly, curlz] = curl(x,y,z,Fx,Fy,Fz);

figure;
imagesc([-2 2],[-2 2], curlz(:,:,mid));
axis xy equal;
colorbar;
title('Curl (z-component)');