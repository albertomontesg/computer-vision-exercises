% =========================================================================
% Exercise 4
% =========================================================================

%don't forget to initialize VLFeat
run('~/Documents/MATLAB/libaries/vlfeat-0.9.20/toolbox/vl_setup.m')

%Load images
imgName1 = 'images/ladybug_Rectified_0768x1024_00000064_Cam0.png';
imgName2 = 'images/ladybug_Rectified_0768x1024_00000080_Cam0.png';

img1 = single(rgb2gray(imread(imgName1)));
img2 = single(rgb2gray(imread(imgName2)));

%extract SIFT features and match
[fa, da] = vl_sift(img1);
[fb, db] = vl_sift(img2);
[matches, scores] = vl_ubcmatch(da, db);

%show matches
showFeatureMatches(img1, fa(1:2, matches(1,:)), img2, fb(1:2, matches(2,:)), 20);

% =========================================================================

%run 8-point RANSAC
%[inliers1, inliers2, outliers1, outliers2, M, F] = ransac8pF(fa(1:2, matches(1,:)), fb(1:2, matches(2,:)), 2)

%show inliers and outliers

%show number of iterations needed

%show inlier ratio

%and check the epipolar geometry of the computed F


% =========================================================================