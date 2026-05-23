function Orthogonality = OrthogonalityRepresentations(Params, vec1, vec2);

%
%   Orthogonality = OrthogonalityRepresentations(Params, vec1, vec2)
%
%   This function computes the orthogonality between the representations of
%   the different symbols.
%
%   Params = decoding parameters
%   vec1, vec2 = vectors considered to compute orthogonality
%   
%   Orthogonality = correlation matrix between symbols vectors (motor choice vector)
%

if Params.output==1
    cond=7;
else
    cond=1;
end

if Params.output==1
    for a=1:cond
        for b=1:cond
%             Orthogonality(a,b) = abs(dot(vec1{a}, vec2{b})/((norm(vec1{a})*norm(vec2{b}))));
             Orthogonality(a,b) = dot(vec1{a}, vec2{b})/((norm(vec1{a})*norm(vec2{b})));
        end
    end
    
    figure
    imagesc(Orthogonality)
    colorbar
    yticks([1:cond])
    yticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
    xticks([1:cond])
    xticklabels({'A','B','C', 'D', 'E', 'F', 'G'})
    colormap(brewermap(20,'RdBu'))
else
    Orthogonality = 1;
end

