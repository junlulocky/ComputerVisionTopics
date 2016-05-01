clearvars;
clc;
close all;

%% LOAD IMAGE AND DATA PROCESSING
%% Shoudld vectorize the data and convert it to double precision using the function double()
% load image
img = imread('lena.png');


% vectorize
[M,N] = size(img);
X = zeros(1,M*N);
for i = 1:M
    for j = 1:N
        X(i*(M-1)+j) = img(i,j);
    end
end

% double precision
X = double(X);

% data normalization
for i = 1:size(X,1)
    X(i,:) = (X(i,:)-mean(X(i,:))) ./ std(X(i,:));
end

% data visualizaiton
figure();
hist(X,50);

%% APPLY K-MEANS

% choose cluster number K
K = 3; 
% choose the initial Mu
MuOld = randn(size(X,1), K);

maxIters = 5;

% iterate
for i = 1:maxIters
    % update R and Mu
    [Ln, r, Mu] = kmeansUpdate(X,MuOld);

    % average distance over all n
    L(i) = mean(Ln);
    fprintf('%d .4%f\n', i, L(i));

    % convergence condition
    if i>1 & L(i)==L(i-1)
      break;
    end

    % new mean is the old mean now
    MuOld = Mu;
    Lold = L(i);
end

%% IMAGE RECONSTRUCTION

% plot histogram
X1 = X(find(r==1));
X2 = X(find(r==2));
X3 = X(find(r==3));

figure();
histogram(X1,5,'FaceColor','r');
hold on
histogram(X2,5,'FaceColor','g');
hold on
histogram(X3,5,'FaceColor','b');

% set to mean value
for k = 1:K
    for n = 1:size(X,2)
        if r(n)==k
            X(:,n)=Mu(:,k);
        end
    end
end

% reconstract
for i = 1:M
    for j = 1:N
        reimg(i,j) = X(i*(M-1)+j);
    end
end

% show new picuture
imwrite(reimg,'lenar.png');
figure();
imshow('lena.png');
figure();
imshow('lenar.png');


