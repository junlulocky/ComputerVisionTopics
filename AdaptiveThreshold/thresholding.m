function bw = thresholding(im,nbins)
%% variables
% im    - input image of size NxM
% nbins - number of bins in the histogram

% bw    - output binary image

%% your implementation starts here
%error('Remove this line and write your own code here');

[imgCounts ~] = imhist(im, nbins);
prob = double(imgCounts) ./ sum(imgCounts);


end

