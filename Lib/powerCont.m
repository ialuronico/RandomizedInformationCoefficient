% Computes the power in discriminating between the negative 
% and the positive class (alpha = 0.05)
function [ power_ ] = powerCont( neg, pos)

npos = length(pos);
cut=quantile(neg,.95);
power_ = sum(pos> cut)/npos;

end

