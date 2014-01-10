function imageIDs = clusterKMeans(histograms, k)
% creates k clusters from the histograms using kmeans clustering
% returns a matrix imageIDs with k columns, each column contains the image
% ids corresponding to a cluster

histogramsTrans = transpose(histograms);
idx = kmeans(histogramsTrans,k);

for i = 1:k
    cluster = find(idx==i);
    imageIDs(1:length(cluster),i) = cluster;
end