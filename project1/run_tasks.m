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
points = [10,11;20,23;30,31;40,60;55,23;56,24;81,11;22,7];
%%%% CLOCKWISE ORDER!!!!
[hull] = convexHull(points);
figure;
plot(hull(:,1),hull(:,2),points(:,1),points(:,2),'bo')
title('Task 4: Draw a convex hull',... 
  'FontWeight','bold')


%@@@@@@@@@@@@@@@@@ extra credit
%@@@@@@@@@@@@@@@@@ 
Polygon3 = [ 3 20 40 3 3 ; 3 3 20 40 3]';
point_inside3 = [ 4 4];
line_segment = [10, 10, 60, 50]; 
[l(:,1) l(:,2)] = bresenham(line_segment);
ImageWidth = max([Polygon1(:,1); line_segment'])+10;
ImageHeight = max([Polygon1(:,2); line_segment'])+10;
img6 = zeros(ImageHeight,ImageWidth);
img6 = fill(Polygon1,point_inside1,img6);
[r c] = size(l);
for i=1:r
    img6(l(i,1),l(i,2)) = img6(l(i,1),l(i,2)) + 0.7; % 1.7: line inside polgy 0.7: outside. 1.1 on board
end
idx17 = find(img6==1.7);
idx07 = find(img6==0.7);
idx11 = find(img6==1.1);
img6(idx17) = 0.3; % highlight the part inside
img6(idx07) = 0;
img6(idx11) = 0.4;
figure;imshow(img6);
title('Extra-Credit: line clipping',... 
  'FontWeight','bold')