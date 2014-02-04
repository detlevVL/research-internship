function vocids = findKClosestWords(imageID1, imageID2, histograms, k)
% finds K words on which two images are most similar. (smallest difference in frequency)
% returns the indexes in the vocabulary of these words.

im1 = histograms(:,imageID1);
im2 = histograms(:,imageID2);

d = (im1 - im2).^2;

% find indexes of minimum value(s)
[sorted, ids] = sort(d);

vocids = ids(1:k);