function tEC = getTriggerFromEventCode(Trials, Events, EventCode)
%
%  tEC = getTriggerFromEventCode(Trials, Events, EventCode)
%

% Collect all the events in the selected trials.
tEC = NaN(1,numel(Trials.ndx));
for n = 1:numel(Trials.ndx)
   ndxTE = find(Events.code(Trials.ndx{n}) == EventCode);
   if numel(ndxTE) > 0
      % Time of the first occurence of the central event...
      tEC(n) = Events.time(Trials.ndx{n}(ndxTE(1)));
   else
      tEC(n) = -1.0;
      disp(['Event code ' num2str(EventCode) ' not present in Trial ' num2str(Trials.number(n))]);
   end
end
