function [ hist ] = color_histogram( xMin, yMin, xMax, yMax, frame, hist_bin )
%COLOR_HISTOGRAM Perform a color histogram over the image given.
%   The image is given as a frame and the coordinates (x, y) of the left
%   bottom corner of the bounding box as well as its width and height

if yMax > size(frame, 1)
    yMax = size(frame, 1);
end
if xMax > size(frame, 2)
    xMax = size(frame, 2);
end


img = frame(yMin:yMax, xMin:xMax,:);
hist = zeros(hist_bin, size(frame,3));
for i = 1:size(frame,3)
    [hist(:,3), ~] = histcounts(img, hist_bin, 'BinLimits', [0, 255],...
        'Normalization', 'probability');
end
hist = reshape(hist, [1, hist_bin * size(frame, 3)]);