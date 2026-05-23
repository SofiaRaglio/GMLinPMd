# Learning to infer transitively on a mental line in premotor cortex

Code to reproduce the analysis of the paper:
Raglio S., Di Antonio G., Brunamonti E., Ferraina S., Mattia M., Learning to infer transitively on a mental line in premotor cortex

## Code description

The analysis pipeline:

1. Builds trial-aligned MUA from raw session files.
2. Trains linear classifiers (symbol identity, left/right motor choice, and derived axes).
3. Constructs **difference** and **sum** symbol vectors, then the theoretical and pseudoinverse **mental lines**.
4. Relates symbolic distance (SD) on the GML to behavior, decoding accuracy, and learning-related rotation toward the motor-plan manifold.

Two animals (**C**, **P**) and two sessions per animal (**24**, **21**; referred as **1** and **2** in the manuscript) are supported throughout.

## Requirements

- [MATLAB](https://www.mathworks.com/products/matlab.html) (R2018b or later recommended; scripts use standard toolboxes and no third-party dependencies beyond this repo).
- Raw or preprocessed session data; most figure scripts expect **precomputed** `.mat` summaries rather than re-running the full decoder from scratch.

## Repository structure

```
SciAdvCode/
├── Decoder/              # Core decoding and mental-line computation
│   ├── Summary.m         # Main entry point: channel selection → vectors → mental line
│   ├── setParams.m       # Session, task phase, targets, time windows
│   ├── computeMUAandEvents.m
│   ├── BestPerfAndCh.m   # Linear decoder (channel search, weights, AUC threshold)
│   ├── MentalLine.m, PredictLine.m, FromPairOn.m, ...
│   └── motor_action_decoder_functions/   # Motor-action–locked variants
├── Analysis/             # Figure and table reproduction scripts
├── Helpers/              # Trial selection, event codes, plotting utilities
└── Data/
    └── FitBehavioralModel/   # CSV outputs from the fitted behavioral (ESN) model
```

### Key decoder workflow

1. Edit `Decoder/setParams.m` for animal, session, task phase, output type (symbols vs. motor direction), and time bins.
2. Point `Decoder/computeMUAandEvents.m` to your data root (replace `//localpathtodata//` with the folder containing `EventsAndTrials*.mat` and `MEAMUALFP*.mat` per animal/session/phase).
3. Run `Decoder/Summary.m`, which:
   - Selects decoding channels (`chooseDecoder`: search, fixed set, or all channels),
   - Estimates **Pure** (position-invariant), **Left** (Sx), **Right** (Dx), and **Answer** (motor) axes,
   - Forms difference/sum vectors and calls `MentalLine` to obtain theoretical and pseudoinverse GMLs.

Motor-focused analyses use `Decoder/motor_action_decoder_functions/SummaryMot.m` and related functions.

### Parameters (`setParams.m`)

| Field | Meaning |
|--------|---------|
| `Params.animal` | 1 = C, 2 = P |
| `Params.session` | 1 = day 24, 2 = day 21 |
| `Params.task` | 1 = Learning, 2 = Consolidation, 3 = Test |
| `Params.output` | 1 = seven symbols, 2 = motor direction |
| `Params.target` | Decoding vector: Orig, Pure, Dx, Sx |
| `Params.TestedTimes` | Training/test delays (s) relative to pair onset |
| `Params.AllConditions` | Trial condition IDs (4001–4012 or 4001–4042 in Test) |

## Data

**Not included in this repository** (due to size and sharing restrictions):

- Raw/neural session folders: `EventsAndTrials{Learning,Consolidation,Test}.mat`, `MEAMUALFP{...}.mat`
- Precomputed decoder outputs used by analysis scripts, e.g. `AllC24.mat`, `AllP21.mat`, `Realign*.mat`, `NN_*.mat`, `SDAns.mat`, `SDMot.mat`

**Included:**

- `Data/FitBehavioralModel/*.csv` — behavioral model fits (max-out SDs, reaction times, percent correct, anchors) for the ESN parameters noted in the filenames.

Before running `Analysis/*.m`, replace placeholder paths such as `'path\to\AllC24.mat'` with the actual location of your files, and add the repo to the MATLAB path:


## Figure scripts

Each script header notes which paper panels it reproduces. Update `load(...)` paths as above.

| Script | Figures / tables |
|--------|------------------|
| `BehavioralPerfFigure.m` | 1E,F; S1D,F (behavior) |
| `FiguresForModelFit.m` | 1E,F; 3F; S1A,B,C,E (model) |
| `PlotChannelsActivityLR.m` | 2A |
| `RasterPlot.m` | 2B |
| `SDAnsFigure.m` | 2C |
| `DecActPerf.m` | 2D |
| `TrjMotDecAct.m` | 2E |
| `PredictConditionFigure.m` | 3A; S3A,B |
| `FromPairOnFigure.m` | 3B; S3C; S4A |
| `MentalLineFigure.m` | 3C,D,E; S4C |
| `PlotSDDistributionsOnGML.m` | 3C,D |
| `AnsLineFigure.m` | 3D; S4E |
| `PredictPerf.m` | 4A; Table S2 |
| `JRPrediction.m` | 4B |
| `RT_figure.m`, `plotIntegratorOnGML.m` | 4D |
| `BehaviorDifficulty.m`, `DecoderDifficultyLearning.m`, `DecoderDifficultySD.m` | 5A; S4B |
| `CorrelationLinesAndAns.m` | 5C,D |
| `CorralationFigure.m` | 6A,B,C,D; S4D |
| `SDEvaluationPerf.m` | S2A |
| `SDMotFigure.m` | S2B |
| `MEA_weights.m` | S2C |
| `SVDDimensionality.m` | S2D |
| `SVD_SD.m` | S2E |
| `DecodingSD.m` | Table S3 |


## Contact

For questions about the data or code, contact the corresponding author listed on the paper.
