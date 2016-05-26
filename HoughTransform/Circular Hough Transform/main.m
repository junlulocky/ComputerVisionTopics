clear all;
close all;
clc;

%% load image
I = imread('coins.png');

%% make edge image
edge_I = edge(rgb2gray(I));

%% Implement Hough Transform
% define a range of radii in r
r = [24,30];
accum = CircleHoughAccum(edge_I,r);
figure(1);
imagesc(accum(:,:,1));
impixelinfo

%% Compute local maxima of the parameter space
thres = 30; % feel free to change
[x_c,y_c] = DetectCircles(accum,r,thres);

%{
% Find for the maximum value for each layer, or in other words, 
% the layer with maximum value will indicate the correspond R for the circle.

R = r(1):r(2);
for cnt = 1:length(R)
    H(cnt) = max(max(accum(:,:,cnt)));
end
figure;
plot(H,'*-');


% Extract the information from the layer with maximum value, 
% and overlap with the original image.

figure;
imshow(edge_I); hold on;
for intensity=24:41
    for layer=1:6
        [maxval, maxind] = max(H);
        [B,A] = find(accum(:,:,layer)==intensity);

        %plot(mean(A),mean(B),'xr')
        %text(mean(A),mean(B),num2str(intensity),'color','green')
        plot(A,B,'xr')
        text(A,B,num2str(intensity),'color','green')
    end
end
impixelinfo
%}


%% Implement basic visualization
ShowCircles(I,r,x_c,y_c, accum, thres);

