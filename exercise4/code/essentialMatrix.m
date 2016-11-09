% Compute the essential matrix using the eight point algorithm
% Input
% 	x1s, x2s 	Point correspondences 3xn matrices
%
% Output
% 	Eh 			Essential matrix with the det E = 0 constraint and the constraint that the first two singular values are equal
% 	E 			Initial essential matrix obtained from the eight point algorithm
%

function [Eh, E] = essentialMatrix(x1s, x2s)
        
    W = [ repmat(x2s(1,:)',1,3) .* x1s', repmat(x2s(2,:)',1,3) .* x1s', x1s(1:3,:)'];
    [~, ~, V] = svd(W);
    E = reshape(V(:,end),3,3)';

    [u, s, v] = svd(E);
    r = s(1); s = s(5);
    Eh = u * diag([(r+s)/2, (r+s)/2, 0]) * v';

end