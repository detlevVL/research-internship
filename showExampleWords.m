function showExampleWords(imageIDs, vocids, names, vocabulary);
% creates a figure containing the image and displays its keypoints
% which correspond to the descriptors which were projected to the
% visual word with id = vocid

colors = [ 'r' 'b' 'g' 'y' 'm' 'c' ];

% too many words too show clearly
if length(vocids) > length(colors)
    warning('Too many words to display clearly.\n');
    return;
end

low = floor(sqrt(length(vocids)));
high = ceil(sqrt(length(vocids)));

figure;
for i = 1:length(vocids)
    subplot(low,high,i);
    
    im = imread(names{imageIDs(1)});
    im0 = standardizeImage(im);

    [keypoints, descriptors] = computeFeatures(im);
    [words, distances] = quantizeDescriptors(vocabulary, descriptors);

    % find the visual words equal to word vocid
    inds = find(words == vocids(i)) ;
    if isempty(inds), 
        warning('This word does not occur in this image.');
        return;;
    end

    [drop, perm_] = sort(distances(inds), 'descend') ;
    perm_ = vl_colsubset(perm_, 25*25, 'beginning') ;

    patches = cell(1, numel(perm_)) ;
    for j = 1:numel(perm_)
        u0 = keypoints(1,inds(perm_(j))) ;
        v0 = keypoints(2,inds(perm_(j))) ;
        s0 = keypoints(4,inds(perm_(j))) ;

        delta = round(s0*2) ;
        u1 = max(1,u0-delta) ;
        u2 = min(size(im0,2),u0+delta) ;
        v1 = max(1,v0-delta) ;
        v2 = min(size(im0,1),v0+delta) ;
        patches{j} = imresize(im0(v1:v2,u1:u2,:),[32 32]) ;
    end

    if isempty(patches)
        warning('Visual word %d no matches found.') ;
        return;
    end

    composite = cat(4,patches{:}) ;
    composite = max(0,min(1,composite)) ;
    [drop, perm__] = sort(distances(inds(perm_)), 'descend') ;
    composite = composite(:,:,:,perm__) ;

    if ndims(composite) > 3
        vl_imarray(composite) ;
    else
        image(composite) ;
    end

    set(gca,'xtick',[],'ytick',[]) ; axis image ;
    axis image ;
    title(sprintf('Visual word %d (color: %s)', vocids(i),colors(i)));

end

