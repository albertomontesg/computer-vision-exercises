function [xyn, XYZn, T, U] = normalization(xy, XYZ)
nb_points = size(xy, 2);

% Data normalization
% First compute centroid
xy_centroid = mean(xy(1:2,:), 2);
XYZ_centroid = mean(XYZ(1:3,:), 2);

% Then, compute scale
d = sum((xy(1:2,:)-xy_centroid*ones(1,nb_points)).*(xy(1:2,:)-xy_centroid*ones(1,nb_points)), 1);
sigma_2d = mean(sqrt(d)) / sqrt(2);
D = sum((XYZ(1:3,:)-XYZ_centroid*ones(1,nb_points)).*(XYZ(1:3,:)-XYZ_centroid*ones(1,nb_points)), 1);
sigma_3d = mean(sqrt(D)) / sqrt(3);

% Create T and U transformation matrices
T = inv([sigma_2d, 0, xy_centroid(1);
        0, sigma_2d, xy_centroid(2);
        0, 0, 1]);
U = inv([sigma_3d, 0, 0, XYZ_centroid(1);
        0, sigma_3d, 0, XYZ_centroid(2);
        0, 0, sigma_3d, XYZ_centroid(3);
        0, 0, 0, 1]);

% And normalize the points according to the transformations
xyn = T * xy;
XYZn = U * XYZ;

end
