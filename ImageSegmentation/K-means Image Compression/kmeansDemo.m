clear all;

% read data
X = importdata('faithful.txt');
% data is DxN
X = X';

% center data
% WRITE CODE TO CENTER THE DATA
for i = 1:size(X,1)
    X(i,:) = (X(i,:) - mean(X(i,:))) ./ (std(X(i,:)));
end

%{
% visualize the input data
for i = 1:size(X,1)
    figure();
    hist(X(i,:));
end
%}

% plot data
figure();
plot(X(1,:), X(2,:), 'ko', 'markersize', 5, 'markerfacecolor', 'k');
grid on;
%axis([-2.5 2.5 -2.5 2.5]);
%set(gca, 'xtick', [-2:2],'ytick', [-2:2])
fprintf('press any key to continue...');
pause;

% initialize
% MuOld = [1 -1; -1 1];
MuOld = [1 -1 0; -1 1 0];
K = size(MuOld,2);
colors = {'r','b','g','c','k','m','y'};
maxIters = 20;

% iterate
for i = 1:maxIters
  % update R and Mu
  % COMPLETE THIS FUNCTION
  [Ln, r, Mu] = kmeansUpdate(X,MuOld);

  % average distance over all n
  L(i) = mean(Ln);
  fprintf('%d .4%f\n', i, L(i));

  % convergence
  % WRITE CODE FOR CONVERGENCE
  if i>1 & L(i)==L(i-1)
      break;
  end
  
  % visualize clusters
  hold off;
  plotClusters(X, r, MuOld, colors)
  pause(.5);
  hold off;
  plotClusters(X, r, Mu, colors)
  pause(.5);

  % new mean is the old mean now
  MuOld = Mu;
  Lold = L(i);
end

