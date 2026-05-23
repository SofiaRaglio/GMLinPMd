%% This is the main file. It calls the other functions to find the correct decoding vectors.
clear all;clc;
%%
%set the parameter to choose the decoder
Params = setParams;
%%
%three decoding options: i) I choose the number of channels used for decoding and then compute their weights; ii) I use previously chosen channels and then compute weights; iii) I use all the channels. 
chooseDecoder =2;
if chooseDecoder==0
    [BestPerf, BestCh] = BestPerfAndCh(Params);
    SelCh = SelectChannels(Params, BestPerf, BestCh);
elseif chooseDecoder==1
    Data = computeMUAandEvents(Params);
    SelCh = Data.SelCh;
else
    SelCh = AllCh(Params);
end
%%
%compute the Pure vector
Params = setParams;
Params.target =2;
[pp, ~, P, ~,~] = BestPerfAndCh(Params, SelCh);
%%
%compute the Left vector
Params = setParams;
Params.target = 4;
[ps, ~, S, ~,~] = BestPerfAndCh(Params, SelCh);
%%
%compute the Right vector
Params = setParams;
Params.target = 3;
[pd, ~, D, ~,~] = BestPerfAndCh(Params, SelCh);
%%
%create Left and Right vectors and then the vectors Sum and Difference
Sx = createVector(Params,SelCh, S);
Dx = createVector(Params,SelCh, D);
[vecDif, vecSum] = SumDif(Dx, Sx);
%%
%compute the Answer vector (Motor choice)
Params = setParams;
Params.output = 2;
[pa, ~, A, ~,t] = BestPerfAndCh(Params, SelCh);
Ans = createVector(Params,SelCh, A);
%%
%build the mental line, both the theoretical and the correct one
Params = setParams;
[AnsLine, TheoLine, PinvLine, Correlation, Line, Pinv, Map] = MentalLine(Params,vecDif, Ans);
