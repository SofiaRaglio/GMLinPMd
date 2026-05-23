function [AnsLine, TheoLine, PinvLine, Correlation, Line, Pinv, Map] = MentalLine(Params,vecdif, Ans)

%
%   [AnsLine, TheoLine, PinvLine, Correlation, Line, Pinv, Map] = MentalLine(Params,vecdif, Ans)
%
%   This function computes the possible mental lines from the symbols vectors.
%
%   Params = decoding parameters
%   vecdif = vectors used to compute the mental line
%   Ans = motor choice vector
%
%   AnsLine = projections of the symbols vectors on the motor choice axis
%   TheoLine = projections of the symbols vectors on the theoretical mental
%       line (each symbol weighted by its rank)
%   PinvLine = projections of the symbols vectors on the mental line
%       computed with the pseuroinverse algorithm
%   Correlation = correlation between the pseudoinverse mental line and the
%       motor choice axis
%   Line = the theoretical mental line
%   Pinv  = the pseudoinverse mental line
%   Map = the matrix of all possible symbolic distances computed with the
%       projections of the symbols representations on the Pinv.
%

if Params.output==1
    cond=7;
else
    cond=1;
end

Ans = Ans{1};

for i=1:cond
AnsLine(i)=dot(vecdif{i},Ans);
end

Line = zeros(size(vecdif{1}));
for i=1:cond
    Line= Line +(cond-i)*vecdif{i};
end

for i=1:cond
TheoLine(i)=dot(vecdif{i},Line);
end

Input = [];
for i=1:(cond-1)
    Input(:,i) = vecdif{i} - vecdif{i+1};
end

In = [Input -Input];
Output = ones(1,cond-1);
Out = [Output -Output];

Pinv = pinv(In')*Out';

PinvLine = [];
for i=1:cond
    PinvLine(i)=dot(vecdif{i},Pinv);
end

Correlation = abs(dot(Ans,Pinv)/(norm(Ans)*norm(Pinv)));

Map = [];
for i=1:cond
    for j=1:cond
        Map(i,j) = dot((vecdif{i}-vecdif{j}),Pinv);
    end
end

figure
plot(PinvLine,'.-','MarkerSize',15)
grid on
xticks([1:7])
xticklabels({'A','B','C','D','E','F','G'})
xlabel('Symbols')
ylabel('Projections')

figure
imagesc(Map)
xticks([1:7])
xticklabels({'A','B','C','D','E','F','G'})
yticks([1:7])
yticklabels({'A','B','C','D','E','F','G'})
colorbar

