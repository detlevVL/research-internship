function showClusteringOutput(filename, numDims, clusterID, names, vocabulary, varargin)
% Given an outputfile from carticlus/weka, the number of dimensions, and
% the ID of a cluster. This funcion shows all the relevant words on the 
% images of the cluster. 
% It does this over multiple figures to try and keep things clear.
% It shows a certain amount of words at a time, waiting on user input
% before showing the next words.
% Use showClusteringOutput(..., 'numImages', N) to change the amount of 
% images displayed in one figure.
% Use showClusteringOutput(..., 'numWords', K) to change the amount of 
% words displayed at a time.
% Default numImages = 16, numWords = 2

opts.numImages = 16;
opts.numWords = 2;
opts = vl_argparse(opts,varargin);

% parse file
[dimensions, ~, imageIDs] = parseOutputFile(filename, numDims);

% get the image ids for the cluster we want
imageIDs = imageIDs(clusterID,:);
% get the vocabulary ids for the cluster we want
vocids = find(dimensions(clusterID,:) == 1);

% remove zeros from end of imageIDs
imageIDs(imageIDs==0) = [];
% carticlus/weka starts from ID 0
imageIDs = imageIDs + 1;

fprintf('Cluster %i contains %i images, clustered on %i words\n', clusterID, length(imageIDs) ,length(vocids)) ;

% show numWords words at a time
for i = 1:ceil(length(vocids)/opts.numWords)
    % which words to show
    low = (i-1) * opts.numWords + 1; % if i = 1 => start from word 1
    high = i * opts.numWords; % if i = 1 => end at word numWords   
    high = min(high,length(vocids));
    
    words = vocids(low:high);
    
    % PART 1: show the images with the words encircled
    showMultipleWords(imageIDs, words, opts.numImages, names, vocabulary);
    
    % PART 2: show some examples of the words
    showExampleWords(imageIDs, words, names, vocabulary);
    
    fprintf('Press any key to show the next word(s).\n') ;
    pause; % wait for user input to show next word(s)
end
fprintf('All words have been shown.\n') ;
