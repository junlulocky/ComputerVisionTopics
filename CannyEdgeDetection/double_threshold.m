function [edgeStrong, edgeWeak] = double_threshold(Sthin, lowThresh, highThresh)
% Input: the thinned image, and the percent of the two threshold
% Output: the strong and weak edge

% do some assertion for the input
assert(lowThresh >= 0 && lowThresh<=100 ,'low threshold must be between 0 and 100 %')
assert(highThresh >= 0 && highThresh<=100 ,'high threshold must be between 0 and 100 %')
assert(lowThresh < highThresh,'did you invert high and low thresholds?')

% Because the threshold is in percent, get the real threshold
maxval = max(Sthin(:));
highThresh = highThresh * maxval/100;
lowThresh = lowThresh * maxval/100;

[height, width] = size(Sthin);
edgeStrong = zeros(height, width);
edgeWeak = zeros(height, width);

edgeStrong(Sthin >= highThresh) = 1;
edgeWeak((Sthin>lowThresh) & (Sthin<highThresh)) = 1;

end