function [PerfInTime, Baseline] = FromPairOn(Params,selch, weights,Threshold,RandT);

%
%   [PerfInTime, Baseline] = FromPairOn(Params,selch, weights,Threshold,RandT);
%
%   This function returns the accuracy of the decoding in time.
%
%   Params = decoding parameters
%   selch = selected decoding channels
%   weights = decoding vectors
%   Threshold = classification threshold computed as AUC optimal threshold
%   RandT = threshold for the random classifier
%
%   PerfInTime = accuracy of classifier before and after PairOn (time interval given in Params.TestedT)
%   Baseline = accuracy of random classifier
%

[Data,CorrectTrials] = computeMUAandEvents(Params);
[P_tot, T] = InputOutput(Params,CorrectTrials,1);

if Params.output==1
    cond=7;
else
    cond=1;
end

TestedTimes=Params.TestedT;
RsOfAllBC = [];
PerfInTime = [];
Baseline = [];
for a=1:50
    for Cnd =1:cond
        BestCh=selch{Cnd};
        Weights=weights{Cnd};
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
        RealTest = T(Cnd,k)';
        RandomTest = T(Cnd,randperm(numel(k)))';
        for nt=1:numel(TestedTimes)
            OutTest = [P_tot(BestCh,k,nt)' ones(numel(k),1)]*Weights;
            RandOut = zeros(size(OutTest,1),size(OutTest,2));
            if Params.output==1
                if Params.target==1
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>Threshold(2)
                            OutTest(num,:)=1;
                        elseif OutTest(num,:)<Threshold(1)
                            OutTest(num,:)=-1;
                        else
                            OutTest(num,:)=0;
                        end
                    end
                else
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>Threshold
                            OutTest(num,:)=1;
                        else
                            OutTest(num,:)=0;
                        end
                    end
                end
            else
                for num=1:size(OutTest,1)
                    if OutTest(num,:)>Threshold
                        OutTest(num,:)=1;
                    else
                        OutTest(num,:)=-1;
                    end
                end
            end 
            if Params.output==1
                if Params.target==1
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>RandT(2)
                            RandOut(num,:)=1;
                        elseif OutTest(num,:)<RandT(1)
                            RandOut(num,:)=-1;
                        else
                            RandOut(num,:)=0;
                        end
                    end
                else
                    for num=1:size(OutTest,1)
                        if OutTest(num,:)>RandT
                            RandOut(num,:)=1;
                        else
                            RandOut(num,:)=0;
                        end
                    end
                end
            else
                for num=1:size(OutTest,1)
                    if OutTest(num,:)>RandT
                        RandOut(num,:)=1;
                    else
                        RandOut(num,:)=-1;
                    end
                end
            end 
            PerfInTime(nt,Cnd,a) = sum(RealTest == OutTest,'all')/numel(OutTest);
            Baseline(nt,a,Cnd) = sum(RandomTest == RandOut,'all')/numel(RandOut);
        end
    end
end

figure
for i=1:cond
    hold on
    plot(TestedTimes,mean(PerfInTime(:,i,:),3)','.-')
end
plot(TestedTimes,mean(mean(Baseline,3),2),'k.-')
ylim([0 1])
grid on
if Params.output==1
    legend({'A','B','C', 'D', 'E', 'F', 'G'})
else
    legend({'Motor Choice'})
end
ylabel('AUC of best channels')
xlabel('Time from PairOn')
% xlim([-0.6 0.6])

