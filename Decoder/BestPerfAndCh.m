function [BestPerf, BestCh, MeanWeights, StdWeights, Threshold] = BestPerfAndCh(varargin)

%
%   [BestPerf, BestCh, MeanWeights, StdWeights, Threshold] = BestPerfAndCh(varargin)
%   
%   This function is the effective decoder. It could be used in different ways, depending 
%   on the number of input parameters.
%
%   i)One arg
%       Params = decoding parameters
%   The function computes the 50 best sets of c channels (determined by the
%   parameter NoC in computeMUAandEvents) whith their performance. Then the
%   channels are selected by the function SelectChannels;
%       BestPerf = performances of the 50 sets
%       BestCh = channels selected in each set
%   
%   ii) Two args
%       Params = decoding parameters
%       SelCh = selected decoding channels (eventually in the previous step)
%   The function evaluates the performances (accuracy on two or three
%   classes) and the mean weights for the selected set over 10 computations
%   and the standard deviation of these weights;
%       BestPerf = average accuracy for the training and test set across
%           realizations
%       MeanWeights = mean value of the computed weights
%       StdWeights = standard deviation of the computed weights
%       Threshold = optimal AUC threshold for the classification
%
%   iii) Three args
%       Params = decoding parameters
%       SelCh = selected decoding channels
%       MeanWeights = computed mean weights (eventually in the previous step)
%   The function evaluates the accuracy after averaging on the weights.
%       BestPerf = accuracy for the training and test set using averaged
%           weights (important to verify in the previous step that stdWeights is small
%           to avoid overfitting in this step)
%       Threshold = optimal AUC threshold for the classification
%
%   iv) Four args
%       Params = decoding parameters
%       SelCh = selected decoding channels
%       MeanWeights = computed mean weights
%       rand = the request to do a random decoding
%   The function computes the accuracy for a random target to set 
%   the baseline of the performances.
%       BestPerf = performance of a random classifier
%       Threshold = optimal AUC threshold for a random classifier
%

Params = varargin{1};
EC = setEncodes();
[Data, CorrectTrials,ErrorTrials] = computeMUAandEvents(Params);
% [P_tot, T] = InputOutput(Params,CorrectTrials,0);

if Params.output==2
    [P_tot, T] = InputOutput(Params,CorrectTrials,0);
%     [P_tot1, T1] = InputOutput(Params,CorrectTrials,0);
%     [P_tot2, T2] = InputOutput(Params,ErrorTrials,0);
%     T2 = -T2;
%     P_tot = [P_tot1 P_tot2];
%     T = [T1 T2];
else
    [P_tot, T] = InputOutput(Params,CorrectTrials,0);
%     [P_tot1, T1] = InputOutput(Params,CorrectTrials,0);
%     [P_tot2, T2] = InputOutput(Params,ErrorTrials,0);
%     P_tot = [P_tot1 P_tot2];
%     T = [T1 T2];
end


if Params.output==1
    cond=7;
else
    cond=1;
end

