function [descriptors,patches] = descriptors_hog(img,vPoints,cellWidth,cellHeight)

    nBins = 8;
    w = cellWidth; % set cell dimensions
    h = cellHeight;
    num = size(vPoints,1);

    descriptors = zeros(num, 4, 4, nBins); % one histogram for each of the 16 cells
    patches = zeros(num,4*w*4*h); % image patches stored in rows    
    
    [grad_x, grad_y]=gradient(img);    
    
    for i = 1:num % for all local feature points
        [p_x, p_y] = vPoints(i,:);
        p_x_min = p_x-2*w+1;
        p_x_max = p_x+2*w;
        p_y_min = p_y-2*h+1;
        p_y_max = p_y+2*h;
        
        patch = img(p_y_min:p_y_max, p_x_min:p_x_max);
        grad_pathc = gr
        for ii = 1:4
            for jj = 1:4
                cell = pathc(jj:(jj+h),ii:(ii+w));
                descriptors(i, ii, jj, hist) = histogram(cell, nBins);
            end 
        end
        
        descriptors(i,:) = reshape(patch, [1, 4*w*4*h]);
    end % for all local feature points
    
    descriptors = reshape(descriptors, [num, 4*4*nBins]);
end
