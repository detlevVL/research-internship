function showImageCluster(imageIDs, names, varargin)
% Takes a vector of imageIDs and shows the first 36 images.
% Use showImageCluster(..., 'numImages', N) to change the amount of 
% images displayed.
% Use showImageCluster(..., 'batch', K) to display the Kth batch of
% 36 images.

opts.numImages = 36;
opts.batch = 1 ;
opts = vl_argparse(opts,varargin);

figure;
cluster = imageIDs;

% remove zeros
cluster(cluster==0) = [];

% which images to show
low = (opts.batch-1) * opts.numImages + 1; % if batch = 1 => start from image 1
high = opts.batch * opts.numImages; % if batch = 1 => end at image numImages

if low > length(cluster),
   warning('There are only %i images in this cluster.', length(cluster));
   return;
end
high = min(high,length(cluster));
amount = high - low + 1;

for i = 1:amount
    imID = cluster(low + i -1);
    im = imread(names{imID});
    im = standardizeImage(im);
   
    vl_tightsubplot(amount,i);
    imshow(im);
end
