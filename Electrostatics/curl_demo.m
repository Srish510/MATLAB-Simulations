%% To display the divergence of a rotational field

% Grid
[x,y,z] = meshgrid(-2:0.2:2, -2:0.2:2, -0.1:0.1:0.1);

r2 = x.^2 + y.^2;

% Field
Fx = -y .* exp(-r2);
Fy =  x .* exp(-r2);
Fz = zeros(size(x));

mid = ceil(size(z,3)/2);

% Plot vector field
figure;
quiver(x(:,:,mid), y(:,:,mid), Fx(:,:,mid), Fy(:,:,mid), 'b');
axis equal tight;
title('Rotational Field');
xlabel('x'); ylabel('y');

% Compute curl
[curlx, curly, curlz] = curl(x,y,z,Fx,Fy,Fz);

% Plot curl
figure;
imagesc([-2 2],[-2 2], curlz(:,:,mid));
axis xy equal;
colorbar;
title('Non-Uniform Curl (z-component)');
xlabel('x'); ylabel('y');