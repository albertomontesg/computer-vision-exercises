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
fa = fa(:,find(filter));
da = da(:,find(filter));

[matches, scores] = vl_ubcmatch(da, db);

showFeatureMatches(img1, fa(1:2, matches(1,:)), img2, fb(1:2, matches(2,:)), 20);

%% Compute essential matrix and projection matrices and triangulate matched points

% use 8-point ransac or 5-point ransac - compute (you can also optimize it to get best possible results)
% and decompose the essential matrix and create the projection matrices
t_F = 0.001;
[F, inliers1] = ransacfitfundmatrix(fa(1:2, matches(1,:)), fb(1:2, matches(2,:)), t_F);

x1 = fa(1:2, matches(1, inliers1));
x2 = fb(1:2, matches(2, inliers1));
x1s = makehomogeneous(x1);
x2s = makehomogeneous(x2);
x1_normalized = K \ x1s;
x2_normalized = K \ x2s;

showFeatureMatches(img1, x1, img2, x2, 21);
E = K' * F * K;

Ps{1} = eye(4);
Ps{2} = decomposeE(E, x1_normalized, x2_normalized);

%triangulate the inlier matches with the computed projection matrix
[Xs{1}, err] = linearTriangulation(Ps{1}, x1_normalized, Ps{2}, x2_normalized);

%% Add an addtional view of the scene 

imgName3 = '../data/house.002.pgm';
img3 = single(imread(imgName3));
[fc, dc] = vl_sift(img3);

%match against the features from image 1 that where triangulated
da3 = da(:, matches(1, inliers1));
fa3 = fa(:, matches(1, inliers1));
[matches2, ~] = vl_ubcmatch(da3, dc);


[F_3, inliers2] = ransacfitfundmatrix(fa3(1:2, matches2(1,:)), fc(1:2, matches2(2,:)), t_F);

x1_3 = fa3(1:2, matches2(1, inliers2));
x3 = fc(1:2, matches2(2, inliers2));
x1s_3 = makehomogeneous(x1_3);
x3s = makehomogeneous(x3);
x1_normalized_3 = K \ x1s_3;
x3_normalized = K \ x3s;

showFeatureMatches(img1, x1_3, img3, x3, 22);

E_3 = K' * F_3 * K;
%run 6-point ransac
Ps{3} = decomposeE(E_3, x1_normalized_3, x3_normalized);

%triangulate the inlier matches with the computed projection matrix
[Xs{2}, err] = linearTriangulation(Ps{1}, x1_normalized_3, Ps{3}, x3_normalized);

%% Add more views... 1

imgName4 = '../data/house.003.pgm';
img4 = single(imread(imgName4));
[fd, dd] = vl_sift(img4);

%match against the features from image 1 that where triangulated
da4 = da(:, matches(1, inliers1));
fa4 = fa(:, matches(1, inliers1));
[matches3, ~] = vl_ubcmatch(da4, dd);


[F_4, inliers3] = ransacfitfundmatrix(fa4(1:2, matches3(1,:)), fd(1:2, matches3(2,:)), t_F);

x1_4 = fa4(1:2, matches3(1, inliers3));
x4 = fd(1:2, matches3(2, inliers3));
x1s_4 = makehomogeneous(x1_4);
x4s = makehomogeneous(x4);
x1_normalized_4 = K \ x1s_4;
x4_normalized = K \ x4s;

showFeatureMatches(img1, x1_4, img3, x4, 23);

E_4 = K' * F_4 * K;
%run 6-point ransac
Ps{4} = decomposeE(E_4, x1_normalized_4, x4_normalized);

%triangulate the inlier matches with the computed projection matrix
[Xs{3}, err] = linearTriangulation(Ps{1}, x1_normalized_3, Ps{3}, x3_normalized);

%% Add more views...2

imgName3 = '../data/house.002.pgm';
img3 = single(imread(imgName3));
[fc, dc] = vl_sift(img3);

%match against the features from image 1 that where triangulated
da3 = da(:, matches(1, inliers1));
fa3 = fa(:, matches(1, inliers1));
[matches2, ~] = vl_ubcmatch(da3, dc);


[F_3, inliers2] = ransacfitfundmatrix(fa3(1:2, matches2(1,:)), fc(1:2, matches2(2,:)), t_F);

x1_3 = fa3(1:2, matches2(1, inliers2));
x3 = fc(1:2, matches2(2, inliers2));
x1s_3 = makehomogeneous(x1_3);
x3s = makehomogeneous(x3);
x1_normalized_3 = K \ x1s_3;
x3_normalized = K \ x3s;

showFeatureMatches(img1, x1_3, img3, x3, 22);

E_3 = K' * F_3 * K;
%run 6-point ransac
Ps{3} = decomposeE(E_3, x1_normalized_3, x3_normalized);

%triangulate the inlier matches with the computed projection matrix
[Xs{2}, err] = linearTriangulation(Ps{1}, x1_normalized_3, Ps{3}, x3_normalized);



%% Plot stuff

fig = 10;
figure(fig);

%use plot3 to plot the triangulated 3D points
plot3(Xs{1}(1,:), Xs{1}(2,:), Xs{1}(3,:), '.r')
% plot3(Xs{1}(1,:), Xs{1}(2,:), Xs{1}(3,:), '.r',...
%     Xs{2}(1,:), Xs{2}(2,:), Xs{2}(3,:), '.b',...
%     Xs{3}(1,:), Xs{3}(2,:), Xs{3}(3,:), '.g');

%draw cameras
drawCameras(Ps, fig);
%axis([-1 1 -1 1 0 2]);
