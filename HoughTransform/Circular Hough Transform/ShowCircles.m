function ShowCircles(I,r,x_c,y_c, accum, thres)

display(r);

imshow(I); 
for i = 1:length(x_c)      
    circle(x_c(i),y_c(i),30);
end



end

function h = circle(x,y,r)

hold on
% plot the center
plot(x,y,'*', 'Color', 'green');

% plot the circle
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,'Color','blue' );

hold off

end
