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
%%
figure(30)
showMatchedFeatures(img1, img2, fa(1:2,matches(1,:))', fb(1:2,matches(2,:))', 'blend');

%% ========================================================================

%run 8-point RANSAC
[inliers1, inliers2, outliers1, outliers2, M, F] = ransac8pF(fa(1:2, matches(1,:)), fb(1:2, matches(2,:)), .1);

%show inliers and outliers
[sx, sy, sz] = size(img1);
img = [img1, img2];

in2 = inliers2 + repmat([sy, 0]', [1, size(inliers2, 2)]);
out2 = outliers2 + repmat([sy, 0]', [1, size(outliers2, 2)]);

figure(50), imshow(img, []);    
hold on, plot(inliers1(1,:), inliers1(2,:), '+b');
hold on, plot(in2(1,:), in2(2,:), '+b');
hold on, plot(outliers1(1,:), outliers1(2,:), '+b');
hold on, plot(out2(1,:), out2(2,:), '+b');
hold on, plot([inliers1(1,:); in2(1,:)], [inliers1(2,:); in2(2,:)], 'g');
hold on, plot([outliers1(1,:); out2(1,:)], [outliers1(2,:); out2(2,:)], 'r');    

%show number of iterations needed

%show inlier ratio

%and check the epipolar geometry of the computed F


% =========================================================================