function [ hist ] = color_histogram( xMin, yMin, xMax, yMax, frame, hist_bin )
%COLOR_HISTOGRAM Perform a color histogram over the image given.
%   The image is given as a frame and the coordinates (x, y) of the left
%   bottom corner of the bounding box as well as its width and height

yMax = min(round(yMax), size(frame, 1));
yMin = max(round(yMin), 1);
xMax = min(round(xMax), size(frame, 2));
xMin = max(round(xMin), 1);

img = frame(yMin:yMax,xMin:xMax,:);
hist = zeros(hist_bin, size(frame, 3));
for i = 1:size(frame, 3)
    [hist(:,i), ~] = histcounts(img(:,:,i), hist_bin, 'BinLimits', [0, 255],...
        'Normalization', 'probability');
end
hist = reshape(hist, [1, hist_bin * size(frame, 3)]);
