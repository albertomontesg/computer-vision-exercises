function [n] = nTrialNeeded(inlierRation,nSamples,desiredConfidence)
    n = log(1-desiredConfidence) / log(1-inlierRation^nSamples);
end