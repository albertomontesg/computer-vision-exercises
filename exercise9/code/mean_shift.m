function [ map, peaks ] = mean_shift( X, r )
%mean_shift Mean-shift algorithm
%   
    DEBUG = true;
    nPoints = size(X, 1);
    
    % Compute the peaks for each point
    peaks = zeros(nPoints, 3);
    map = zeros(nPoints, 1);
    count = 0;
    for i = 1:nPoints
        peak = find_peak(X, X(i,:), r);
        % In case is the first point computed
        if i == 1
            peaks(i,:) = peak;
            continue;
        end
        
        % Compute the distance of the new peak agains all the prev ones
        d = peaks;
        % TODO
        
    end
    
    % Merge the peaks closer a distance less than r/2
    if DEBUG
        figure, plot3(X(:,1), X(:,2), X(:,3), '.r',...
            peaks(:,1), peaks(:,2), peaks(:,3), 'xg');
    end
    
    while true
        
    end
    
    % TODO
    map = zeros(size(X,1), 1);
    peaks = 0;

end
