function [K, R, t, error] = runDLT(xy, XYZ)

% Normalize data points
nb_points = size(xy, 2);
% 1 Compute centroids
c = mean(xy, 2);
C = mean(XYZ, 2);
% 2 Compute the mean distance of all the points to the centroid
d = sum((xy-c*ones(1,nb_points)).*(xy-c*ones(1,size(xy,2))), 1);
sigma_2d = sqrt(2) / mean(sqrt(d));
D = sum((XYZ-C*ones(1,nb_points)).*(XYZ-C*ones(1,size(XYZ,2))), 1);
sigma_3d = sqrt(3) / mean(sqrt(D));
% 3 Build transformation Matrix
T = [sigma_2d, 0, c(1);
     0, sigma_2d, c(2);
     0, 0, 1];
U = [sigma_3d, 0, 0, C(1);
     0, sigma_3d, 0, C(2);
     0, 0, sigma_3d, C(3);
     0, 0, 0, 1];
% 4 Transform points
xy_normalized = T\[xy;ones(1,nb_points)];
XYZ_normalized = U\[XYZ;ones(1,nb_points)];

% Compute DLT
[P_normalized] = dlt(xy_normalized, XYZ_normalized);

% Denormalize camera matrix
P = T * P_normalized * U;

% Factorize camera matrix in to K, R and t
[inv_R, inv_K] = qr(inv(P(1:3,1:3)));
K = inv(inv_K);
R = inv(inv_R);

% Compute reprojection error

end