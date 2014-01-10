function writeHistToFile(histograms, filename)

transpHisto = transpose(histograms);
fid = fopen(filename, 'wt');
specifier = [repmat('%4.10f ', 1, 1000) '\n'];
fprintf(fid, specifier, transpHisto.');
fclose(fid);
