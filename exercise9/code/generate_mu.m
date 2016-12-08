function mu = generate_mu(X, K)
%GENERATE_MU Generate initial values for mu
%   X is the pixels with its values to randomly generate the mu
%   K is the number of segments
    
    d = size(X, 2);     % Dimensions of the pixels (3 color components)
    mx = max(X, [], 1);
    mn = min(X, [], 1);
    rg = repmat(mx - mn, [K, 1]);
    
    % Generate the mu uniformly distributed along the range of X values
    mu = repmat(mn, [K, 1]) + rand(K, d) .* rg;

end