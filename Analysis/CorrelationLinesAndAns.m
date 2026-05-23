%% Correlation between Mental Lines and Decision decoders
% This script reproduces Figure 5C,D.
%%
load('path\to\RealignC24.mat')
% temp = corrcoef(AnsCC24 ,AnsTC24 );
% AnsCAnsTC24 = temp(1,2);
temp = corrcoef(AnsCC24 ,AnsC24T1H{1} );
AnsCAnsT1HC24 = temp(1,2);
temp = corrcoef(AnsC24T1H{1} ,AnsC24T2H{1} );
AnsT1HAnsT2HC24 = temp(1,2);
%%
temp = corrcoef(MLC24C ,AnsCC24 );
AnsMLCC24 = temp(1,2);
temp = corrcoef(AnsTC24 ,MLC24T1H );
AnsMLT1HC24 = temp(1,2);
temp = corrcoef(AnsTC24 ,MLC24T2H );
AnsMLT2HC24 = temp(1,2);
%%
temp = corrcoef(MLC24C ,MLC24T1H );
MLT1HMLCC24 = temp(1,2);
temp = corrcoef(MLC24T2H ,MLC24T1H );
MLT2HMLT1HC24 = temp(1,2);
%%
load('path\to\RealignC21.mat')
% temp = corrcoef(AnsCC21 ,AnsTC21 );
% AnsCAnsTC21 = temp(1,2);
temp = corrcoef(AnsCC21 ,AnsC21T1H{1} );
AnsCAnsT1HC21 = temp(1,2);
temp = corrcoef(AnsC21T1H{1} ,AnsC21T2H{1} );
AnsT1HAnsT2HC21 = temp(1,2);
%%
temp = corrcoef(MLC21C ,AnsCC21 );
AnsMLCC21 = temp(1,2);
temp = corrcoef(AnsTC21 ,MLC21T1H );
AnsMLT1HC21 = temp(1,2);
temp = corrcoef(AnsTC21 ,MLC21T2H );
AnsMLT2HC21 = temp(1,2);
%%
temp = corrcoef(MLC21C ,MLC21T1H );
MLT1HMLCC21 = temp(1,2);
temp = corrcoef(MLC21T2H ,MLC21T1H );
MLT2HMLT1HC21 = temp(1,2);
%%
load('path\to\RealignP21.mat')
% temp = corrcoef(AnsCP21 ,AnsTP21 );
% AnsCAnsTP21 = temp(1,2);
temp = corrcoef(AnsCP21 ,AnsP21T1H{1} );
AnsCAnsT1HP21 = temp(1,2);
temp = corrcoef(AnsP21T1H{1} ,AnsP21T2H{1} );
AnsT1HAnsT2HP21 = temp(1,2);
%%
temp = corrcoef(MLP21C ,AnsCP21 );
AnsMLCP21 = temp(1,2);
temp = corrcoef(AnsTP21 ,MLP21T1H );
AnsMLT1HP21 = temp(1,2);
temp = corrcoef(AnsTP21,MLP21T2H );
AnsMLT2HP21 = temp(1,2);
%%
temp = corrcoef(MLP21C ,MLP21T1H );
MLT1HMLCP21 = temp(1,2);
temp = corrcoef(MLP21T2H ,MLP21T1H );
MLT2HMLT1HP21 = temp(1,2);
%%
load('path\to\RealignP24.mat')
% temp = corrcoef(AnsCP24 ,AnsTP24 );
% AnsCAnsTP24 = temp(1,2);
temp = corrcoef(AnsCP24 ,AnsP24T1H{1} );
AnsCAnsT1HP24 = temp(1,2);
temp = corrcoef(AnsP24T1H{1} ,AnsP24T2H{1} );
AnsT1HAnsT2HP24 = temp(1,2);
%%
temp = corrcoef(MLP24C ,AnsCP24 );
AnsMLCP24 = temp(1,2);
temp = corrcoef(AnsTP24 ,MLP24T1H );
AnsMLT1HP24 = temp(1,2);
temp = corrcoef(AnsTP24 ,MLP24T2H );
AnsMLT2HP24 = temp(1,2);
%%
temp = corrcoef(MLP24C ,MLP24T1H );
MLT1HMLCP24 = temp(1,2);
temp = corrcoef(MLP24T2H ,MLP24T1H );
MLT2HMLT1HP24 = temp(1,2);
%%
AnsMLC = mean([AnsMLCC24 AnsMLCP24 AnsMLCP21 AnsMLCC21]);
errAnsMLC = std([AnsMLCC24 AnsMLCP24 AnsMLCP21 AnsMLCC21]);

AnsMLT2H = mean([AnsMLT2HC24 AnsMLT2HP24 AnsMLT2HP21 AnsMLT2HC21]);
errAnsMLT2H = std([AnsMLT2HC24 AnsMLT2HP24 AnsMLT2HP21 AnsMLT2HC21]);

AnsMLT1H = mean([AnsMLT1HC24 AnsMLT1HP24 AnsMLT1HP21 AnsMLT1HC21]);
errAnsMLT1H = std([AnsMLT1HC24 AnsMLT1HP24 AnsMLT1HP21 AnsMLT1HC21]);

figure
errorbar([AnsMLC AnsMLT1H AnsMLT2H],[errAnsMLC errAnsMLT1H errAnsMLT2H]/2)


AnsCAnsT1H = mean([AnsCAnsT1HP24 AnsCAnsT1HC24 AnsCAnsT1HP21 AnsCAnsT1HC21]);
errAnsCAnsT1H = std([AnsCAnsT1HP24 AnsCAnsT1HC24 AnsCAnsT1HP21 AnsCAnsT1HC21]);

AnsT1HAnsT2H = mean([AnsT1HAnsT2HP24 AnsT1HAnsT2HP21 AnsT1HAnsT2HC24 AnsT1HAnsT2HC21]);
errAnsT1HAnsT2H = std([AnsT1HAnsT2HP24 AnsT1HAnsT2HP21 AnsT1HAnsT2HC24 AnsT1HAnsT2HC21]);
%%
MLT1HMLC = mean([MLT1HMLCP24 MLT1HMLCP21 MLT1HMLCC24 MLT1HMLCC21]);
errMLT1HMLC = std([MLT1HMLCP24 MLT1HMLCP21 MLT1HMLCC24 MLT1HMLCC21]);

MLT2HMLT1H = mean([MLT2HMLT1HP24 MLT2HMLT1HP21 MLT2HMLT1HC24 MLT2HMLT1HC21]);
errMLT2HMLT1H = std([MLT2HMLT1HP24 MLT2HMLT1HP21 MLT2HMLT1HC24 MLT2HMLT1HC21]);
%%
figure
errorbar([AnsCAnsT1H AnsT1HAnsT2H],[errAnsCAnsT1H errAnsT1HAnsT2H]/2)
hold on
errorbar([MLT1HMLC MLT2HMLT1H],[errMLT1HMLC errMLT2HMLT1H]/2)
xlim([0.5 2.5])
