% Compute the fundamental matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences
%
% Output
% 	Fh 			Fundamental matrix with the det F = 0 constraint
% 	F 			Initial fundamental matrix obtained from the eight point algorithm
%
function [Fh, F] = fundamentalMatrix(x1s, x2s)

    [x1n, T1] = normalizePoints2d(x1s);
    [x2n, T2] = normalizePoints2d(x2s);
        
    W = [ repmat(x2n(1,:)',1,3) .* x1n', repmat(x2n(2,:)',1,3) .* x1n', x1n(1:3,:)'];
    [~, ~, V] = svd(W);
    F = reshape(V(:,end),3,3)';

    [u, s, v] = svd(F);
    Fh = T2' * u * diag([s(1) s(5) 0]) * v' * T1;
end