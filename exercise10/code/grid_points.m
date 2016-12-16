function vPoints = grid_points(img, nPointsX, nPointsY, border)
%GRID_POINTS
    [h, w] = size(img);
    
    x_points = linspace(border, w-border, nPointsX);
    y_points = linspace(border, h-border, nPointsY);

    [X_points, Y_points] = meshgrid(x_points,y_points);
    vPoints = [reshape(Y_points, [nPointsX*nPointsY, 1]),...
        reshape(X_points, [nPointsX*nPointsY, 1])];
    vPoints = round(vPoints);
end
