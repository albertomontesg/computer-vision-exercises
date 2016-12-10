function [ peak ] = find_peak( X, x_l, r )
%FIND_PEAK Find the peak of the density function for the given pixel
%   X is the density function
%   x_l pixel information
%   r radius
    n_points = size(X, 1);
    
    % Define tolerance and starting center
    tol = 0.005;
    x_p = x_l;

    while true
        % Compute the distance from the center to all the points
        x_r = repmat(x_l, [n_points, 1]);
        d = sum((X-x_r).^2, 2);
        % Recompute the center from the points closer than r
        x_l = mean(X(d<=r^2,:), 1);
        
        % Check convergence criterion
        if (x_p - x_l) * (x_p - x_l)' < tol^2
            break
        end
        
        % Update the center
        x_p = x_l;
        
    end
    % Return the peak
    peak = x_l;
end

