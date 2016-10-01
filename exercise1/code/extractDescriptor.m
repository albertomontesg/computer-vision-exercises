% extract descriptor
%
% Input:
%   keyPoints     - detected keypoints in a 2 x n matrix holding the key
%                   point coordinates
%   img           - the gray scale image
%   
% Output:
%   descr         - w x n matrix, stores for each keypoint a
%                   descriptor. m is the size of the image patch,
%                   represented as vector
function descr = extractDescriptor(corners, img)  
    img = padarray(img, [1 1]);
    
    n = size(corners, 2);
    descr = zeros(9, n);
    
    for i = 1:n
        r_pos = corners(1,i) + 1;
        c_pos = corners(2,i) + 1;
        patch = img((r_pos-1):(r_pos+1),(c_pos-1):(c_pos+1));
        descr(:,i) = reshape(patch', 9, 1);
    end

end