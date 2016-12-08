function [mu, var, alpha] = maximization(I, X)
%MAXIMIZATION Maximization step computation

    [L, K] = size(I);
    d = size(X,2);

    % Recompute parameters
    alpha = 1/ L * sum(I, 1);
    mu = zeros(K, d);
    var = zeros(d, d, K);
    for k = 1:K
        mu(k,:) = sum(X.*repmat(I(:,k), [1, d]), 1) ./ ...
            (L * alpha(k));

        var_k = zeros(d, d, L);
        for l=1:L
            x_mu = X(l,:)-mu(k,:);
            var_k(:,:,l) = I(l,k) .* x_mu' * x_mu;
        end
        var(:,:,k) = sum(var_k, 3) ./ (L * alpha(k));
    end

end