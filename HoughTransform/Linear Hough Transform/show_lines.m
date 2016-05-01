function show_lines(I,accum)

% find the maximum index in the array matrix -> [ii, jj]
[~,ind] = max(accum(:));
[ii,jj] = ind2sub(size(accum),ind); 

display(ii);
display(jj);

r = ii;
theta = 0.01*(jj-1);  % remember to -1!

eps = 1;
for y = 1:size(I,1)
    for x = 1:size(I,2)
        if(r < abs((x)*cos(theta)+(y)*sin(theta))+eps && r > abs((x)*cos(theta)+(y)*sin(theta))-eps)
            I(y,x) = 255;
        end
    end
end
imshow(I)

end

