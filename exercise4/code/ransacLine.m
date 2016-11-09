function [k, b] = ransacLine(data, num, iter, threshDist, inlierRatio)
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
    idx = randsample(number, num);
    p_x = data(1,idx);
    p_y = data(2,idx);
    P = polyfit(p_x, p_y, 1);
    k_i = P(1); b_i = P(2);
    % Compute the distances between all points with the fitting line    
    d = (-data(2,:)+k_i*data(1,:)+b_i) / (sqrt(1+k_i*k_i));
    d = abs(d);
    % Compute the inliers with distances smaller than the threshold
    inIdx = find(d <= threshDist);
    inNum = length(inIdx);
    
    % Update the number of inliers and fitting model if better model is found
    if inNum < round(inlierRatio*number)
        continue
    end
    
    p_x = data(1, inIdx);
    p_y = data(2, inIdx);
    P = polyfit(p_x, p_y, 1);
    k_i = P(1); b_i = P(2);
    d = (-data(2,:)+k_i*data(1,:)+b_i) / (sqrt(1+k_i*k_i));
    d = abs(d);
    inNum = sum(d <= threshDist);
    if inNum > bestInNum
        bestInNum = inNum;
        k = k_i; b = b_i;
    end

end
