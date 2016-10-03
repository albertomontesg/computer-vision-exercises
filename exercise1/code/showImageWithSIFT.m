% show image with key points
%
% Input:
%   img        - n x m color image 
%   corner     - 2 x k matrix, holding keypoint coordinates of first image
%   fig        - figure id
function showImageWithSIFT(img, sift_features, fig)
    figure(fig);
    imshow(img, []);
    
    hold on
    vl_plotframe(sift_features);
end