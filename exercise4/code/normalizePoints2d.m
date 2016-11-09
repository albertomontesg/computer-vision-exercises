% Normalization of 2d-pts
% Inputs: 
%           x1s = 2d points
% Outputs:
%           nxs = normalized points
%           T = normalization matrix
function [x_n, T] = normalizePoints2d(x)
    centroid = mean(x,2);
    dists = sqrt(sum((x - repmat(centroid,1,size(x,2))).^2,1));
    mean_dist = mean(dists);
    T = [sqrt(2)/mean_dist 0 -sqrt(2)/mean_dist*centroid(1);...
         0 sqrt(2)/mean_dist -sqrt(2)/mean_dist*centroid(2);...
         0 0 1];
    x_n = T * x;
end
