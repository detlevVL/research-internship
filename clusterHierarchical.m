function imageIDs = clusterHierarchical(histograms,k)
% creates k clusters from the histograms using hierarchical clustering
% returns a matrix imageIDs with k columns, each column contains the image
% ids corresponding to a cluster

histogramsTrans = transpose(histograms);
idx = clusterdata(histogramsTrans,'maxclust',k,'linkage','complete');

for i = 1:length(unique(idx))
    cluster = find(idx==i);
    imageIDs(1:length(cluster),i) = cluster;
end