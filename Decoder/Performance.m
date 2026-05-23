function [Perf, Random, pVal, Significancy,RandT] = Performance(Params, selch, weights);

%
%   [Perf, Random, pVal, Significancy,RandT] = Performance(Params, selch, weights)
%
%   This function returns decoding performances of the input vector
%   together with their significance with respect to a random decoding.
%
%   Params = decoding parameters
%   selch = decoding channels
%   weights = decoding vectors to evaluate
%
%   Perf = performance of the decoding vectors
%   Random = performance of a random decoding vector
%   pVal = p-value evaluating the significance of the decoding with respect
%       to chance level (Wilcoxon ranksum test)
%   Significancy = 0 indicates two distributions are the same (no significancy)
%       1 indicates they are different (correct decoding)
%   RandT = decoding threshold of a random decoder
%

Perf = BestPerfAndCh(Params, selch,weights);
[Random,~,~,~,RandT] = BestPerfAndCh(Params, selch,weights,rand);

Perf = Perf{2};
Random = Random{2};

for i=1:size(Perf,2)
    [p(i), h(i)] = ranksum(Perf(:,i),mean(Random,2));
end

g  = zeros(1,size(Perf,2));

for i=1:size(Perf,2)
    if p(i)<Params.pThreshold
        g(i) = 1;
    end
end
pVal = p;
Significancy = g;