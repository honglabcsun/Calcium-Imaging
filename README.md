# Calcium-Imaging
## Hong Lab MATLAB scripts for analyzing Calcium Imaging data in _Pristionchus pacificus_.
by Marisa Mackie, for Ray Hong Lab at California State University, Northridge (CSUN)

Contributors: Kathleen Quach, Isaiah Martinez, Marisa Mackie

Written with MATLAB versions 2021a - 2024b


**Note:** Before using any script in this repository, please see the readme file in within the data folder of this repo to organize your data in the way that is required for proper functioning of these scripts. See [Readme-Data](https://github.com/honglabcsun/Calcium-Imaging/blob/main/Salts/data/README-Data.md)


Below is a description of each script in this repository and what it does. This information is also included in the each of the scripts themselves.

  ### calculate_dff_aggregate
  Generates a single plot of mean % dF/F (average percent change in fluorescence intensity) over time. This plot contains traces from individual worm samples, as well as one thick black line showing the average across all worms tested.

  ### ConfidenceIntervalRibbon
  Generates a plot of mean % dF/F (average percent change in fluorescence intensity) over time. This plot contains only the average trace, which includes shaded ribbons as 95% CI.
  There also exists "ConfidenceIntervalRibbon180" exclusively for data collected using the 180s JNL program (10off_120on_50off)

  ### dff_heatmap
  Generates a normalizedheatmap of % dF/F (average percent change in fluorescence intensity) over time, where each row indicates responses from a single individual.
  There also exists "df_heatmap180" exclusively for data collected using the 180s JNL program (10off_120on_50off)

  ### PrepBarData scripts
  Organizes data to be used in BarData scripts. Note: You must manually move log files that you wish to compare into the same directory.
  There exists "PrepBarData_10sAfter" to be used for comparisons of responses 10s post-stimulus of the ON stimulus vs 10s post-stimulus of the OFF stimulus.
  There exists "PrepBarData_PrePost" to be used for comparisons of responses 10s PRE-stimulus vs 10s POST-stimulus. (Pick one stimulus: ON or OFF stimulus).

  ### BarData scripts
  Preps data to be copied into Excel and/or GraphPad Prism.
  There exists "

