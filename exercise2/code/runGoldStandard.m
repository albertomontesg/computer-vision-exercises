function [K, R, t, error] = runGoldStandard(xy, XYZ)
global IMG_NAME;
%normalize data points
xy_ = padarray(xy, [1, 0], 1, 'post');
XYZ_ = padarray(XYZ, [1, 0], 1, 'post');

[xy_n, XYZ_n, T, U] = normalization(xy_, XYZ_);

%compute DLT
[P_n] = dlt(xy_n, XYZ_n);

%minimize geometric error
pn = [P_n(1,:) P_n(2,:) P_n(3,:)];
for i=1:20
    [pn] = fminsearch(@fminGoldStandard, pn, [], xy_n, XYZ_n, i/5);
end

% Denormalize camera matrix
P_n = [pn(1:4);pn(5:8);pn(9:12)];
P = T \ P_n * U;

% Factorize camera matrix in to K, R and t
[K, R, t] = decompose(P);

% Compute reprojection error
xy_pp = P * XYZ_;
xy_p = xy_pp ./ (ones(3,1)*xy_pp(3,:));
er = xy_(1:2,:) - xy_p(1:2,:);
error = mean(sum(er.^2));

figure(2)
imshow(IMG_NAME)
hold on;
plot(xy(1,:),xy(2,:),'+r');
plot(xy_p(1,:),xy_p(2,:),'ob');

end