function [map, peaks] = meanshiftSeg(img)
    r = 0.03;

    [h, w, c] = size(img);
    X = reshape(img, [h*w, c]);
    X = double(X) / 256;

    % Apply Mean-Shift Segmentation Algorithm
    [mapP, peaks] = mean_shift(X, r);
    % Reshape the maping to the original image size
    map = reshape(mapP, [h, w]);

end
