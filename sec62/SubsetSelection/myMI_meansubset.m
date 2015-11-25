function [whichFeat, newSelected]=myMI_meansubset(a,C,nfeature,alreadySelected)
[n dim]=size(a);

if (nfeature > 1)
    oldSet = alreadySelected(1:nfeature-1);
    vals = zeros(1,dim);
    parfor j=1:dim
        newSet = union(oldSet,[j]);        
        if (length(newSet) > length(oldSet))
            vals(j) = 1000 + Imean(a(:,newSet)',C'); %problems with 0
        else
            vals(j) = 0;
        end
    end
    
    [~, newSelected] = max(vals);
    whichFeat = union(oldSet, newSelected);
else
    vals = zeros(1,dim);
    parfor j=1:dim
        vals(j) = 1000 + Imean(a(:,j)',C'); % problems with 0
    end
    [~, newSelected] = max(vals);
    whichFeat = newSelected;
end
