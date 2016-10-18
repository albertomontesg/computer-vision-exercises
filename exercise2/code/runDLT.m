function [K, R, t, error] = runDLT(xy, XYZ)
global IMG_NAME
if size(xy,2) ~= 3
    xy_ = padarray(xy, [1, 0], 1, 'post');
    XYZ_ = padarray(XYZ, [1, 0], 1, 'post');
end

[xy_n, XYZ_n, T, U] = normalization(xy_, XYZ_);

% Compute DLT
[P_n] = dlt(xy_n, XYZ_n);

% Denormalize camera matrix
P = T \ P_n * U;

[K, R, t] = decompose(P);

% Compute reprojection error
xy_pp = P * XYZ_;
xy_p = xy_pp ./ (ones(3,1)*xy_pp(3,:));
er = xy_(1:2,:) - xy_p(1:2,:);
error = mean(sum(er.^2));

% Display reprojected points
figure(1)
imshow(IMG_NAME)
hold on;
plot(xy(1,:),xy(2,:),'+r');
plot(xy_p(1,:),xy_p(2,:),'ob');

end