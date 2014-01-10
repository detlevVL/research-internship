function histograms = computeBagOfWords(vocabulary, names)

parfor i = 1:length(names)
  if exist(names{i}, 'file')
    fullPath = names{i} ;
  else
    fullPath = fullfile('data','images',[names{i} '.jpg']) ;
  end

  fprintf('Extracting histogram from %s\n', fullPath) ;
  histograms{i} = computeHistogramFromImage(vocabulary, fullPath) ;
end
histograms = [histograms{:}] ;

% turn histograms into bag-of-visual-words representation
histograms = removeSpatialInformation(histograms) ;