if nargin==1
    MeanWeights = [];
    StdWeights = [];
    BestPerf = [];
    BestCh= {};
    NoC = size(Data.NoC,2);
    for Cnd=1:cond
        for c=Data.NoC
            ch_fin =[];
            score_fin = [];
            BestRs = [];
            Scores = [];
            RsOfBC = [];
            ndxBC = [];
            for a=1:50
                f = find(T(Cnd,:)==1);
                [k,l] = BalancedReshuffling(f,T);
                PI = struct('ndxC', [], 'Weights', [], 'R', []);
                NoR = 500;
                NoRC = Data.NoC(c);
                for nr = 1:NoR
                    ndxC = randperm(size(Data.Ch,2));
                    ndxC = ndxC(1:NoRC);
                    OutReal = T(Cnd,k)';
                    RealTest = T(Cnd,l)';
                    Weights = mldivide([P_tot(ndxC,k)' ones(numel(k),1)],OutReal);
                    OutTest = [P_tot(ndxC,l)' ones(numel(l),1)]*Weights;
                    OutLear = [P_tot(ndxC,k)' ones(numel(k),1)]*Weights;
                    [X Y t AUC] = perfcurve(RealTest, OutTest, '1');
                    PI.ndxC(nr,:,a) = ndxC;
                    PI.Weights(nr,:,a) = Weights;
                    PI.R(nr,a) = AUC;
                end
                NoBR = 50;
                RhoRange = [0.3 1];
                [R,ndxR] = sort(PI.R(:,a));
                ndxR = ndxR(end-NoBR+1:end)';
                Ws = zeros(NoC,NoBR);
                p = 0;
                for nr = ndxR
                    p = p + 1;
                    Ws(PI.ndxC(nr,:,a),p) = PI.Weights(nr,1:end-1,a)';
                end
                BestRs(:,a) = R(end-NoBR+1:end);
                X = mean(abs(Ws),2);
                Y = std(Ws,[],2);
                Scores(:,a) = X;
                [val ndx] = sort(Scores(:,a));
                BestCh{a,c,Cnd} = ndx(end-NoRC+1:end);
                OutReal = T(Cnd,k)';
                RealTest = T(Cnd,l)';
                Weights = mldivide([P_tot(BestCh{a,c,Cnd},k)' ones(numel(k),1)],OutReal);
                OutTest = [P_tot(BestCh{a,c,Cnd},l)' ones(numel(l),1)]*Weights;
                OutLear = [P_tot(BestCh{a,c,Cnd},k)' ones(numel(k),1)]*Weights;
                [X Y t AUC] = perfcurve(RealTest, OutTest, '1');
                BestPerf(Cnd,a,c) = AUC;
            end
        end
    end
elseif nargin==2
    selch = varargin{2};
    BestPerf = {};
    Weights ={};
    accuracyTest = [];
    accuracyTrain = [];
    for Cnd=1:cond
        BestCh=selch{Cnd};
        for a=1:100
            if Params.output==1
                if Params.target==1
                    f = find(T(Cnd,:)==1);
                    g = find(T(Cnd,:)==-1);
                    z = find(T(Cnd,:)==0);
                    temp = round(0.7*numel(f));
                    fr = randperm(numel(f));
                    frt = f(fr(1:temp));
                    temp = round(0.7*numel(g));
                    gr = randperm(numel(g));
                    grt = g(gr(1:temp));
                    zr = randperm(numel(z));
                    zrt = z(zr(1:numel(fr)));
                    k = [frt grt zrt];
                    ft = setdiff(f,frt);
                    gt = setdiff(g,grt);
                    zt = z(zr(numel(fr):numel(fr)+numel(ft)));
                    l = [ft gt zt];
                else
                    f = find(T(Cnd,:)==1);
                    [k,l] = BalancedReshuffling(f,T);
                end
            else
                f = find(T(Cnd,:)==1);
                g = find(T(Cnd,:)==-1);
                if numel(f)>numel(g)
                    [k,l] = BalancedReshuffling(g,T);
                else
                    [k,l] = BalancedReshuffling(f,T);
                end
            end

            OutReal = T(Cnd,k)';
            RealTest = T(Cnd,l)';
            Weights{a,Cnd} = mldivide([P_tot(BestCh,k)' ones(numel(k),1)],OutReal);
            OutTest = [P_tot(BestCh,l)' ones(numel(l),1)]*Weights{a,Cnd};
            OutTrain = [P_tot(BestCh,k)' ones(numel(k),1)]*Weights{a,Cnd};
            if Params.output==1
                if Params.target==1
                    labels = [-1,1];
                else
                    labels = [1];
                end
            else
                labels = [1];
            end
                Threshold = findThreshold(labels,OutReal, OutTrain);
                
                if Params.output==1
                    if Params.target==1
                        for num=1:size(OutTest,1)
                            if OutTest(num,:)>Threshold(find(labels==1))
                                OutTest(num,:)=1;
                            elseif OutTest(num,:)<Threshold(find(labels==-1))
                                OutTest(num,:)=-1;
                            else
                                OutTest(num,:)=0;
                            end
                        end
                        
                        for num=1:size(OutTrain,1)
                            if OutTrain(num,:)>Threshold(find(labels==1))
                                OutTrain(num,:)=1;
                            elseif OutTrain(num,:)<Threshold(find(labels==-1))
                                OutTrain(num,:)=-1;
                            else
                                OutTrain(num,:)=0;
                            end
                        end
                        accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                        accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                    else
                        for num=1:size(OutTest,1)
                            if OutTest(num,:)>Threshold
                                OutTest(num,:)=1;
                            else
                                OutTest(num,:)=0;
                            end
                        end
                        
                        for num=1:size(OutTrain,1)
                            if OutTrain(num,:)>Threshold
                                OutTrain(num,:)=1;
                            else
                                OutTrain(num,:)=0;
                            end
                        end
                        accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                        accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                    end
                else
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>Threshold
                            OutTest(num,:)=1;
                        else
                            OutTest(num,:)=-1;
                        end
                    end
                    
                    for num=1:size(OutTrain,1)
                        if OutTrain(num,:)>Threshold
                            OutTrain(num,:)=1;
                        else
                            OutTrain(num,:)=-1;
                        end
                    end
                    accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                    accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                end
            end
        end
  
    BestPerf{1} = mean(accuracyTrain,1);
    BestPerf{2} = mean(accuracyTest,1);
    
    MeanWeights={};
    for i=1:cond
        r=[];
        for j=1:10
            r(:,j) = Weights{j,i};
        end
        MeanWeights{i} = mean(r,2);
        StdWeights{i} = std(r');
    end
    
elseif nargin ==3
%     T=T1;
%     P_tot=P_tot1;
    selch = varargin{2};
    weights = varargin{3};
    BestPerf = [];
    MeanWeights = [];
    StdWeights = [];
    accuracyTest = [];
    Threshold = [];
    for Cnd=1:cond
        BestCh=selch{Cnd};
        Weights = weights{Cnd};
        for a=1:10
            if Params.output==1
                if Params.target==1
                    f = find(T(Cnd,:)==1);
                    g = find(T(Cnd,:)==-1);
                    z = find(T(Cnd,:)==0);
                    temp = round(0.7*numel(f));
                    fr = randperm(numel(f));
                    frt = f(fr(1:temp));
                    temp = round(0.7*numel(g));
                    gr = randperm(numel(g));
                    grt = g(gr(1:temp));
                    zr = randperm(numel(z));
                    zrt = z(zr(1:numel(fr)));
                    k = [frt grt zrt];
                    ft = setdiff(f,frt);
                    gt = setdiff(g,grt);
                    zt = z(zr(numel(fr):numel(fr)+numel(ft)));
                    l = [ft gt zt];
                else
                    f = find(T(Cnd,:)==1);
                    [k,l] = BalancedReshuffling(f,T);
                end
            else
                f = find(T(Cnd,:)==1);
                g = find(T(Cnd,:)==-1);
                if size(f,2)<size(g,2)
                    [k,l] = BalancedReshuffling(f,T);
                else
                    [k,l] = BalancedReshuffling(g,T);
                end
            end
            OutReal = T(Cnd,k)';
            RealTest = T(Cnd,l)';
            OutTest = [P_tot(BestCh,l)' ones(numel(l),1)]*Weights;
            OutTrain = [P_tot(BestCh,k)' ones(numel(k),1)]*Weights;
            if Params.output==1
                if Params.target==1
                    labels = [-1,1];
                else
                    labels = [1];
                end
            else
                labels = [1];
            end
                Threshold = findThreshold(labels,OutReal, OutTrain);
                
                if Params.output==1
                    if Params.target==1
                        for num=1:size(OutTest,1)
                            if OutTest(num,:)>Threshold(find(labels==1))
                                OutTest(num,:)=1;
                            elseif OutTest(num,:)<Threshold(find(labels==-1))
                                OutTest(num,:)=-1;
                            else
                                OutTest(num,:)=0;
                            end
                        end
                        
                        for num=1:size(OutTrain,1)
                            if OutTrain(num,:)>Threshold(find(labels==1))
                                OutTrain(num,:)=1;
                            elseif OutTrain(num,:)<Threshold(find(labels==-1))
                                OutTrain(num,:)=-1;
                            else
                                OutTrain(num,:)=0;
                            end
                        end
                        accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                        accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                    else
                        for num=1:size(OutTest,1)
                            if OutTest(num,:)>Threshold
                                OutTest(num,:)=1;
                            else
                                OutTest(num,:)=0;
                            end
                        end
                        
                        for num=1:size(OutTrain,1)
                            if OutTrain(num,:)>Threshold
                                OutTrain(num,:)=1;
                            else
                                OutTrain(num,:)=0;
                            end
                        end
                        accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                        accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                    end
                else
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>Threshold
                            OutTest(num,:)=1;
                        else
                            OutTest(num,:)=-1;
                        end
                    end
                    
                    for num=1:size(OutTrain,1)
                        if OutTrain(num,:)>Threshold
                            OutTrain(num,:)=1;
                        else
                            OutTrain(num,:)=-1;
                        end
                    end
                    accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                    accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                end
            end
        end
  
    BestPerf{1} = mean(accuracyTrain,1);
    BestPerf{2} = mean(accuracyTest,1);
    
    
elseif nargin == 4
    selch = varargin{2};
    weights = varargin{3};
    BestPerf = [];
    
    for Cnd=1:cond
        BestCh=selch{Cnd};
        Weights = weights{Cnd};
        MeanWeights = [];
        StdWeights = [];
        for a=1:50
            T(Cnd,:)= T(Cnd,randperm(size(T,2)));
            if Params.output==1
                if Params.target==1
                    f = find(T(Cnd,:)==1);
                    g = find(T(Cnd,:)==-1);
                    z = find(T(Cnd,:)==0);
                    temp = round(0.7*numel(f));
                    fr = randperm(numel(f));
                    frt = f(fr(1:temp));
                    temp = round(0.7*numel(g));
                    gr = randperm(numel(g));
                    grt = g(gr(1:temp));
                    zr = randperm(numel(z));
                    zrt = z(zr(1:numel(fr)));
                    k = [frt grt zrt];
                    ft = setdiff(f,frt);
                    gt = setdiff(g,grt);
                    zt = z(zr(numel(fr):numel(fr)+numel(ft)));
                    l = [ft gt zt];
                else
                    f = find(T(Cnd,:)==1);
                    [k,l] = BalancedReshuffling(f,T);
                end
            else
                f = find(T(Cnd,:)==1);
                g = find(T(Cnd,:)==-1);
                if size(f)>size(g)
                    [k,l] = BalancedReshuffling(f,T);
                else
                    [k,l] = BalancedReshuffling(g,T);
                end
            end
            OutReal = T(Cnd,k)';
            RealTest = T(Cnd,l)';
            OutTest = [P_tot(BestCh,l)' ones(numel(l),1)]*Weights;
            OutTrain = [P_tot(BestCh,k)' ones(numel(k),1)]*Weights;
            if find(T==-1)~=0
                labels = [-1,1];
            else
                labels = [1];
            end
            
            Threshold = findThreshold(labels,OutReal, OutTrain);
            
            if Params.output==1
                if Params.target==1
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>Threshold(find(labels==1))
                            OutTest(num,:)=1;
                        elseif OutTest(num,:)<Threshold(find(labels==-1))
                            OutTest(num,:)=-1;
                        else
                            OutTest(num,:)=0;
                        end
                    end
                    
                    for num=1:size(OutTrain,1)
                        if OutTrain(num,:)>Threshold(find(labels==1))
                            OutTrain(num,:)=1;
                        elseif OutTrain(num,:)<Threshold(find(labels==-1))
                            OutTrain(num,:)=-1;
                        else
                            OutTrain(num,:)=0;
                        end
                    end
                    accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                    accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                else
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>Threshold
                            OutTest(num,:)=1;
                        else
                            OutTest(num,:)=0;
                        end
                    end
                    
                    for num=1:size(OutTrain,1)
                        if OutTrain(num,:)>Threshold
                            OutTrain(num,:)=1;
                        else
                            OutTrain(num,:)=0;
                        end
                    end
                    accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                    accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
                end
            else
                for num=1:size(OutTest,1)
                    if OutTest(num,:)>Threshold
                        OutTest(num,:)=1;
                    else
                        OutTest(num,:)=-1;
                    end
                end
                
                for num=1:size(OutTrain,1)
                    if OutTrain(num,:)>Threshold
                        OutTrain(num,:)=1;
                    else
                        OutTrain(num,:)=-1;
                    end
                end
                accuracyTest(a,Cnd) = sum(RealTest == OutTest,'all')/numel(OutTest);
                accuracyTrain(a,Cnd) = sum(OutReal == OutTrain,'all')/numel(OutTrain);
            end
        end
    end
    
    BestPerf{1} = accuracyTrain;
    BestPerf{2} = accuracyTest;
end
 


        