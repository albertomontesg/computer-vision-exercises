function [mu, sigma] = computeMeanStd(vBoW)
    %COMPUTEMEANSTD Compute mean and stadart deviation
    
    mu = mean(vBoW, 1);
    sigma = std(vBoW, 1);
end