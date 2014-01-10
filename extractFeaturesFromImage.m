function [keypoints,descriptors] = extractFeaturesFromImage(fullPath)
% extractFeaturesFromImage Compute keypoints and descriptors for an image
%   [KEYPOINTS, DESCRIPTORS] = extractFeaturesFromImage(fullPath) computes the
%   keypoints and descriptors from the image located at path fullPath. KEYPOINTS is a 4 x K
%   matrix with one column for keypoint, specifying the X,Y location,
%   the SCALE, and the CONTRAST of the keypoint.
%
%   DESCRIPTORS is a 128 x K matrix of SIFT descriptors of the
%   keypoints.

im = imread(fullPath) ;
im = standardizeImage(im) ;
[keypoints,descriptors] = vl_phow(im, 'step', 4, 'floatdescriptors', true) ;