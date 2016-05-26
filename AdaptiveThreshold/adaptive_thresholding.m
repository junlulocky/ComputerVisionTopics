function bw = adaptive_thresholding(im,sz,threshold)
%% variables
% im        - input image of size NxM
% sz        - size of the window, from which threshold is estimated
% threshold - supplementary threshold

% bw        - output binary image

%% your implementation starts here
avgFilt = fspecial('average', sz);
imgFilt = imfilter( im, avgFilt, 'symmetric' );
imgSub = imgFilt - im;
imgThres = imgSub - threshold;

bw = zeros(size(imgThres));
bw(imgThres>=0)=1;




end