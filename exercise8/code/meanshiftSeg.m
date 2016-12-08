function [map, peaks] = meanshiftSeg(img)
    r = 0.03;

    [h, w, c] = size(img);
    X = reshape(img, [h*w, c]);
    X = double(X) / 256;
    size(X)
    [mapP, peaks] = mean_shift(X, r);
    map = reshape(mapP, [h, w]);
%     [map, peaks] = mean_shift(X, r)
end
