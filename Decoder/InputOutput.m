function [P_tot, T, tEC] = InputOutput(Params,Trials,target)

%
%   [P_tot, T, tEC] = InputOutput(Params,Trials,target)
%
%   This function computes the matrix of the MUA each 0.05 s during a 
%   specific trial interval, the target matrix for the different decodings 
%   and the central times for a specific event aroud which centering the
%   MUA matrix (mainly the PairOn, computing the matrix of the minimum delay 
%   based on Params.TestedTimes)
%
%   Params  = decoding parameters
%   Trials = the trials I want to decode (correct, error or all)
%   target = three possible outputs, depending on target value:
%       i) target = 0: the final matrices are those which are used to train
%           the decoder, containing sequentially the time steps of the
%           delay;
%       ii) target = 1: the final matrices have 3 dimensions, one
%           containing the time steps Params.TestedT (FromPairOn);
%       iii) target = 2: the final matrices have 3 dimensions, one
%           containing the time steps Params.TestedTimes (minimum delay);
%
%   P_tot = MUA matrix with different shapes, generally starting from
%       PairOn and finishing at the minimum delay
%   T = target matrix, changing depending on the chosen decoding (Orig, Pure, Left, Right)
%   tEC= trigger for the time step at PairOn
%

EC = setEncodes();
Data=computeMUAandEvents(Params);


Options.Time.CentralEvent = EC.PAIR_ON;
tEC = getTriggerFromEventCode(Trials, Data.Events, Options.Time.CentralEvent);
if Params.SlidingWindow ==0
    cnd =  Trials.condition - 4000;
else
    tEC = tEC(Data.NoT);
    cnd = Trials.condition(Data.NoT) - 4000;
end


if target==0
    TestedTimes = Params.TestedTimes;
else
    TestedTimes =1;
end

