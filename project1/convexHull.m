function [convex] = convexHull(points)
%%%% CLOCKWISE ORDER!!!!
[n,~] = size(points);

convex = [];
for i=1:n
    xi=points(i,1);
    yi=points(i,2);
    
    % work with upper hull fist
    if yi >= (points(n,2)-points(1,2))*((xi-points(1,1))/(points(n,1)-points(1,1)))+points(1,2)
        [x_pos,~]=size(convex);
        if x_pos <=1
            convex = [convex;xi,yi];
        else
            flag = 1;
            while flag == 1
                [x_pos,~]=size(convex);
                if yi <= ((convex(x_pos,2)-convex(x_pos-1,2))*((xi-convex(x_pos-1,1))/(convex(x_pos,1)-convex(x_pos-1,1)))+convex(x_pos-1,2))
                    convex = [convex;xi,yi];
                    flag = 0;
                else
                    convex(x_pos,:)=[];
                end
                [x_pos,~]=size(convex);
                if x_pos==1
                    flag =0;
                    convex = [convex;xi,yi];
                end
                
            end
        end
    end
    
end

convexlow = [];
% code for lower hull
for i=n:-1:1
    xi=points(i,1);
    yi=points(i,2);
    
    if yi< (points(n,2)-points(1,2))*((xi-points(1,1))/(points(n,1)-points(1,1)))+points(1,2)
        [x_pos,~]=size(convexlow);
        if x_pos <=1
            convexlow = [convexlow;xi,yi];
        else
            flag = 1;
            while flag == 1
                [x_pos,~]=size(convexlow);
                if yi > ((convexlow(x_pos,2)-convexlow(x_pos-1,2))*((xi-convexlow(x_pos-1,1))/(convexlow(x_pos,1)-convexlow(x_pos-1,1)))+convexlow(x_pos-1,2))
                    convexlow = [convexlow;xi,yi];
                    flag = 0;
                else
                    convexlow(x_pos,:)=[];
                end
                [x_pos,~]=size(convexlow);
                if x_pos==1
                    flag =0;
                    convexlow = [convexlow;xi,yi];
                end
                
            end
        end
    end
    
end
convex=[convex;convexlow;convex(1,:)];
