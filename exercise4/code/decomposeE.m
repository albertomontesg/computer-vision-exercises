% Decompose the essential matrix
% Return P = [R|t] which relates the two views
% Yu will need the point correspondences to find the correct solution for P
function P = decomposeE(E, x1s, x2s)
    [U,~,V] = svd(E);
    W = [0 -1 0; 1 0 0; 0 0 1];
    R1 = -U*W*V'; % minus sign to enforce det(R)=1
    R2 = -U*W'*V';

    t = U(:,end);
    t = t / norm(t);
    
    P_c = [eye(3), zeros(3,1)];
    for i = 1:4
        PP = (R1*(i<=2) + R2*(i>2)) * [eye(3), t*((-1)^(i-1))];
        [XS, ~] = linearTriangulation(P_c, x1s, PP, x2s);
        % Check if any of the 3D points is placed behind the camera
        % if so, P it will not be valid.
        if sum(XS(3,:) < 0) == 0
            P = PP;
            break;
        end
    end
end