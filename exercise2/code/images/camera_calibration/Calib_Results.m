% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2878.381810891617079 ; 2870.281574007985910 ];

%-- Principal point:
cc = [ 1259.339783849922924 ; 1472.437156191800568 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.157771338872593 ; -0.274850780438951 ; -0.027134856721037 ; 0.007190782977225 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 46.583884021056349 ; 50.852465978430288 ];

%-- Principal point uncertainty:
cc_error = [ 62.158217016359664 ; 71.234874691483881 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.089103452718634 ; 0.535128637433302 ; 0.011016076688067 ; 0.009489405361836 ; 0.000000000000000 ];

%-- Image size:
nx = 2448;
ny = 3264;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 9;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.626991e+00 ; 1.569603e-02 ; -2.370799e-02 ];
Tc_1  = [ -3.901547e-01 ; 3.821898e-01 ; 1.664716e+00 ];
omc_error_1 = [ 2.521895e-02 ; 8.594791e-03 ; 2.475770e-02 ];
Tc_error_1  = [ 3.677728e-02 ; 4.281918e-02 ; 2.531148e-02 ];

%-- Image #2:
omc_2 = [ NaN ; NaN ; NaN ];
Tc_2  = [ NaN ; NaN ; NaN ];
omc_error_2 = [ NaN ; NaN ; NaN ];
Tc_error_2  = [ NaN ; NaN ; NaN ];

%-- Image #3:
omc_3 = [ 2.739647e+00 ; 3.643311e-01 ; -1.598301e-01 ];
Tc_3  = [ -3.798496e-01 ; 3.967582e-01 ; 1.703426e+00 ];
omc_error_3 = [ 2.537154e-02 ; 8.532612e-03 ; 2.528907e-02 ];
Tc_error_3  = [ 3.770740e-02 ; 4.353443e-02 ; 2.509913e-02 ];

%-- Image #4:
omc_4 = [ 2.380975e+00 ; 3.780500e-01 ; 9.649039e-01 ];
Tc_4  = [ -7.007891e-02 ; 8.726190e-02 ; 1.129716e+00 ];
omc_error_4 = [ 2.791395e-02 ; 1.259654e-02 ; 2.518849e-02 ];
Tc_error_4  = [ 2.467447e-02 ; 2.810285e-02 ; 2.106632e-02 ];

%-- Image #5:
omc_5 = [ 2.765495e+00 ; 9.665419e-03 ; -5.024097e-01 ];
Tc_5  = [ -1.476819e-01 ; 5.150036e-01 ; 2.291157e+00 ];
omc_error_5 = [ 2.636548e-02 ; 9.111489e-03 ; 3.374110e-02 ];
Tc_error_5  = [ 5.036930e-02 ; 5.723813e-02 ; 3.270764e-02 ];

%-- Image #6:
omc_6 = [ -2.511027e+00 ; -2.574536e-01 ; -9.865210e-01 ];
Tc_6  = [ -3.758669e-01 ; 5.276979e-01 ; 1.565512e+00 ];
omc_error_6 = [ 2.235928e-02 ; 1.679938e-02 ; 3.133024e-02 ];
Tc_error_6  = [ 3.451920e-02 ; 3.904984e-02 ; 2.476478e-02 ];

%-- Image #7:
omc_7 = [ 2.500410e+00 ; -1.028538e-03 ; -5.410972e-01 ];
Tc_7  = [ -3.470669e-01 ; 3.078055e-01 ; 1.303116e+00 ];
omc_error_7 = [ 2.355239e-02 ; 1.294617e-02 ; 2.552581e-02 ];
Tc_error_7  = [ 2.810785e-02 ; 3.303754e-02 ; 1.832015e-02 ];

%-- Image #8:
omc_8 = [ 2.192368e+00 ; 1.167891e+00 ; -8.421080e-01 ];
Tc_8  = [ -6.395784e-01 ; -9.484617e-02 ; 1.856924e+00 ];
omc_error_8 = [ 1.912228e-02 ; 2.352586e-02 ; 2.312718e-02 ];
Tc_error_8  = [ 3.941914e-02 ; 4.744046e-02 ; 2.446054e-02 ];

%-- Image #9:
omc_9 = [ 2.573747e+00 ; 1.121750e-01 ; 2.022957e-01 ];
Tc_9  = [ -3.039949e-01 ; 1.405949e-01 ; 1.793839e+00 ];
omc_error_9 = [ 2.561983e-02 ; 9.519441e-03 ; 2.573439e-02 ];
Tc_error_9  = [ 3.911293e-02 ; 4.517443e-02 ; 2.848306e-02 ];

