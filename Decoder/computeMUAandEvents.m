function [Data, CorrectTrials, ErrorTrials, TotTrials]=computeMUAandEvents(Params);

%
%   [Data, CorrectTrials, ErrorTrials]=computeMUAandEvents(Params)
%
%   This function computes the MUA (using only the physiological channels) 
%   and the Trials with their events.
%
%   Params = decoder parameters
%
%   Data = struct with different fields
%   CorrectTrials = trials in which the animal has been rewarded
%   ErrorTrials = trials in which the animal chose the wrong symbol
%

EC = setEncodes();
if Params.session==1
    addpath(sprintf('//localpathtodata//%s//%s',Params.Animal(Params.animal), Params.Task(Params.task)));

else
    addpath(sprintf('//localpathtodata//%s21//%s',Params.Animal(Params.animal), Params.Task(Params.task)));
end

load(sprintf('EventsAndTrials%s.mat', Params.Task(Params.task)));
load(sprintf('MEAMUALFP%s.mat', Params.Task(Params.task)));

if Params.animal==1
    if Params.session==1
%         Ch = setdiff(1:96, [26 37 39 58 89 91 93]);   %physiological
%         channels for this session and animal
        Ch = setdiff(1:96, [26 37 39 40 58 89 91 93 66 76 11]); %physiological channels in common for all animals and sessions
    else
%         Ch = setdiff(1:96, [26 40 58 89 91 93]);  %physiological
%         channels for this session and animal
        Ch = setdiff(1:96, [26 37 39 40 58 89 91 93 66 76 11]); %physiological channels in common for all animals and sessions
    end
else
    if Params.session==1
%         Ch = setdiff(1:96, [26 66 11 89 91 93]);  %physiological
%         channels for this session and animal
        Ch = setdiff(1:96, [26 37 39 40 58 89 91 93 66 76 11]); %physiological channels in common for all animals and sessions
    else
%         Ch = setdiff(1:96, [23 76 89 91 93]); %physiological
%         channels for this session and animal
        Ch = setdiff(1:96, [26 37 39 40 58 89 91 93 66 76 11]); %physiological channels in common for all animals and sessions
    end
end

if Params.SD>1
    if Params.task==3
        AllConditions = 4001:4042;
    else
        AllConditions = 4001:4012;
    end
else
    AllConditions = Params.AllConditions;
end


cndTrials = selectTrialWithConditions(Trials, Events, AllConditions);   %trials with the specified conditions (SDs)
CorrectTrials = selectTrialWithEvent(cndTrials, Events, EC.CORRECT_RESPONSE);  
ErrorTrials = selectTrialWithEvent(cndTrials, Events, EC.RESPONSE_WRONG);
TotTrials = selectTrialWithEvents(cndTrials, Events, EC.RESPONSE_WRONG, EC.CORRECT_RESPONSE);


Data.Trials = Trials;
Data.MUA = MEAMUA.values(Ch,:);

% generic path for the data to load useful quantities from the data
load('localpathtodata/C/Test/MEAMUALFPTest.mat')

Data.MUATime = MEAMUA.time;
Data.MUAdt = MEAMUA.dt;
Data.Events = Events;
Data.Trials = Trials;
Data.NoC = 1:size(Data.MUA,1);    %it is possible to insert here an interval of channels to make a cycle evaluating performances of sets with different size (BestPerfAndCh with 1 input parameter)
Data.Ch = Ch;

if Params.SlidingWindow ==0
    Data.NoT = 1:numel(CorrectTrials.condition);    
else
    Data.NoT = Params.NoT;
end
    
load(sprintf('Channels%s',Params.Output(Params.output)));   %loading previously saved BestCh (Summary, chooseDecoder==1)
load(sprintf('MeanWeights%s',Params.Output(Params.output)));    %loading previously saved decoding vectors (Summary, chooseDecoder==1)
Data.SelCh = SelCh;
Data.MeanWeights = MeanWeights;