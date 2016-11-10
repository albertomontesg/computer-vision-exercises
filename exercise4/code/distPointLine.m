function d = distPointLine( point, line )
% d = distPointLine( point, line )
% point: inhomogeneous 2d point (2-vector)
% line: 2d homogeneous line equation (3-vector)
d = [point;ones(1, size(point,2))]' * line / norm(line(1:2));
end