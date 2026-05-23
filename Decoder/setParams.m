function Params = setParams()

%
%   Set the parameters to choose different decoding options.
%

Params.Output = ["Sym", "Direction"];   %decoding the seven symbols or the motor choice
Params.output = 1;
Params.Task = ["Learning", "Consolidation", "Test"];    %which of the three phases of the task to be decoded
Params.task = 3;
Params.Animal = ["C", "P"];  %which of the two animals
Params.animal =1;
Params.Session = ["24","21"];   %which of the two sessions (different days)
Params.session=1;
Params.Target = ["Orig", "Pure", "Dx", "Sx"];   %which of the four possible decoding vectors
Params.target = 1;
Params.pThreshold = 0.01;   %theshold for pvalue tests
Params.TestedTimes = 0:0.05:0.6;    %times used for the training and test (minimum delay)
Params.TestedT = -0.6:0.05:0.6;%0.6;     %times used to plot the performances in time
Params.SD = 2;      %discriminant between using all possible SDs in the specific phase (SD>1) or just one particular SD specified in Params.AllConditions (SD=1)
Params.AllConditions = 4001:4042;   %considered trials (4012 max condition for Learning and Consolidation, 4042 for Test)
Params.SlidingWindow = 0; %decide if the decoding will be on the whole session (=0) or on single window of a number of trials determined by Params.NoT (=1)
Params.NoT = 1:5;

