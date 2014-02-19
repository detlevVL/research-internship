function showMultipleWords(imageIDs, vocids, numImages, names, vocabulary)
% Given a vector of imageIDs, a vector of vocids, and an amount of images
% to show.
% Creates figures containing at most numImages images, and displays the
% keypoints which correspond to the descriptors which were projected to the
% visual words with id equal to the vocids.

colors = [ 'r' 'b' 'g' 'y' 'm' 'c' ];

% too many words too show clearly
if length(vocids) > length(colors)
    warning('Too many words to display clearly.\n');
    return;
end

% create figures containing numImages images
for i = 1:ceil(length(imageIDs)/numImages)
    figure;

    % which images to show in this figure
    low = (i-1) * numImages + 1; % if i = 1 => start from image 1
    high = i * numImages; % if i = 1 => end at image numImages   
    high = min(high,length(imageIDs));

    amount = high - low + 1;

    % for each image we will draw on the words
    for j = 1:amount
        imID = imageIDs(low + j - 1);
        im = imread(names{imID});
        im = standardizeImage(im);
        
        vl_tightsubplot(amount,j);
        
        imshow(im);
        str=sprintf('%i', imID);
        text(25,25,str,'FontSize',12,'FontWeight','bold');
        
        [keypoints, descriptors] = computeFeatures(im);
        [words, distances] = quantizeDescriptors(vocabulary, descriptors);

        % draw each word
        for k = 1:length(vocids)
            % find the visual words equal to word vocid
            inds = find(words == vocids(k)) ;
            if isempty(inds), 
                warning('Word %i does not occur in image %i.\n', vocids(k), imID);
            	continue;
            end
            
            [drop, perm_] = sort(distances(inds), 'descend') ;
            perm_ = vl_colsubset(perm_, 25*25, 'beginning') ;

            for j = 1:numel(perm_)
                u0 = keypoints(1,inds(perm_(j))) ;
                v0 = keypoints(2,inds(perm_(j))) ;
                s0 = keypoints(4,inds(perm_(j))) ;

                delta = round(s0*2) ;
                u1 = max(1,u0-delta) ;
                u2 = min(size(im,2),u0+delta) ;
                v1 = max(1,v0-delta) ;
                v2 = min(size(im,1),v0+delta) ;
            end
            
            hold on ;
            kp = keypoints([1 2 4], inds) ;
            kp(3,:) = kp(3,:) * 2 ;
            vl_plotframe(kp, 'linewidth', 2, 'color', colors(k)) ;
            axis image ;
        end
    end
end