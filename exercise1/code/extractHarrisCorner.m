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

    % Define the gradients steps
    dx = [-.5 0 .5];
    dy = dx';
    % Compute the gradient of the image at each axis
    IX = conv2(padarray(img, [0, 1], 'symmetric'), dx, 'valid');
    IY = conv2(padarray(img, [1, 0], 'symmetric'), dy, 'valid');

    % Apply Gaussian Filter and compute all the Harris matrix values
    blur_filter = fspecial('gaussian');
    IX2 = conv2(IX.^2, blur_filter, 'same');
    IY2 = conv2(IY.^2, blur_filter, 'same');
    IXIY = conv2(IX.*IY, blur_filter, 'same');
    
    % Compute the Harris Response Measure
    H = (IX2.*IY2 - IXIY.^2) ./ (IX2 + IY2 + eps);

    % Non-Maximum-Suppression in a 3 pixel radius;
    radius = 3;
    diam = 2*radius + 1;
    mx = ordfilt2(H, diam^2, ones(diam));
    cim = (H==mx)&(H>thresh);
    
    % Find the localization of the corners
    [r,c] = find(cim);
    corners = [r'; c'];    
end