% Decompose the essential matrix
% Return P = [R|t] which relates the two views
% Yu will need the point correspondences to find the correct solution for P
function P = decomposeE(E, x1s, x2s)
    [U,~,V] = svd(E);
    W = [0 -1 0; 1 0 0; 0 0 1];
    R1 = U*W*V';
    R2 = U*W'*V';

    t = U(:,end);
    t = t / norm(t);
    
    PP = zeros(4,3,4); 
    PP(1,:,:) = R1 * [eye(3),t]
    PP(2,:,:) = R1 * [eye(3),-t];
    PP(3,:,:) = R2 * [eye(3),t];
    PP(4,:,:) = R2 * [eye(3),-t];
    
    P_c = [eye(3), zeros(3,1)];
    error = zeros(4,size(x1s,2));
    for i = 1:4
        [~, err] = linearTriangulation(P_c, x1s, reshape(PP(i,:,:),3,4), x2s);
        error(i,:) = err;
    end
    
    error
    error = mean(error,2);
    [~, I] = min(error);
    P = PP(I,:,:);
end