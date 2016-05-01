function accum_array = LinearHoughAccum(edge_im)

% input:    edge image that can be acquired with the MATLAB function 'edge'
% output:   accumulation array, where maximums corresponds to the lines in the image

number_of_points = 0; % keep track of the number of points in the edge image
step = 0.01; % step size for the change of theta

accum_array = zeros(ceil(sqrt(size(edge_im,1)^2+size(edge_im,2)^2)),numel([0:step:pi]'));

for y = 1:size(edge_im,1)
    for x = 1:size(edge_im,2)

        if(edge_im(y,x) == 1)
            number_of_points = number_of_points + 1;
            count = 0; % keep the index of the theta axis
            for theta = 0:step:pi 
                count = count+1;
                r = abs((x)*cos(theta)+(y)*sin(theta));
                accum_array(ceil(r),count) = accum_array(ceil(r),count)+1;
            end
        end
        
    end
end

end

