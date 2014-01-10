function showSimilarity(imageID, names, vocid, vocabulary)
% creates a figure containing the image and displays the keypoints
% corresponding to the descriptors which were projected to the
% visual word with id = vocid

im = imread(names{imageID});
shapeInserter = vision.ShapeInserter('BorderColor','Custom', 'CustomBorderColor', uint8([255 0 0]));
[keypoints, descriptors] = computeFeatures(im);
[words, distances] = quantizeDescriptors(vocabulary, descriptors);

% find the keypoints corresponding to the descriptors which were  
% projected to the visual word with id = vocid
keypointids = find(words == vocid);

rectangle = int32([0 0 5 5]);

% display the points on image
for j = 1:length(keypointids)
    point = keypoints(:,keypointids(j));
    rectangle(1) = point(1); % x
    rectangle(2) = point(2); % y 
    im = step(shapeInserter, im, rectangle);
    fprintf('At (%i,%i) with scale %5.5f and contrast %i. Distance: %6.2f \n', point(1),point(2),point(3),point(4),distances(j));
end

figure;
imshow(im);
