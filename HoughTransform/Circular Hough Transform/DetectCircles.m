function [x_c,y_c] = DetectCircles(accum, r, thres)

x_c=[];
y_c=[];

R = r(1):r(2); % range of the radius

for i = 1:length(R)
    localaccum = accum(:,:,i);
    
    % compute local maxima matrix
    localmax_idx = imregionalmax(localaccum);
    
    localmax = localaccum.*localmax_idx;
    localmax(localmax<thres)=0;
    [y, x] = find(localmax>0);
    y_c = cat(2, y_c, y');
    x_c = cat(2, x_c, x');
end


end

