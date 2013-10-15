clc
clear all
close all
%@@@@@@@@@@@@@@@@@ task1
%@@@@@@@@@@@@@@@@@ 
[x(:,1) x(:,2)] = bresenham([1, 2, 30, 30]);
img = zeros(60,60); % output
[r c]=size(x);
for i = 1:r
    img(x(i,1),x(i,2)) = 1;
end
figure;imshow(img); % show binary image
title('Task 1: draw line with Bresenham Algorithm',... 
  'FontWeight','bold')


%@@@@@@@@@@@@@@@@@ task 2
%@@@@@@@@@@@@@@@@@ 
set(0,'RecursionLimit',2000)
Polygon = [ 3 20 40 3 3 ; 3 3 20 40 3]';
%Polygon = [3 10 10 3 3 ; 3 3 10 10 3]';
point_inside = [ 4 4];
ImageWidth = max(Polygon(:,1))+10;
ImageHeight = max(Polygon(:,2))+10;
img2 = zeros(ImageHeight,ImageWidth);

% draw content
img2 = fill(Polygon,point_inside,img2);

% draw boundaries
%img2 = fill_boundary(Polygon,point_inside,img2);
% both methods are recursive: flood based
figure;imshow(img2);
title('Task 2: draw a polygon and its boundary',... 
  'FontWeight','bold')


%@@@@@@@@@@@@@@@@@ task 3
%@@@@@@@@@@@@@@@@@ 
Polygon1 = [ 3 20 40 3 3 ; 3 3 20 40 3]';
point_inside1 = [ 4 4];

Polygon2 = [ 20 60 70 20 20; 20 20 70 60 20]';
point_inside2 = [ 25 25];

ImageWidth = max([Polygon1(:,1); Polygon2(:,1)])+10;
ImageHeight = max([Polygon1(:,2); Polygon2(:,2)])+10;
img3 = zeros(ImageHeight,ImageWidth);

img3 = fill(Polygon1,point_inside1,img3);
img4 = zeros(ImageHeight,ImageWidth);
img4 = fill(Polygon2,point_inside2,img4);

img5 = img4+img3;
% in img5 the following values
% 2: content and content
% 0.8: boundary cross
% 1.4 boundary on content
idx2 = find(img5==2);
idx14 = find(img5==1.4);
idx08 = find(img5==0.8);
img5(idx2) = 0.3; % COLOR the polygon intersection!!!
img5(idx14) = 0.4;
img5(idx08) = 0.4;

figure;imshow(img5);
title('Task 3: color intersection of two polygons',... 
  'FontWeight','bold')


%@@@@@@@@@@@@@@@@@ task 4
%@@@@@@@@@@@@@@@@@ 
points = [ 20 60 70 20 20 4 5 6 7 8 9 1 44; 20 20 70 60 20 4 5 6 7 8 9 31 8]';
[hull idx] = convexHull(points);
figure;
plot(hull(:,1),hull(:,2),points(:,1),points(:,2),'bo')
title('Task 4: Draw a convex hull',... 
  'FontWeight','bold')