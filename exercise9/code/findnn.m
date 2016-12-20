function [Idx, Dist] = findnn( D1, D2 )
  % input:
  %   D1  : NxD matrix containing N feature vectors of dim. D
  %   D2  : MxD matrix containing M feature vectors of dim. D
  % output:
  %   Idx : N-dim. vector containing for each feature vector in D1
  %         the index of the closest feature vector in D2.
  %   Dist: N-dim. vector containing for each feature vector in D1
  %         the distance to the closest feature vector in D2.

  
  % Find for each feature vector in D1 the nearest neighbor in D2
  % Compute pairwise distances between each element of D1 and D2
  d = pdist2(D1, D2, 'euclidean');
  % Find the minimum distance and its index
  [Dist, Idx] = min(d, [], 2);
end
