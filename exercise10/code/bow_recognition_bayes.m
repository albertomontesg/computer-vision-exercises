function label = bow_recognition_bayes( histogram, vBoWPos, vBoWNeg )


    [muPos, sigmaPos] = computeMeanStd(vBoWPos);
    [muNeg, sigmaNeg] = computeMeanStd(vBoWNeg);

    % Calculating the probability of appearance each word in observed
    % histogram according to normal distribution in each of the positive
    % and negative bag of words.

    P_hist_pos_j = normpdf(histogram, muPos, sigmaPos);
    P_hist_neg_j = normpdf(histogram, muNeg, sigmaNeg);
    % Check if there is any NaN at the generated probability
    P_hist_pos_j(isnan(P_hist_pos_j)) = 1;
    P_hist_neg_j(isnan(P_hist_neg_j)) = 1;
    % Compute the join probability
    P_hist_pos = sum(log(P_hist_pos_j));
    P_hist_neg = sum(log(P_hist_neg_j));
    
    if P_hist_pos > P_hist_neg
        label = 1;
    else
        label = 0;
    end
        
    
end