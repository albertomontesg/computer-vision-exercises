% match descriptors
%
% Input:
%   descr1        - k x n descriptor of first image
%   descr2        - k x m descriptor of second image
%   thresh        - scalar value to threshold the matches
%   
% Output:
%   matches       - 2 x w matrix storing the indices of the matching
%                   descriptors
function matches = matchDescriptors(descr1, descr2, thresh)

    n = size(descr1, 2);
    m = size(descr2, 2);
    
    ssd = zeros(n, m);
    for i = 1:n
        for j = 1:m
            dif = descr1(:,i) - descr2(:,j);
            ssd(i,j) = dif'*dif;
        end
    end
    
    match = (ssd>thresh);
    [r, c] = find(match);
    matches = [r'; c'];

end