if Params.output==1
    if Params.task==3
        T = zeros(7,numel(TestedTimes),numel(tEC));
        for nt = 1:numel(tEC)
            for t=1:numel(TestedTimes)
                if cnd(nt)==1
                    T(1,t,nt) = 1;
                    T(2,t,nt) = -1;
                elseif cnd(nt) ==2
                    T(1,t,nt) = -1;
                    T(2,t,nt) = 1;
                elseif cnd(nt)==3
                    T(2,t,nt) = 1;
                    T(3,t,nt) = -1;
                elseif cnd(nt) ==4
                    T(2,t,nt) = -1;
                    T(3,t,nt) = 1;
                elseif cnd(nt) == 5
                    T(3,t,nt) =1;
                    T(4,t,nt) =-1;
                elseif cnd(nt) ==6
                    T(3,t,nt) =-1;
                    T(4,t,nt) =1;
                elseif cnd(nt) == 7
                    T(4,t,nt) = 1;
                    T(5,t,nt) = -1;
                elseif cnd(nt) == 8
                    T(4,t,nt) = -1;
                    T(5,t,nt) = 1;
                elseif cnd(nt) == 9
                    T(5,t,nt) = 1;
                    T(6,t,nt) = -1;
                elseif cnd(nt) == 10
                    T(5,t,nt) = -1;
                    T(6,t,nt) = 1;
                elseif cnd(nt) == 11
                    T(6:7,t,nt) = 1;
                    T(7,t,nt) = -1;
                elseif cnd(nt) == 12
                    T(6:7,t,nt) = -1;
                    T(7,t,nt) = 1;
                elseif cnd(nt) == 13
                    T(1,t,nt) = 1;
                    T(3,t,nt) = -1;
                elseif cnd(nt) == 14
                    T(1,t,nt) = -1;
                    T(3,t,nt) = 1;
                elseif cnd(nt) == 15
                    T(2,t,nt) = 1;
                    T(4,t,nt) = -1;
                elseif  cnd(nt) ==16
                    T(2,t,nt) = -1;
                    T(4,t,nt) = 1;
                elseif cnd(nt) == 17
                    T(3,t,nt) = 1;
                    T(5,t,nt) = -1;
                elseif cnd(nt) ==18
                    T(3,t,nt) = -1;
                    T(5,t,nt) = 1;
                elseif cnd(nt) == 19
                    T(4,t,nt) = 1;
                    T(6,t,nt) = -1;
                elseif cnd(nt) == 20
                    T(4,t,nt) = -1;
                    T(6,t,nt) = 1;
                elseif cnd(nt) == 21
                    T(5,t,nt) = 1;
                    T(7,t,nt) = -1;
                elseif  cnd(nt) ==22
                    T(5,t,nt) = -1;
                    T(7,t,nt) = 1;
                elseif cnd(nt) == 23
                    T(1,t,nt) = 1;
                    T(4,t,nt) = -1;
                elseif  cnd(nt) ==24
                    T(1,t,nt) = -1;
                    T(4,t,nt) = 1;
                elseif cnd(nt) == 25
                    T(2,t,nt) = 1;
                    T(5,t,nt) = -1;
                elseif  cnd(nt) ==26
                    T(2,t,nt) = -1;
                    T(5,t,nt) = 1;
                elseif  cnd(nt) ==27
                    T(3,t,nt) = 1;
                    T(6,t,nt) = -1;
                elseif cnd(nt) == 28
                    T(3,t,nt) = -1;
                    T(6,t,nt) = 1;
                elseif cnd(nt) == 29
                    T(4,t,nt) = 1;
                    T(7,t,nt) = -1;
                elseif cnd(nt) ==30
                    T(4,t,nt) = -1;
                    T(7,t,nt) = 1;
                elseif cnd(nt) == 31
                    T(1,t,nt) = 1;
                    T(5,t,nt) = -1;
                elseif cnd(nt) ==32
                    T(1,t,nt) = -1;
                    T(5,t,nt) = 1;
                elseif cnd(nt) == 33
                    T(2,t,nt) = 1;
                    T(6,t,nt) = -1;
                elseif cnd(nt) ==34
                    T(2,t,nt) = -1;
                    T(6,t,nt) = 1;
                elseif cnd(nt) == 35
                    T(3,t,nt) = 1;
                    T(7,t,nt) = -1;
                elseif cnd(nt) ==36
                    T(3,t,nt) = -1;
                    T(7,t,nt) = 1;
                elseif cnd(nt) == 37
                    T(1,t,nt) = 1;
                    T(6,t,nt) = -1;
                elseif cnd(nt) == 38
                    T(1,t,nt) = -1;
                    T(6,t,nt) = 1;
                elseif cnd(nt) == 39
                    T(2,t,nt) = 1;
                    T(7,t,nt) = -1;
                elseif  cnd(nt) ==40
                    T(2,t,nt) = -1;
                    T(7,t,nt) = 1;
                elseif cnd(nt) == 41
                    T(1,t,nt) = 1;
                    T(7,t,nt) = -1;
                elseif cnd(nt)==42
                    T(1,t,nt) = -1;
                    T(7,t,nt) = 1;
                end
            end
        end
        if Params.target == 1;
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
        elseif Params.target==2
            T = abs(T);
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
        elseif Params.target==3
            for j=1:size(T,1)
                for k=1:size(T,2)
                    for l=1:size(T,3)
                        if T(j,k,l)==-1;
                            T(j,k,l)=0;
                        end
                    end
                end
            end
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
        elseif Params.target==4
            for j=1:size(T,1)
                for k=1:size(T,2)
                    for l=1:size(T,3)
                        if T(j,k,l)==1;
                            T(j,k,l)=0;
                        end
                    end
                end
            end
            T=abs(T);
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
        end
            
    else
        T = zeros(7,numel(TestedTimes),numel(tEC));
        
        for nt = 1:numel(tEC)
            for t=1:numel(TestedTimes)
                if rem(cnd(nt),2)==0
                    f = cnd(nt)/2;
                    T(f,t,nt) = -1;
                    T(f+1,t,nt) = 1;
                else
                    b = (cnd(nt)+1)/2;
                    T(b,t,nt) = 1;
                    T(b+1,t,nt) = -1;
                end
            end
        end
         if Params.target == 1;
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
        elseif Params.target==2
            T = abs(T);
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
        elseif Params.target==3
            for j=1:size(T,1)
                for k=1:size(T,2)
                    for l=1:size(T,3)
                        if T(j,k,l)==-1;
                            T(j,k,l)=0;
                        end
                    end
                end
            end
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
        elseif Params.target==4
            for j=1:size(T,1)
                for k=1:size(T,2)
                    for l=1:size(T,3)
                        if T(j,k,l)==1;
                            T(j,k,l)=0;
                        end
                    end
                end
            end
            T=abs(T);
            T = reshape(T,[size(T,1) size(T,2)*size(T,3)]);
         end
    end
else
    T = zeros(numel(TestedTimes),numel(tEC));
    for nt = 1:numel(tEC)
        for t=1:numel(TestedTimes)
            if rem(cnd(nt),2)==0
                T(t,nt) = -1;
            else
                T(t,nt) = 1;
            end
        end
    end
    T = reshape(T,[1 size(T,1)*size(T,2)]);
end

P_tot= [];


if target==0
    TestedTimes = Params.TestedTimes;
    for nt = 1:numel(tEC)
        for i=1:numel(TestedTimes)
            ndxOffset = round((tEC(nt)+TestedTimes(i)-Data.MUATime(1))/Data.MUAdt+1);
            P_tot(:,i,nt) = Data.MUA(:,ndxOffset);
        end
    end
    P_tot = reshape(P_tot,[size(P_tot,1) size(P_tot,2)*size(P_tot,3)]);
elseif target==1
    TestedTimes=Params.TestedT;
    for nt = 1:numel(tEC)
        for i=1:numel(TestedTimes)
            ndxOffset = round((tEC(nt)+TestedTimes(i)-Data.MUATime(1))/Data.MUAdt+1);
            P_tot(:,nt,i) = Data.MUA(:,ndxOffset);
        end
    end
else
    TestedTimes=Params.TestedTimes;
    for nt = 1:numel(tEC)
        for i=1:numel(TestedTimes)
            ndxOffset = round((tEC(nt)+TestedTimes(i)-Data.MUATime(1))/Data.MUAdt+1);
            P_tot(:,nt,i) = Data.MUA(:,ndxOffset);
        end
    end
end





