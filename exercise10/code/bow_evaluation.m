%
% IMAGE CATEGORIZATION EXERCISE
% Alberto Montes, Computer Vision 2016
%

% training
rng(23);
disp('Creating codebook');
sizeCodebook = 200;
numIterations = 10;
vCenters = create_codebook('../data/cars-training-pos',sizeCodebook,numIterations);
% keyboard;
disp('Processing positive training images');
vBoWPos = create_bow_histograms('../data/cars-training-pos',vCenters);
disp('Processing negative training images');
vBoWNeg = create_bow_histograms('../data/cars-training-neg',vCenters);
%vBoWPos_test = vBoWPos;
%vBoWNeg_test = vBoWNeg;
% keyboard;
disp('Processing positive testing images');
vBoWPos_test = create_bow_histograms('../data/cars-testing-pos',vCenters);
disp('Processing negative testing images');
vBoWNeg_test = create_bow_histograms('../data/cars-testing-neg',vCenters);

nrPos = size(vBoWPos_test,1);
nrNeg = size(vBoWNeg_test,1); 

test_histograms = [vBoWPos_test;vBoWNeg_test];
labels = [ones(nrPos,1);zeros(nrNeg,1)];

disp('______________________________________')
disp('Nearest Neighbor Classifier')
bow_recognition_multi(test_histograms, labels, vBoWPos, vBoWNeg, @bow_recognition_nearest);
disp('______________________________________')

disp('Bayesian Classifier')
bow_recognition_multi(test_histograms, labels, vBoWPos, vBoWNeg, @bow_recognition_bayes);
disp('______________________________________')
