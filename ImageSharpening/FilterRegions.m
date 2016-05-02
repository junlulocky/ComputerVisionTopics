function [FilteredImage] = FilterRegions( OrigImage, BinaryForegroundMap, ...
                                          SharpeningAlpha, SmoothingSigma  )
%
% Inputs: 
% 
% OrigImage: RGB or grayscale input image to be filtered.
%
% BinaryForegroundMap: Binary map of the foreground region(s). The type 
% (class) of the input image must be logical.
%
% SharpeningAlpha: The parameter of the sharpening filter.
% 
% SmoothingSigma: Standard deviation of the gaussian filter.
%
% Outputs: 
%
% FilteredImage:  2D filtered image that has the same type and dimension 
% as the original one.
%

OrigImage = double(OrigImage);
delta = [0 0 0;0 1 0; 0 0 0];

FilteredImage = zeros(size(OrigImage));

gauss = fspecial('gaussian', [7 7], SmoothingSigma);
laplas = fspecial('laplacian',SharpeningAlpha);
sharp = delta-laplas;

smoothed = imfilter(OrigImage,gauss,'replicate');
sharpened = imfilter(OrigImage,sharp,'replicate');

FilteredImage(~BinaryForegroundMap) = smoothed(~BinaryForegroundMap);
FilteredImage(BinaryForegroundMap) = sharpened(BinaryForegroundMap);

FilteredImage = FilteredImage./max(FilteredImage(:));

end