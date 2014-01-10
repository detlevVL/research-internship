minimum = 1;
mindist = 1000000;

for i = 3:1000
    d = sqrt(sum((firstcol - histograms(:,i)).^2));
    if d < mindist
        mindist = d;
        minimum = i;
    end
end
fprintf('i = %i\n',minimum);