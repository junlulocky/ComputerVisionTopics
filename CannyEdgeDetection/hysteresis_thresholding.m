function edgeImage = hysteresis_thresholding(edgeStrong, edgeWeak)
% Input: strong and weak edges
% Output: the canny algorithm edge

[height, width] = size(edgeStrong);
edgeImage = edgeStrong;

% make the weak edge pixels to be 0.5 for easily processing
edgeImage(find(edgeWeak)) = 0.5;

[vForeground, uForeground] = find(edgeImage == 0.5);

for i = 1:length(vForeground)
    v = vForeground(i);
    u = uForeground(i);
    isEdge = weakIsEdge(edgeStrong, v, u);
    if isEdge == 1
        edgeImage(v,u)=1;
    end
end

% remove the weak edge by noise/color variation
edgeImage(edgeImage == 0.5) = 0;

end


function isEdge = weakIsEdge(edgeStrong, v, u)
% return 1 if the weak edge is considered as edge
[h,w] = size(edgeStrong);
isEdge = 0;
for i=v-1:v+1
    for j=u-1:u+1
        if edgeStrong(i,j)==1 && i>0 && j>0 && i<=h && j<=w
            isEdge=1;
        end
    end
end

end
