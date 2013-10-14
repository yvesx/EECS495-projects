
function [x_coord y_coord] = bresenham(point)

% whether the line to draw is steep or not
if (abs(point(4)-point(2)) > abs(point(3)-point(1)))                                     
    x0 = point(2);y0 = point(1); x1 = point(4);y1=point(3);
    steep = 1;                                              
else
    x0 = point(1);y0 = point(2); x1 = point(3);y1=point(4);
    steep = 0; 
end
if(x0 >x1)
    temp1 = x0; x0 = x1; x1 = temp1;
    temp2 = y0; y0 = y1; y1 = temp2;
end
dx = abs(x1 - x0);                               % delta in x-axis
dy = abs(y1 - y0);                               % delta in y-axis

% signs of deltas
sx = sign(x1 - x0);                              
sy = sign(y1 - y0); 

x = x0; 
y = y0;                                  
x_coord = zeros(dx,1);
y_coord = zeros(dx,1);
param = 2*dy - dx ;                               
for i = 1:dx                                    
    x_coord(i) = x;                             
    y_coord(i) = y;
    param = param + 2*dy;                         
    if (param >0)                                 
        y = y +1*sy;                              
        param = param - 2*(dx );                  
    end
    x = x + 1*sx;                                 
end