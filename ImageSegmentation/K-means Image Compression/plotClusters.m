function plotClusters(X,r,Mu, colors)
% plot cluster mean and responsibilities on data
% X is DxN data
% r is 1xN responsibility vector, e.g. r = [1,2,1] for 2 clusters 3 data points
% Mu is DxK mean vector
% colors is a cell array e.g. {'r','g','b'} for 3 clusters
% Written by Emtiyaz, EPFL

  K = size(Mu,2);
  for k = 1:K
    n = find(r==k);
    plot(X(1,n), X(2,n), 'o', 'color', colors{k}, 'markersize', 5, 'markerfacecolor', colors{k});
    hold on;
    plot(Mu(1,k), Mu(2,k), 'o', 'color', colors{k}, 'markersize', 20, 'linewidth', 3, 'markerfacecolor', [1 1 1]);
  end
  axis([-2.5 2.5 -2.5 2.5]);
  set(gca, 'xtick', [-2:2], 'ytick', [-2:2])
  grid on;


