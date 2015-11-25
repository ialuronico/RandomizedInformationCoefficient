function [whichFeat, newSelected]=myMI_efsubset(a,C,nfeature,alreadySelected)
[n dim]=size(a);

Dx = 2;
Dy = 5;

if (nfeature > 1)
    oldSet = alreadySelected(1:nfeature-1);
    vals = zeros(1,dim);
    parfor j=1:dim
        newSet = union(oldSet,[j]);
        m = length(newSet);
        if (length(newSet) > length(oldSet))
            x_d = myQuantileDiscretize(a(:,newSet), Dx);
            b = myQuantileDiscretize(C, Dy);
            % encode it
            x_d = (x_d-1)*([1,(1:m-1)*Dx])' + 1;
            %MI_ef = mi(a',b');
            MI_ef = computeMI(x_d',b');
            vals(j) = MI_ef;
        else
            vals(j) = 0;
        end
    end
    [~, newSelected] = max(vals);
    whichFeat = union(oldSet, newSelected);
else
    vals = zeros(1,dim);
    parfor j=1:dim        
            x_d = myQuantileDiscretize(a(:,j), Dx);
            b = myQuantileDiscretize(C, Dy);
            %MI_ef = mi(a',b');
            MI_ef = computeMI(x_d',b');
            vals(j) = MI_ef;        
    end

    [~, newSelected] = max(vals);
    whichFeat = newSelected;
end
