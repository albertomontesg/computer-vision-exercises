function cov = generate_cov(X, K)
%GENERATE_COV Generate initial values for the K
%   covariance matrices

    d = size(X, 2);     % Dimensions of the pixels (3 color components)
    mx = max(X, [], 1);
    mn = min(X, [], 1);
    var = (mx - mn) / 60;

    % Generate the initial covariange matrix diagonal with fix variance at
    % each color dimension
    cov = zeros(d, d, K);
    for k = 1:K
        cov(:,:,k) = diag(var);
    end
end