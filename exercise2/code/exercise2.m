% Exervice 2
%
close all;
global IMG_NAME;
IMG_NAME = 'images/image002.jpg';

%This function displays the calibration image and allows the user to click
%in the image to get the input points. Left click on the chessboard corners
%and type the 3D coordinates of the clicked points in to the input box that
%appears after the click. You can also zoom in to the image to get more
%precise coordinates. To finish use the right mouse button for the last
%point.
%You don't have to do this all the time, just store the resulting xy and
%XYZ matrices and use them as input for your algorithms.
% [xy, XYZ] = getpoints(IMG_NAME);
load('points_002.mat')

% === Task 2 DLT algorithm ===

[K, R, t, error] = runDLT(xy, XYZ);
display('error DLT:')
display(error);
print('../report/images/DLT_reprojected', '-djpeg90', '-f1')

% === Task 3 Gold Standard algorithm ===

[K, R, t, error] = runGoldStandard(xy, XYZ);
display('error GoldStandard:')
display(error);
print('../report/images/GoldStd_reprojected', '-djpeg90', '-f2')

% === Bonus: Gold Standard algorithm with radial distortion estimation ===

%[K, R, t, error] = runGoldStandardRadial(xy, XYZ);

