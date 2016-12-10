function [ map, peaks ] = mean_shift( X, r )
%MEAN_SHIFT Mean-shift algorithm
%   
    nPoints = size(X, 1);
    
    % Initialize containers to store the peaks and the mapping to clusters
    pointsPeaks = zeros(nPoints, 3) - 1;
    map = zeros(nPoints, 1) - 1;
    cluster = 0; % Initial cluster id

    for i = 1:nPoints
        % Compute the peaks for each point
        peak = find_peak(X, X(i,:), r);
        % Compute the distance of the current peak to the already find ones
        d = sum((pointsPeaks(1:i,:) - repmat(peak, [i, 1])).^2, 2);
        [min_d, min_i] = min(d);
        
        % MERGING PEAKS
        % If the distance to the closest peak is greater than the r/2, the
        % new peak correspond to a new cluster
        if min_d > (r/2)^2
            cluster = cluster + 1;
            map(i) = cluster;
        % If its closer than r/2, fuse both peak to the same cluster
        % assigning the cluster id of the closest peak.
        else
            map(i) = map(min_i);
        end
        
        pointsPeaks(i,:) = peak;
        
    end
    
    % Now for each point with the same mapping, compute the center of the
    % cluster to return it as a peak
    peaks = zeros(cluster, 3);
    for c = 1:cluster
        peaks(c,:) = mean(X(map==c,:), 1);
    end

end
