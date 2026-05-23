function [vecDif, vecSum] = SumDif(Dx, Sx);

%
% [vecDif, vecSum] = SumDif(Dx, Sx)
% 
% This function computes the sum and the difference between vectors.
%
%   Dx = right decoding vector
%   Sx = left decoding vector
%
%   vecDif = difference between vectors (equivalent to Orig)
%   vecSum = sum of the vectors (equivalent to Pure)
%

cond = 7;
vecSum = {};
for i=1:cond
    vecSum{i} = Dx{i}+Sx{i};
end
vecDif = {};
for i=1:cond
    vecDif{i} = Dx{i}-Sx{i};
end

