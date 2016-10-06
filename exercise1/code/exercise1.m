% Exercise 1
%
close all;

IMG_NAME1 = 'images/I1.jpg';
IMG_NAME2 = 'images/I2.jpg';

% read in image
img1 = im2double(imread(IMG_NAME1));
img2 = im2double(imread(IMG_NAME2));

img1 = imresize(img1, 1);
img2 = imresize(img2, 1);

% convert to gray image
imgBW1 = rgb2gray(img1);
imgBW2 = rgb2gray(img2);

% Task 1.1 - extract Harris corners
[corners1, H1] = extractHarrisCorner(imgBW1', 4e-4);
[corners2, H2] = extractHarrisCorner(imgBW2', 4e-4);

% show images with Harris corners
showImageWithCorners(img1, corners1, 10);
showImageWithCorners(img2, corners2, 11);
print('../report/images/corners1','-djpeg90','-f10')
print('../report/images/corners2','-djpeg90','-f11')

% Task 1.2 - extract your own descriptors
descr1 = extractDescriptor(corners1, imgBW1');
descr2 = extractDescriptor(corners2, imgBW2');

% Task 1.3 - match the descriptors
matches = matchDescriptors(descr1, descr2, .08);

showFeatureMatches(img1, corners1(:, matches(1,:)), img2, corners2(:, matches(2,:)), 20);
print('../report/images/matching_harris', '-djpeg90', '-f20', '-bestfit')