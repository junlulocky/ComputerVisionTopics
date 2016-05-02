%% Computer Vision K-means and image sharpening
% Depth of Field Simulation

%%
% reading the image, the depth, rescaling the depth and displaying the
% images
close all;
axis off;
origImage = (rgb2gray(imread('rgb.png')));
depthImage = double(rgb2gray(imread('depth.png')));

depthImage = depthImage*4; % rescaled for better results


imshow(origImage);
title('Original Image');

figure;
imagesc(depthImage);
title('depth Image');
axis off;

% adding right amount of noise to show the importance 
% of the adding spatial information into k-means
h = fspecial('gaussian',500,80);
h = h./max(h(:)).*depthImage(169,265)/1.3;
h = h(size(h,1)/2+1:size(h,1),size(h,1)/2+1:size(h,1));
ind = randsample(numel(h),numel(h)/3);
h(ind) = 0;
h1 = fspecial('gaussian',5,1);
h = imfilter(h,h1);
depthImage(1:size(h,1),1:size(h,2)) = max(h,depthImage(1:size(h,1),1:size(h,2)));

figure;
imshow(origImage);
title('Original Image');

figure;
imagesc(depthImage);
title('depth Image');
axis off;


%% Part 1 : Implement kmean clustering in the function clusterImage
labelImage = clusterImage(depthImage);

%if part 1 not succeeded, uncomment following line:
%labelImage = double((imread('labelImage.png')));

%display the result
figure;
imagesc(labelImage);
title('Label Image');
axis off;

%% Part 2: Perform smoothing/sharping in function FilterRegions
figure;
subplot(1,3,1);
%background focused depth of field
binaryImage = (labelImage ==1);
filteredImage = FilterRegions( origImage, binaryImage, ...
                               0.5, 2.0 );

imshow(filteredImage);
title('Background in focus');

%hand focused depth of field
binaryImage = (labelImage ==2);
filteredImage = FilterRegions( origImage, binaryImage, ...
                               0.5 , 2.0 );
subplot(1,3,2);

imshow(filteredImage);
title('Hand in focus');

%doll focused depth of field
binaryImage = (labelImage ==3);
filteredImage = FilterRegions( origImage, binaryImage, ...
                               0.5, 2.0 );
subplot(1,3,3);

imshow(filteredImage);
title('Russian doll in focus');


