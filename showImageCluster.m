function showImageCluster(imageIDs, names, cid)

figure;
cluster = imageIDs(:,cid);

% remove zeros
cluster(cluster==0) = [];

% for creating the subplots
tempx = ceil(sqrt(length(cluster)));
tempy = ceil(length(cluster)/tempx);

for i = 1:length(cluster)  
    imID = cluster(i);
    im = imread(names{imID});
    im = standardizeImage(im);
   
    subplot(tempx,tempy,i);
    imshow(im);
end

subplotsqueeze(gcf, 1.3);
