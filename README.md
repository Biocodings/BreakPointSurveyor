
# BPS.TCGA_Virus.Lite - Synthetic branch

Sample BreakPoint Surveyor project: synthetic human-human breakpoint

Generate an interchromosomal translocation by concatenating two reference segments,
then generate synthetic (simulated) reads in this region.  Realign with BWA to a
reference, and then visualize using Breakpoint Surveyor


    * Segment 1: chr9:130,840,000-130,850,000
    * Segment 2: chr22:23,260,000-23,270,000

small BAM representing an interchromosomal translocation, 
analyze it using BreakpointSurveyor.  


See [BreakPointSurveyor-Core](https://github.com/ding-lab/BreakPointSurveyor-Core/README.md) 
for background.

## Timing

* Downloading and processing of two-chromosome reference (A_Reference) is about 5 minutes, uses about 684M
* Total execution time for steps B-T about 25 seconds

### Output

** TODO ** fix link below
* [BreakPoint Surveyor Structure Plot](T_PlotStructure/plots/TCGA-BA-4077-01B-01D-2268-08.AA.chr14.BreakpointSurvey.pdf)
T_PlotStructure/plots/synthetic.9-22.AA.chr22_chr9.BreakpointSurvey.png
T_PlotStructure/plots/synthetic.9-22.AA.chr22_chr9.BreakpointSurvey.pdf


## Authors
Matthew A. Wyczalkowski, m.wyczalkowski@wustl.edu

## License
This software is licensed under the GNU General Public License v3.0

## Acknowledgements
