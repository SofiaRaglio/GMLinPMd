function fltTrials = selectTrialWith2Events(Trials, Events, SelectingEvent1, SelectingEvent2)
%
%  fltTrials = selectTrialWithEvent(Trials, Events, SelectingEvent)
%

ndxT = [];
for n = 1:length(Trials.ndx)
    if length(Trials.ndx{n}) > 0
        if length(find(Events.code(Trials.ndx{n}) == SelectingEvent1)) > 0 && length(find(Events.code(Trials.ndx{n}) == SelectingEvent2)) > 0
            ndxT = [ndxT n];
        end
    end
end

fltTrials.start = Trials.start(ndxT);
fltTrials.stop = Trials.stop(ndxT);
for k = 1:length(ndxT)
   fltTrials.ndx{k} = Trials.ndx{ndxT(k)};
end
fltTrials.number = Trials.number(ndxT);
fltTrials.condition = Trials.condition(ndxT);
fltTrials.response = Trials.response(ndxT);