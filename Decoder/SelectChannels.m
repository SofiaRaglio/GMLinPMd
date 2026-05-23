function [SelCh, EachSet] = SelectChannels(Params, BestPerf, BestCh)

%
%   [SelCh, EachSet] = SelectChannels(Params, BestPerf, BestCh)
%
%   This function selects the best channels among different sets with
%   different size.
%
%   Params = decoder parameters
%   BestPerf = performances of different sets of channels
%   BestCh = best channels selected in each set with a specific size
%
%   SelCh = best channels selected to decode each symbol (motor decision).
%       We first select the set of BestCh corresponding to the BestPerf and
%       then save the channels that occures more times than chance level
%   EachSet = the performances of all the sets tested to choose SelCh
%

Data=computeMUAandEvents(Params);

for i=1:size(BestPerf,3)
    Perf(:,i) = mean(BestPerf(:,:,i),2);
end

if Params.output==1
    cond=7;
else
    cond=1;
end

ChTot=Data.Ch;

for i=1:cond
    maxPerf(i)=find(Perf(i,:)==max(Perf(i,:)));
end

Ch={};
for i=1:cond
    Channels = [];
    for j=1:50
        Channels(:,j) = BestCh{j,maxPerf(i),i};
        Ch{i} = Channels;
    end
end

for i=1:cond
    a = Ch{i};
    bin = nchoosek(ChTot,size(a,1));
    bi = nchoosek((ChTot-1),(size(a,1)-1));
    p = bi/bin;
    q = 1-p;
    for j=1:size(a,2)
        pval(i,j) = (p.^j)*(q.^(50-j))*(nchoosek(50,j));
    end
end

channel = {};
count ={};
for i=1:cond
    f = reshape(Ch{i}, [1 size(Ch{i},1)*size(Ch{i},2)]);
    e = sort(f);
    [GC GR] = groupcounts(e');
    [val ndx] = sort(GC);
    count{i} = val;
    channel{i} = GR(ndx);
end

c = [];
for i=1:cond
    c(i) = find(pval(i,9:end)<0.001,1);
end
c = 8+c;

SelCh = {};
for i=1:cond
    d(i) = find(count{i}>=c(i),1);
    SelCh{i} = channel{i}(d(i):end);
end

EachSet = {};
for i=1:size(BestCh,2)
    for j=1:cond
        Channels = [];
        GC = [];
        GR = [];
        val = [];
        ndx = [];
        ch = [];
        for k=1:50
            Channels(:,k) = BestCh{k,i,j};
        end
        Channels = sort(reshape(Channels, [1 size(Channels,1)*size(Channels,2)]));
        [GC GR] = groupcounts(Channels');
        [val ndx] = sort(GC);
        ch = GR(ndx);
        EachSet{i,j} = ch((end-i+1):end);
    end
end
