function [ map, peaks ] = mean_shift( X, r )
%mean_shift Mean-shift algorithm
%   
    DEBUG = true;
    nPoints = size(X, 1);
    
    % Compute the peaks for each point
    peaks = zeros(nPoints, 3);
    for i = 1:nPoints
        peaks(i,:) = find_peak(X, X(i,:), r);
    end
    
    % Merge the peaks closer a distance less than r/2
    if DEBUG
        figure, plot3(X(:,1), X(:,2), X(:,3), '.r',...
            peaks(:,1), peaks(:,2), peaks(:,3), 'xg');
    end
    
    map = zeros(size(X,1), 1);
    peaks = 0;

end
