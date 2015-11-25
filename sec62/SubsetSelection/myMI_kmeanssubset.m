function [whichFeat, newSelected]=myMI_kmeanssubset(a,C,nfeature,alreadySelected)
[n dim]=size(a);

D = floor(sqrt(n/5));

if (nfeature > 1)
    oldSet = alreadySelected(1:nfeature-1);
    vals = zeros(1,dim);
    parfor j=1:dim
        newSet = union(oldSet,[j]);        
        if (length(newSet) > length(oldSet))
            x_d = kmeans(a(:,newSet),D);
            b = kmeans(C,D);
            %MI_cell = mi(a',b');
            MI_cell = computeMI(x_d',b');
            vals(j) = MI_cell;
        else
            vals(j) = 0;
        end
    end
    [~, newSelected] = max(vals);
    whichFeat = union(oldSet, newSelected);
else
    vals = zeros(1,dim);
    parfor j=1:dim
        x_d = kmeans(a(:,j),D);
        b = kmeans(C,D);
        %MI_cell = mi(a',b');
        MI_cell = computeMI(x_d',b');
        vals(j) = MI_cell;   
    end

    [~, newSelected] = max(vals);
    whichFeat = newSelected;
end
