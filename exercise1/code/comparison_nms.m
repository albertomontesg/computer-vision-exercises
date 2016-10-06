% Exercise 1
% Comparison between the corners found before and after the nonmaximal
% supression
close all;

IMG_NAME1 = 'images/I1.jpg';

% read in image
img1 = im2double(imread(IMG_NAME1));

img1 = imresize(img1, 1);

% convert to gray image
imgBW1 = rgb2gray(img1);

% Task 1.1 - extract Harris corners
threshold = 3e-4;
[corners_nms_1, H1] = extractHarrisCorner(imgBW1', threshold);

[r1, c1] = find(H1>threshold);
corners_1 = [r1'; c1'];

showImageWithCorners(img1, corners_1, 51);
%print('../report/images/harris_nms_before', '-dpng', '-f51')
showImageWithCorners(img1, corners_nms_1, 52);
%print('../report/images/harris_nms_after', '-dpng', '-f52')

