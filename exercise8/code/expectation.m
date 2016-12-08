function [I, P] = expectation(mu,var,alpha,X)
%EXPECTATION Expectation step

    K = length(alpha);
    L = size(X,1);
    d = size(X,2);
    
    P = zeros(L, K);
    
    for k = 1:K
        % Compute expectation of each pixel belong to each cluster
        P(:,k) = mvnpdf(X, mu(k,:), reshape(var(:,:,k), [d d]) );
    end
    
    a_P = repmat(alpha, [L, 1]) .* P;
    I = a_P ./ (repmat(sum(a_P, 2), [1, K]));
end