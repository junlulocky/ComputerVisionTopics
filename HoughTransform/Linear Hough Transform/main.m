clear all;
close all;
clc;

%% load image

I = imread('./I.png');

%% make edge image

edge_I = zeros(size(I));
edge_I = edge(I);

%% Implement Hough Transform

accum_array = LinearHoughAccum(edge_I);
% show the accumulator array
figure(1);
imagesc(accum_array);
impixelinfo

%% Implement basic visualization

figure(2);
show_lines(I,accum_array);
impixelinfo

