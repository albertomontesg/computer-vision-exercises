function [in1, in2, out1, out2, m, F] = ransac8pF(xy1, xy2, threshold)

    num = 8;                % 8 points to copute the F matrix
    number = size(xy1,2);   % Total number of points
    bestInNum = 0;          % Best fitting line with largest number of inliers
    F = 0;                  % parameters for best fitting line
    in_idx = false(1, number);
    p = .99;
    
    xy1s = [xy1; ones(1, number)];
    xy2s = [xy2; ones(1, number)];
    
    for i=1:1000
        
        idx = randsample(number, num);
        x1s = xy1s(:,idx);
        x2s = xy2s(:,idx);
        [f, ~] = fundamentalMatrix(x1s, x2s);
        inlier_idx = false(1, number);
        for k = 1:number
            err = distPointLine(xy2(:,k), f*xy1s(:,k)) + ...
                  distPointLine(xy1(:,k), f'*xy2s(:,k));
            if err < threshold
                inlier_idx(k) = true;
            end
        end
        
        if sum(inlier_idx) > bestInNum
            bestInNum = sum(inlier_idx);
            in_idx = inlier_idx;
            F = f;
        end
        
    end
    
    % Recompute the fundamental matrix with all the inliers found
    x1s = xy1(:,in_idx);
    x2s = xy2(:,in_idx);
    [F, ~] = fundamentalMatrix(x1s, x2s);
    % Find one last time all the inliers
    in_idx = false(1, number);
    for k = 1:number
        err = distPointLine(xy2(:,k), f*xy1s(:,k)) + ...
              distPointLine(xy1(:,k), f'*xy2s(:,k));
        if err < threshold
            in_idx(k) = true;
        end
    end
    
    in1 = xy1(:,in_idx);
    in2 = xy2(:,in_idx);
    out1 = xy1(:,~in_idx);
    out2 = xy2(:,~in_idx);
    m = i;
    
end


