function [xyn, XYZn, T, U] = normalization(xy, XYZ)

%data normalization
%first compute centroid
xy_centroid = [];
XYZ_centroid = [];

%then, compute scale

%create T and U transformation matrices
T = [];
U = [];

%and normalize the points according to the transformations
xyn = [];
XYZn = [];

end