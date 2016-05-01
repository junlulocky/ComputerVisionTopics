clear all
close all
clc

image=imread('pears.png');

%% 1. convert image in double, grayscale
image=im2double(rgb2gray(image));
[height,width]=size(image); % keep the image size

%% 2. smoothing using a gaussian filter
% choose smooth filter size and sigma
filterSize = 7;
filterSigma = 2;
filter = fspecial('gaussian', filterSize, filterSigma);
smoothedImg = imfilter(image, filter, 'symmetric');

% QUESTION: What is the trade-off of using bigger sigma?
% ANSWER: Large sigma detects large scale edges, 
% The larger sigma Gaussian is an estimate of the 
% average intensity over a larger region.
% Increasing scale (sigma) removes details but never adds new ones, 
% and the bigger sigma, the bigger effects those neighbours have on the centre pixel.

%% 3. compute gradient magnitude and angle by the sobel filter
filterSobel = fspecial('sobel');
Sx = imfilter(smoothedImg, filterSobel', 'symmetric');
Sy = imfilter(smoothedImg, filterSobel, 'symmetric');

% computing magnitude of gradients
Smag = sqrt(Sx.^2 + Sy.^2);
% computing angle of gradients
Sang = atan2(Sy, Sx);

figure;
subplot(1,2,1), imagesc(Smag), title('Gradient Magnitude');
subplot(1,2,2), imagesc(Sang), title('Gradient Angle');

%% 4.non maxima suppression
%Sthin = zeros(height, width);
Sthin = nonmaximum_suppression(Smag, Sang);
figure; 
imshow(Sthin), title('Non-Maxima Suppression Image');

%% 5. get double threshold image
% choose the two thresholds - both in percentage of the maximum of the gradient magnitude
lowThresh = 8; 
highThresh = 20; 

[edgeStrong, edgeWeak] = double_threshold(Sthin, lowThresh, highThresh);
figure;
subplot(1,2,1), imshow(edgeStrong), title('Strong edge');
subplot(1,2,2), imshow(edgeWeak), title ('Weak edge');
    
%% 6. hysteresis thresholding
edgeImage = hysteresis_thresholding(edgeStrong, edgeWeak);
figure;
subplot(1,2,1), imshow(image), title('Original Image');
subplot(1,2,2), imshow(edgeImage), title ('Canny Edge Image');

    
