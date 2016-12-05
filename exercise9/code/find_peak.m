function [ peak ] = find_peak( X, x_l, r )
%FIND_PEAK Find the peak of the density function for the given pixel
%   X is the density function
%   x_l pixel information
%   r radius
    DEBUG = false;
    n_points = size(X, 1);
    
    if DEBUG
        figure, plot3(X(:,1), X(:,2), X(:,3), '.r');
    end
    th = 0.005;
    x_p = x_l;

    while true
        if DEBUG
            hold on, plot3(x_p(1), x_p(2), x_p(3), 'gx');
        end
        x_r = repmat(x_l, [n_points, 1]);
        d = sum((X-x_r).^2, 2);
        x_l = mean(X(d<=r^2,:), 1);
        
        if (x_p - x_l) * (x_p - x_l)' < th^2
            break
        end
        
        if DEBUG
            plot3([x_p(1), x_l(1)],...
                [x_p(2), x_l(2)],...
                [x_p(3), x_l(3)], '-b');
        end
        x_p = x_l;
        
    end
    peak = x_l;
end

