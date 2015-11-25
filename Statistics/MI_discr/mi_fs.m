% This function computes the Cellucci Mutual Information
% It comes from the MIDER framework cited in the paper.

function [mi_fs_] = mi_fs(x,y,fraction)
    pb = 5;
    [fracn, contingency] = estimateFrac(x,y,pb); 
    while fracn < fraction; 
        pb = pb+1;
        [fracn, contingency] = estimateFrac(x,y,pb); 
    end
    mi_fs_ = mi(contingency); 
end

