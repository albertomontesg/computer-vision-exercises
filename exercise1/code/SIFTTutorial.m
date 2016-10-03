% SIFT Tutorial
%
close all;

IMG_NAME1 = 'images/I1.jpg';
IMG_NAME2 = 'images/I2.jpg';

% Read in image
img1 = im2double(imread(IMG_NAME1));
img2 = im2double(imread(IMG_NAME2));

img1 = imresize(img1, 1);
img2 = imresize(img2, 1);

% Convert to gray image
imgBW1 = rgb2gray(img1);
imgBW2 = rgb2gray(img2);

[f1, d1] = vl_sift(single(imgBW1));
[f2, d2] = vl_sift(single(imgBW2));

perm1 = randperm(size(f1,2));
perm2 = randperm(size(f2,2));
sel1 = perm1(1:300);
sel2 = perm2(1:300);

showImageWithSIFT(imgBW1, f1(:,sel1), 31);
showImageWithSIFT(imgBW2, f2(:,sel2), 32);

% Compute the matches of the SIFT descriptors
[matches, scores] = vl_ubcmatch(d1, d2);
matches_s = matches(:,scores>5E4);
showFeatureMatches(img1, f1(1:2, matches_s(1,:)), img2, f2(1:2, matches_s(2,:)), 40);