function sLabel = bow_recognition_nearest(histogram,vBoWPos,vBoWNeg)
    %BOW_RECOGNITION_NEAREST
    % Find the nearest neighbor in the positive and negative sets
    % and decide based on this neighbor
    
    % Compute the distances to the Positive and Negative samples
    dPos = pdist2(histogram, vBoWPos);
    dNeg = pdist2(histogram, vBoWNeg);
    
    % See the shortest distance to each of the samples
    distPos = min(dPos);
    distNeg = min(dNeg);

    % Return the label depending of the shortest distance
    if (distPos < distNeg)
        sLabel = 1;
    else
        sLabel = 0;
    end

end
