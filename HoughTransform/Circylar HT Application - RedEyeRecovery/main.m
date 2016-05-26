%% -- Red Eye Correction --
clearvars;
close all;

%% Load Image
img = imread('2010-08-23-redeyereflex.jpg');

%% Results from running the hough transform on the image
x_c = [168; 53]; % x coordinate of each circle
y_c = [65; 46];  % y coordinate of each circle
r_c = [10, 9];    % radius of each circle

%% Your code goes here --
height = size(img, 1);
width = size(img, 2);

alpha = 2; % feel free to change this value
len = length(x_c);
for i=1:len
    x_center = x_c(i);
    y_center = y_c(i);
    r = r_c(i);
    for i = 1:height
        for j = 1:width
            if (i-y_center)^2 + (j-x_center)^2 <= r^2
                img(i,j) = img(i,j)./alpha;
            end
        end
    end
end
imshow(img); 


%% Answer the questions here --