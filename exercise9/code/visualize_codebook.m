function vCenters = visualize_codebook(vCenters,vFeatures,vPatches,cellWidth,cellHeight)

    patchWidth = 4*cellWidth;
    patchHeight = 4*cellHeight;  

    clusterPatches = zeros(patchHeight,patchWidth,1,0);
    scores = zeros(0,0);

    % Assign all features to its nearest center
    [idx,dist] = findnn(vFeatures,vCenters);

    % For each center
    for i = 1:size(vCenters,1)
        % Count matching features
        matching = find(idx==i);

        if (matching)
            % Find nearest feature to this center
            [~, smallest] = min(dist(matching));
            closestIdx = matching(smallest);

            % Get patch to this feature and store score
            p = reshape(vPatches(closestIdx,:),patchHeight,patchWidth,1);
            clusterPatches(:,:,:,end+1) = p;
            scores(end+1)=length(matching);
        end
    end

    [~, scoreOrder] = sort(scores,'descend');
    clusterPatches=clusterPatches(:,:,:,scoreOrder);

    montage(clusterPatches, 'DisplayRange', []);

end
