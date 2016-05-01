function [Ln,r,Mu] = kmeansUpdate(X, Mu)
% update r and Mu given X and Mu
% X is DxN data
% Mu is DxK mean vector
% r is 1xN responsibility vector, e.g. r = [1,2,1] for 2 clusters 3 data points
% Ln is 1xN minimum distance to its center for each point n

% initialize
K = size(Mu,2);
[D,N] = size(X);
r = zeros(1,N);
%Mu = zeros(D,K);
Ln = zeros(1,N);

% for each cluster, compute the error
% Step1: compute r, compute r given Mu
for n = 1:N
    for k = 1:K
      distance(k) = sqrt((X(:,n)-Mu(:,k))'*(X(:,n)-Mu(:,k)));
    end
    [Ln(n),r(n)] = min(distance);
end
% Step2: For all k, compute Mu for each k, given r
for k = 1:K
    idx = find(r==k);
    Mu(:,k)= mean(X(:,idx)')';
end
    
end

