function vPoints = grid_points(img, nPointsX, nPointsY, border)
%GRID_POINTS
    [h, w] = size(img);
    % Create space of coordinates for each axis
    x_points = linspace(border, w-border, nPointsX);
    y_points = linspace(border, h-border, nPointsY);
    % Mesh the points coordinates
    [X_points, Y_points] = meshgrid(x_points,y_points);
    % Transform the grid into a vector of points
    vPoints = [reshape(Y_points, [nPointsX*nPointsY, 1]),...
        reshape(X_points, [nPointsX*nPointsY, 1])];
    % Round to be used as index
    vPoints = round(vPoints);
end
