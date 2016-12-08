function [map, cluster] = EM(img)

    K = 5;
    tol = 0.0002;
    
    % Flat all the pixels and normalize values to scale [0, 1] 
    [h, w, c] = size(img);
    X = reshape(img, [h*w, c]);
    X = double(X) / 256; 
    L = size(X, 1);
    
    % Generate mu
    mu = generate_mu(X, K);
    % Generate covariance
    var = generate_cov(X, K);
    % Generate alpha
    alpha = 1 / K * ones(1, K);

    % For convergence criteria
    log_lh = 0;
    while true
        % Compute expectation
        [I, P] = expectation(mu, var, alpha, X);
        % Update parameters to maximize probabilities
        [mu, var, alpha] = maximization(I, X);
        
        % Convergence criterion evaluating log-likelihood
        a_P = repmat(alpha, [L, 1]) .* P;
        l_lh = sum(log(sum(a_P, 2)), 1) / L;
        if abs(l_lh - log_lh) < tol
            break;
        end
        log_lh = l_lh;
    end
    
    alpha
    mu
    var
    
    % A final computation of expectation
    [I, ~] = expectation(mu, var, alpha, X);
    % Map all the pixels to its most probable segment
    [~, map] = max(I, [], 2);
    map = reshape(map, [h, w]);
    % Return the cluster centers
    cluster = mu;

end