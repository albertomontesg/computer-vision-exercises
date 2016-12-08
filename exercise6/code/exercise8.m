% =========================================================================
% Exercise 8
% =========================================================================

% Initialize VLFeat (http://www.vlfeat.org/)
% add folder to path and call vl_setup;
clear all;
run('~/Documents/MATLAB/libaries/vlfeat-0.9.20/toolbox/vl_setup.m')

%K Matrix for house images (approx.)
K = [  670.0000     0     393.000
         0       670.0000 275.000
         0          0        1];

%Load images
imgName1 = '../data/house.000.pgm';
imgName2 = '../data/house.004.pgm';

img1 = single(imread(imgName1));
img2 = single(imread(imgName2));

%extract SIFT features and match
[fa, da] = vl_sift(img1);
[fb, db] = vl_sift(img2);

%don't take features at the top of the image - only background
filter = fa(2,:) > 100;
fa = fa(:,filter);
da = da(:,filter);

[matches, scores] = vl_ubcmatch(da, db);

showFeatureMatches(img1, fa(1:2, matches(1,:)), img2, fb(1:2, matches(2,:)), 20);

%% Compute essential matrix and projection matrices and triangulate matched points

% use 8-point ransac or 5-point ransac - compute (you can also optimize it to get best possible results)
% and decompose the essential matrix and create the projection matrices
t_F = 0.05;
[F, inliers_1] = ransacfitfundmatrix(fa(1:2, matches(1,:)), fb(1:2, matches(2,:)), t_F);

x1_normalized = K \ makehomogeneous(fa(1:2, matches(1, inliers_1)));
x2_normalized = K \ makehomogeneous(fb(1:2, matches(2, inliers_1)));

showFeatureInliers(img1, fa(1:2, matches(1,:)), img2, fb(1:2,matches(2,:)), inliers_1, 21);
E = K' * F * K;

Ps{1} = eye(4);
Ps{2} = decomposeE(E, x1_normalized, x2_normalized);

%triangulate the inlier matches with the computed projection matrix
[Xs{1}, ~] = linearTriangulation(Ps{1}, x1_normalized, Ps{2}, x2_normalized);

%% Add an addtional view of the scene 

imgName3 = '../data/house.001.pgm';
img3 = single(imread(imgName3));
[fc, dc] = vl_sift(img3);

%match against the features from image 1 that where triangulated
fa_in = fa(:, matches(1,inliers_1));
da_in = da(:, matches(1,inliers_1));
[matches_2, ~] = vl_ubcmatch(da_in, dc);

% run 6-point RANSAC
x3n = K \ makehomogeneous(fc(1:2,matches_2(2,:)));
X_3 = Xs{1}(:, matches_2(1,:));
t_F = 0.01;
[Ps{3}, inliers_2] = ransacfitprojmatrix(x3n, X_3, t_F);
showFeatureInliers(img1, fa_in(1:2, matches_2(1,:)), img3, fc(1:2,matches_2(2,:)), inliers_2, 22);

%triangulate the inlier matches with the computed projection matrix
x1n = K \ makehomogeneous(fa_in(1:2,matches_2(1,:)));
[Xs{2}, ~] = linearTriangulation(Ps{1}, x1n(:,inliers_2), Ps{3}, x3n(:,inliers_2));

%% Add more views... 1

imgName4 = '../data/house.002.pgm';
img4 = single(imread(imgName4));
[fd, dd] = vl_sift(img4);

% match against the features from image 1 that where triangulated
[matches_3, ~] = vl_ubcmatch(da(:, matches(1,inliers_1)), dd);

% run 6-point RANSAC
x4n = K \ makehomogeneous(fd(1:2,matches_3(2,:)));
x1n = K \ makehomogeneous(fa_in(1:2,matches_3(1,:)));
t_F = 0.02;
[Ps{4}, inliers_3] = ransacfitprojmatrix(x4n, Xs{1}(:, matches_3(1,:)), t_F);
showFeatureInliers(img1, fa_in(1:2, matches_3(1,:)), img4, fd(1:2,matches_3(2,:)), inliers_3, 23);
%triangulate the inlier matches with the computed projection matrix
x4_normalized = x4n(:, inliers_3);
[Xs{3}, ~] = linearTriangulation(Ps{1}, x1n(:,inliers_3), ...
    Ps{4}, x4n(:,inliers_3));


%% Add more views...2

imgName5 = '../data/house.003.pgm';
img5 = single(imread(imgName5));
[fe, de] = vl_sift(img5);

%match against the features from image 1 that where triangulated
[matches_4, ~] = vl_ubcmatch(da(:, matches(1,inliers_1)), de);

% run 6-point RANSAC
x5n = K \ makehomogeneous(fe(1:2,matches_4(2,:)));
x1n = K \ makehomogeneous(fa_in(1:2,matches_4(1,:)));
t_F = 0.02;
[Ps{5}, inliers_4] = ransacfitprojmatrix(x5n, Xs{1}(:, matches_4(1,:)), t_F);
showFeatureInliers(img1, fa_in(1:2, matches_4(1,:)), img5, fe(1:2,matches_4(2,:)), inliers_4, 24);

%triangulate the inlier matches with the computed projection matrix
[Xs{4}, ~] = linearTriangulation(Ps{1}, x1n(:,inliers_4), ...
    Ps{5}, x5n(:,inliers_4));


%% Plot stuff

fig = 10;
figure(fig);

%use plot3 to plot the triangulated 3D points
plot3(Xs{1}(1,:), Xs{1}(2,:), Xs{1}(3,:), '*r');
hold on; plot3(Xs{2}(1,:), Xs{2}(2,:), Xs{2}(3,:), '*b');
hold on; plot3(Xs{3}(1,:), Xs{3}(2,:), Xs{3}(3,:), '*g');
hold on; plot3(Xs{4}(1,:), Xs{4}(2,:), Xs{4}(3,:), '*y');
% plot3(Xs{1}(1,:), Xs{1}(2,:), Xs{1}(3,:), '*r',...
%      Xs{2}(1,:), Xs{2}(2,:), Xs{2}(3,:), '*b',...
%      Xs{3}(1,:), Xs{3}(2,:), Xs{3}(3,:), '*g',...
%      Xs{4}(1,:), Xs{4}(2,:), Xs{4}(3,:), '*y')

%draw cameras
drawCameras(Ps, fig);
axis([-1 1 -1 1 0 2]);

%% Dense Reconstruction

