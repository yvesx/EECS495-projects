function [img] = fill_boundary(P,point_inside,img)
[r c] = size(img);
if point_inside(1)>=r || point_inside(2)>=c || point_inside(2)<2 || point_inside(1) < 2
    return
end
[IN ON] = inpolygon(point_inside(1),point_inside(2),P(:,1),P(:,2));

% draw boundaries
if ON > 0
    img(point_inside(1),point_inside(2)) = 0.4;
end
if IN + ON < 1
    img(point_inside(1),point_inside(2)) = 0;
    return
end

% get neighbors 
p_10  = point_inside+[1 0];
p_n10 = point_inside+[-1 0];
p_01  = point_inside+[0 1];
p_0n1 = point_inside+[0 -1];

if img(p_10(1),p_10(2)) == 0
    img(p_10(1),p_10(2)) = 0.4;
    img = min(img,fill_boundary(P,point_inside+[1 0],img));
end
if img(p_n10(1),p_n10(2)) == 0
    img(p_n10(1),p_n10(2)) = 0.4;
    img = min(img,fill_boundary(P,point_inside+[-1 0],img));
end
if img(p_01(1),p_01(2)) == 0
    img(p_n10(1),p_n10(2)) = 0.4;
    img = min(img,fill_boundary(P,point_inside+[0 1],img));
end
if img(p_0n1(1),p_0n1(2)) == 0
    img(p_n10(1),p_n10(2)) = 0.4;
    img = min(img,fill_boundary(P,point_inside+[0 -1],img));
end

return
