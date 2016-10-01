% extract harris corner
%
% Input:
%   img           - n x m gray scale image
%   thresh        - scalar value to threshold corner strength
%   
% Output:
%   corners       - 2 x k matrix storing the keypoint coordinates
%   H             - n x m gray scale image storing the corner strength
function [corners, H] = extractHarrisCorner(img, thresh)

    dx = [-.5 0 .5];
    dy = dx';
    
    IX = conv2(img, dx, 'same');
    IY = conv2(img, dy, 'same');

    blur_filter = fspecial('gaussian');
    IX2 = conv2(IX.^2, blur_filter, 'same');
    IY2 = conv2(IY.^2, blur_filter, 'same');
    IXIY = conv2(IX.*IY, blur_filter, 'same');
    
    K = (IX2.*IY2 - IXIY.^2) ./ (IX2 + IY2 + eps);

    mx = ordfilt2(K, 9, ones(3));
    
    cim = (K==mx)&(K>thresh);
    [r,c] = find(cim);
    corners = [r'; c'];
    
    H = K;
end