function [hull idx] = convexHull(points)
% matlab's implementation
if size(points, 1) < 4
    hull = points;
    idx = 1:size(points, 1);
    return;
end

idx = convhull(points(:,1), points(:,2));
hull = points(idx, :);