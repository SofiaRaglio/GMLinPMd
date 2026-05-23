function vec = createVector(Params,selch, weights)

%
%   vec = createVector(Params,selch, weights)
%
%   This function creates vectors (or sets of vectors) given the best
%   channels and their decoding weights
%
%   Params = decoding parameters
%   selch = the best decoding channels
%   weights = the decoding weights
%
%   vec = the final vector (with weight 0 corresponding to non-selch and the proper weight for all the selch)
%

Data=computeMUAandEvents(Params);

if Params.output==1
    cond=7;
else
    cond=1;
end

ch=numel(Data.Ch);


vec = {};
for i=1:cond
    vector=zeros(ch+1,1);
    channels  = selch{i};
    we = weights{i};
    for j=1:numel(channels)
        vector(channels(j)) = we(j);
        vector(ch+1) = we(end);
    end
    vec{i} = vector;
end