function vCenters = kmeans(vFeatures,k,numiter)

    nPoints  = size(vFeatures, 1);

    % Initialize each cluster center to a different random point.
    cIdx = randsample(1:nPoints, k);
    vCenters = vFeatures(cIdx,:);

    % Repeat for numiter iterations
    for i=1:numiter,
        % Assign each point to the closest cluster
        [~, clusters] = findnn(vFeatures, vCenters);

        % Shift each cluster center to the mean of its assigned points
        for j=1:k
            % Get all the points from the 'j' cluster
            clusterPoints = vFeatures(clusters==j,:);
            % Recompute the cluster center
            vCenters(j,:) = mean(clusterPoints, 1);
        end

        disp(strcat(num2str(i),'/',num2str(numiter),' iterations completed.'));
    end;

 
end
