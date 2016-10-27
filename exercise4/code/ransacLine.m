function [k, b] = ransacLine(data, dim, iter, threshDist, inlierRatio)
% data: a 2xn dataset with #n data points
% num: the minimum number of points. For line fitting problem, num=2
% iter: the number of iterations
% threshDist: the threshold of the distances between points and the fitting line
% inlierRatio: the threshold of the number of inliers

number = size(data,2); % Total number of points
bestInNum = 0;         % Best fitting line with largest number of inliers
k=0; b=0;              % parameters for best fitting line

for i=1:iter
    % Randomly select 2 points

    % Compute the distances between all points with the fitting line

    % Compute the inliers with distances smaller than the threshold

    % Update the number of inliers and fitting model if better model is found

end

end
