function [labelImage] = clusterImage(depthImage)
%
% Inputs: 
% 
% depthImageage: An image where each value indicates the depth of the
% corresponding pixel.
%
% Outputs: 
%
% labelImage:  Output label image where each value indicates to which 
% cluster the corresponding pixels belongs. There are three clusters: 
% value 1 for the background, value 2 for the hand and value 3 for 
% the doll.
%

k=3;

% initiate centroids - BEGIN
% we create 3 centroids, in the format [Z X Y], where Z in the inverse depth
mu=zeros(k,3);

mu(1,:) = [0 0 0]; %background centroid
mu(2,:) = [500 300 150]; %hand centroid
mu(3,:) = [1000 100 200]; %doll centroid
% initiate centroids - END

%% implement kmeans
epsilon = 0;

[sx,sy] = size(depthImage);

labelImage = zeros(sx,sy);

old_mu = mu+100;

[X,Y] = meshgrid(1:sy,1:sx);

count_iter = 0;
max_iter = 50; % feel free to change max_iteration number
while( (count_iter < max_iter) && (abs(sum(sum(old_mu - mu))) > epsilon) )
    % without spatial proximity (uncomment the right one)
    % depthImage_1 = sqrt((depthImage - mu(1,1)).^2);
    % depthImage_2 = sqrt((depthImage - mu(2,1)).^2);
    % depthImage_3 = sqrt((depthImage - mu(3,1)).^2);

    % with spatial proximity (uncomment the right one)
    depthImage_1 = sqrt( (depthImage - mu(1,1)).^2 + ((X-mu(1,2)).^2+(Y-mu(1,3)).^2));
    depthImage_2 = sqrt((depthImage - mu(2,1)).^2+((X-mu(2,2)).^2+(Y-mu(2,3)).^2));
    depthImage_3 = sqrt((depthImage - mu(3,1)).^2+((X-mu(3,2)).^2+(Y-mu(3,3)).^2));

    % For each pixel find the smallest distance and 
    % assign this pixel to the corresponding cluster.
    [~,labelImage] = min(cat(3,depthImage_1,depthImage_2,depthImage_3),[],3);

    old_mu = mu;

    % compute the mean of clusters
    for i=1:3
        mu(i,1) = mean(depthImage(labelImage == i));
        mu(i,2) = mean(X(labelImage == i));
        mu(i,3) = mean(Y(labelImage == i));
    end

    count_iter = count_iter+1;
end


end