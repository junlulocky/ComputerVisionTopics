function Sthin = nonmaximum_suppression(Smag, Sang)

[height,width]=size(Smag);
Sthin = zeros(height, width);
for i = 2:height-1
    for j = 2:width-1
        angleNormal = Sang(i,j);
        p1 = [j+cos(angleNormal); i + sin(angleNormal)];
        p2 = [j-cos(angleNormal); i - sin(angleNormal)];
        % get the neighbor pixels by the direction of the gradient
        intensities = getNeighborPixels(Smag, [p1(1) p2(1)], [p1(2) p2(2)]);
        % If the edge strength of the current pixel is greater than that of 
        % the neighboring pixels in the gradient direction, 
        % preserve the value of the edge strength. I
        if((Smag(i,j) > intensities(1)) && (Smag(i,j) > intensities(2)))
            Sthin(i,j) = Smag(i,j);
        end
    end
end

end


function intensities = getNeighborPixels( Img, u, v)
% This function computes the neighbor pixels of each pixel after the image
% by the coordinates
%
% Inputs:
% Im: input image   
% u: 1XN vector with the x coordinates 
% v: 1XN vector with the y coordinates 

% Outputs: neighbor pixel intensities

[height,width,channels] = size(Img);
N = length(u);
intensities = -1*ones(N,channels); % in our case, it is gray image

rx = round(u);
ry = round(v);

p = u - rx;
q = v - ry;
dx = ones(N,1);
dy = ones(N,1);

dx(p < 0) = -1;
dy(q < 0) = -1;

p = abs(p);
q = abs(q);

for k = 1:N
    
    if ( (rx(k) <1) || (ry(k) <1) || (rx(k) >= width) || (ry(k) >= height) || (rx(k)+dx(k) <1) || (ry(k)+dy(k) <1) || (rx(k)+dx(k) >= width) || (ry(k)+dy(k) >= height))
        continue ;
    end
    a = Img(ry(k),rx(k),:); 
    b = Img(ry(k),rx(k)+dx(k),:); 
    c = Img(ry(k)+dy(k),rx(k),:); 
    d = Img(ry(k)+dy(k),rx(k)+dx(k),:);

    intensities(k,:) = (1-p(k))*(1-q(k)).*a + (1-p(k))*q(k).*c + p(k)*(1-q(k)).*b + p(k)*q(k).*d;
       
end 
end