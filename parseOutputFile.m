function [dimensions, numImages, imageIDs] = parseOutputFile(filename, numWords)
% parses an outputfile from either carticlus or weka
% this function assumes the files are correct, e.g. the format has not been
% modified
% returns: (where k is the amount of clusters)
% dimensions = a k * numWords matrix indicating on which dimensions each
%              cluster was formed
% numImages = a vector of size k containing the amount of images in each
%             cluster
% imageIDs = a k * max(numImages) matrix indicating which imageIDs are in
%            each cluster

fid = fopen(filename);
i = 1;
tline = fgetl(fid);

while ischar(tline)
    % find out type of outputfile (weka outputfiles start with 'SC_x: ')
    if tline(1) ~= 'S'
        % carticlus outputfile
        x = str2num(tline);
        
        % dimensions => first numWords values
        dimensions(i,:) = x(1:numWords); 
        
        % numImages => value numWords + 1
        numImages(i) = x(numWords+1); 
        
        % imageIDs => values numWords + 2 until the end
        imageIDs(i,1:numImages(i)) = x(numWords+2:end); 
    else
        % weka outputfile
        % dimensions => from '[' until ']'
        startDim = find(tline == '[') + 1;
        endDim = find(tline == ']') - 1;
        dimensions(i,:) = str2num(tline(startDim:endDim));
        
        % numimages => from '#' until '{'
        startNumImages = find(tline == '#') + 1;
        endNumimages = find(tline == '{') - 1;
        numImages(i) = str2num(tline(startNumImages:endNumimages));
        
        % imageIDs => from '{' until '}'
        startIDs = find(tline == '{') + 1;
        endIDs = find(tline == '}') - 1;
        imageIDs(i,1:numImages(i)) = str2num(tline(startIDs:endIDs));
    end
    
    tline = fgetl(fid);
    i = i + 1;
end
fclose(fid);