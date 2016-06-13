function bw = simple_thresholding(im, threshold)
%% variables
% im        - input image of size NxM
% threshold - threshold

% bw        - output binary image

%% simple thershold
bw = zeros(size(im));
bw(im>=threshold)=1;

end