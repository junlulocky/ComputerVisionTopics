function accum = CircleHoughAccum(edge_I,r)

% input:    edge image that can be acquired with the MATLAB function 'edge'
%           and range of radii to be investigated
% output:   accumulation array, where maximums corresponds to the lines in the image


[y,x]=find(edge_I);
totalpix = length(x); % the 'totalpix' is the numbers of '1' in the image.

R = r(1):r(2); % range of the radius
R2 = R.^2;   % squared radius

height = size(edge_I, 1);
width = size(edge_I, 2);
area = height * width;
accum = zeros(height, width, length(R));
%r2 = r.^2;


for cnt = 1:totalpix
    for cntR = 1:length(R)
        % b keeps the y circular centers
        b = 1:height;
        % a keeps the x circular centers corresponding to b's, 
        % and only keeps the left and right a's
        a = (round(x(cnt) - sqrt(R2(cntR) - (y(cnt) - [1:height]).^2) ));
        %c = -a;
        %a = [a,c];
        
        % choose useful ones
        b = b(imag(a)==0 & a>0);  % remember to use imag!
        a = a(imag(a)==0 & a>0);
        
        ind = sub2ind([height,width],b,a); %subscript to index
        accum(area*(cntR-1)+ind) = accum(area*(cntR-1)+ind) + 1;
    end
end

end

