function vocids = findKClosestWords(imageID1, imageID2, histograms, k, nozeroes)
% finds K words on which two images are most similar. (smallest difference)
% returns the indexes in the vocabulary of these words.

im1 = histograms(:,imageID1);
im2 = histograms(:,imageID2);
%TODO: zeros
d = (im1 - im2).^2;

% find indexes of minimum value(s)
[sorted, ids] = sort(d);

if nozeroes
    zeros = sum(sorted(:)==0);
    vocids = ids(zeros+1:k+zeros);
else
    vocids = ids(1:k);
end