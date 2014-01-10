function featuresMatrix = extractFeaturesFromImageList()
% extractFeaturesFromImageList Compute keypoints and descriptors from
% images
%   featuresMatrix = extractFeaturesFromImageList() computes the
%   keypoints and descriptors from the images located at data/myImages. KEYPOINTS is a 4 x K
%   matrix with one column for keypoint, specifying the X,Y location,
%   the SCALE, and the CONTRAST of the keypoint.
%
%   DESCRIPTORS is a 128 x K matrix of SIFT descriptors of the
%   keypoints.

names = getImageSet('data/myImages') ;

keypointsCell = cell(1,numel(names));
descriptorsCell = cell(1,numel(names));
parfor i = 1:length(names)
  if exist(names{i}, 'file')
    fullPath = names{i} ;
  else
    fullPath = fullfile('data','images',[names{i} '.jpg']) ;
  end

  [keypoints,descriptors] = extractFeaturesFromImage(fullPath);
  keypointsCell{i} = keypoints;
  descriptorsCell{i} = descriptors;
end
featuresMatrix = [keypointsCell;descriptorsCell];
