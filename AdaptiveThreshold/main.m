close all; clear all; clc;

% load image
im = imread('sonnet.png');
if(size(im,3) == 3) % if it is color image, make it gray image
    im = rgb2gray(im);
end
im = im2double(im);

%% simple thresholding
threshold = 0.4;
bw1 = simple_thresholding(im, threshold);
figure;
imshow(bw1); title('Simple thresholding');

%% adaptive thresholding
sz1 = 15;
threshold = 0.03;
nbins = 256;
bw2 = adaptive_thresholding(im,sz1,threshold);
figure;
imshow(bw2); title('Adaptive thresholding');

