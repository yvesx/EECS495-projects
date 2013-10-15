clc
clear all
% task1
[x(:,1) x(:,2)] = bresenham([1, 2, 30, 30]);
img = zeros(60,60); % output
[r c]=size(x);
for i = 1:r
    img(x(i,1),x(i,2)) = 1;
end
figure;
imshow(img); % show binary image

% task 2
set(0,'RecursionLimit',2000)
Polygon = [ 3 20 20 3 10 3 ; 3 3 20 20 10 3]';
%Polygon = [3 10 10 3 3 ; 3 3 10 10 3]';
point_inside = [ 4 4];
ImageWidth = max(Polygon(:,1))+10;
ImageHeight = max(Polygon(:,2))+10;
img2 = zeros(ImageHeight,ImageWidth);
img2 = fill(Polygon,point_inside,img2);
% draw boundry
for i = 1:length(Polygon(:,1))
    img2(Polygon(i,1),Polygon(i,2)) = 0.5;
end

figure;
imshow(img2);