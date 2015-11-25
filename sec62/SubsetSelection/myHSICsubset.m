function [whichFeat, newSelected]=myRICsubset(a,C,nfeature,alreadySelected)
[n dim]=size(a);

%disp(Ds);

if (nfeature > 1)
    oldSet = alreadySelected(1:nfeature-1);
    vals = zeros(1,dim);
    parfor j=1:dim
        newSet = union(oldSet,[j]);        
        if (length(newSet) > length(oldSet))
            vals(j) = computeHSIC(a(:,newSet),C);
        else
            vals(j) = 0;
        end
    end
    [~, newSelected] = max(vals);
    whichFeat = union(oldSet, newSelected);
else
    vals = zeros(1,dim);
    parfor j=1:dim        
        vals(j) = computeHSIC(a(:,j),C);
    end

    [~, newSelected] = max(vals);
    whichFeat = newSelected;
end
