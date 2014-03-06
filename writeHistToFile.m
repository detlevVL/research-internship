function writeHistToFile(histograms, filename, numDims)

transpHisto = transpose(histograms);
fid = fopen(filename, 'wt');
specifier = [repmat('%4.10f ', 1, numDims) '\n'];
fprintf(fid, specifier, transpHisto.');
fclose(fid);
