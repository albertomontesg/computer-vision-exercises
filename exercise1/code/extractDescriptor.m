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
    % Descriptor size: 9x9
    patch_size = 9;
    pad = (patch_size-1) / 2;
    
    % Apply padding for the descriptors at the edges
    img = padarray(img, [pad pad]);
    
    % Initialize th descriptors output
    n = size(corners, 2);
    descr = zeros(patch_size^2, n);
    
    % Iterate for each corner and extract the corresponding patch
    for i = 1:n
        r_pos = corners(1,i) + pad;
        c_pos = corners(2,i) + pad;
        patch = img((r_pos-pad):(r_pos+pad),(c_pos-pad):(c_pos+pad));
        descr(:,i) = reshape(patch', patch_size^2, 1);
    end

end