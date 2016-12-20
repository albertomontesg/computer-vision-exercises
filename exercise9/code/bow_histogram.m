function histo = bow_histogram(vFeatures, vCenters)
    %BOW_HISTOGRAM
    % input:
    %   vFeatures: MxD matrix containing M feature vectors of dim. D
    %   vCenters : NxD matrix containing N cluster centers of dim. D
    % output:
    %   histo    : N-dim. vector containing the resulting BoW
    %              activation histogram.


    % Match all features to the codebook and record the activated
    % codebook entries in the activation histogram "histo".
    N = size(vCenters, 1);
    [~, words] = findnn(vFeatures, vCenters);
    histo = histcounts(words, 1:(N+1));

end
