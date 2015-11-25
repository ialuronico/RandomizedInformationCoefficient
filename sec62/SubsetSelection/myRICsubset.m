function [whichFeat, newSelected]=myRICsubset(a,C,nfeature,alreadySelected)
[n dim]=size(a);

if (nfeature > 1)
    oldSet = alreadySelected(1:nfeature-1);
    vals = zeros(1,dim);
    parfor j=1:dim
        newSet = union(oldSet,[j]);        
        if (length(newSet) > length(oldSet))
            vals(j) = RICrndSeeds(a(:,newSet)',C');
        else
            vals(j) = 0;
        end
    end
    [~, newSelected] = max(vals);
    whichFeat = union(oldSet, newSelected);
else
    vals = zeros(1,dim);
    parfor j=1:dim
        vals(j) = RICrndSeeds(a(:,j)',C');        
    end
    [~, newSelected] = max(vals);
    whichFeat = newSelected;
end
