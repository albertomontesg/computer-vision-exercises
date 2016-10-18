function [ K, R, t ] = decompose(P)
%decompose P into K, R and t

% Factorize camera matrix in to K, R
[inv_R, inv_K] = qr(inv(P(1:3,1:3)));
K = inv(inv_K);
R = inv(inv_R);
% SVD of P to find the camara center C and then t
[~, ~, V] = svd(P);
C = V(:,end);
t = -R*C(1:3);

end