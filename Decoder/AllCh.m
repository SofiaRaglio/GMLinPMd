function SelCh = AllCh(Params)

%
%   SelCh = AllCh(Params)
%
%   This function creates a vectors of selected channels using all the MUA
%   physiological channels.
%
%   Params = decoding parameters
%   
%   SelCh = vector composed by all the physiological channels
%

Data = computeMUAandEvents(Params);
if Params.output==1
    cond = 7;
else
    cond = 1;
end

SelCh ={};
for i=1:cond
    SelCh{i} = Data.NoC;
end