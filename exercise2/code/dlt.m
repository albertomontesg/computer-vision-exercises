function [P] = dlt(xy, XYZ)
%computes DLT, xy and XYZ should be normalized before calling this function
nb_points = size(xy, 2);

A = zeros(2*nb_points, 12);

for i = 1:nb_points
    A(i*2-1:i*2,:) = [XYZ(:,i)', zeros(1,4), -XYZ(:,i)'*xy(1,i);
                     zeros(1,4), -XYZ(:,i)', XYZ(:,i)'*xy(2,i)];
end

% SVD
[U, S, V] = svd(A);
P = reshape(V(nb_points,:), 3, 4);