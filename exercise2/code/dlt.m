function [P] = dlt(xy, XYZ)
%computes DLT, xy and XYZ should be normalized before calling this function
A = zeros(2*size(xy, 2), 12);

for i = 1:size(xy,2)
    A(i*2-1:i*2,:) = [XYZ(:,i)', zeros(1,4), -XYZ(:,i)'*xy(1,i);
                     zeros(1,4), -XYZ(:,i)', XYZ(:,i)'*xy(2,i)];
end

% SVD
[~, ~, V] = svd(A);
P = reshape(V(:,end), 4, 3)';

end