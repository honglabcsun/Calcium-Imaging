# Instructions on how to use these scripts
This document will detail what each script does and how/what order to use them with the calcium imaging data output (logfiles from MetaMorph).
As mentioned in the README of this repo, I do not currently have a "main" script where I run all these scripts in order. Some of these scripts also require manual movement of files into other folders before you can run the script. Therefore, you will have to run scripts one by one. Since it's kind of a hassle, I've detailed instructions here to make this as easy as possible for you, the user.

***

### Description of Scripts
Below is a description of each script in this repository and what it does. This information is also included in the each of the scripts themselves.

* calculate_dff_aggregate - Generates a single plot of mean % dF/F (average percent change in fluorescence intensity) over time. This plot contains traces from individual worm samples, as well as one thick black line showing the average across all worms tested.

* ConfidenceIntervalRibbon - Generates a plot of mean % dF/F (average percent change in fluorescence intensity) over time. This plot contains only the average trace, which includes shaded ribbons as 95% CI. There is also "ConfidenceIntervalRibbon180" exclusively for data collected using the 180s JNL program (10off_120on_50off).

* dff_heatmap - Generates a normalizedheatmap of % dF/F (average percent change in fluorescence intensity) over time, where each row indicates responses from a single individual. There is also "df_heatmap180" exclusively for data collected using the 180s JNL program (10off_120on_50off)

* PrepBarData scripts - Organizes data to be used in BarData scripts. *Note: You must manually move log files that you wish to compare into the same directory.* There is also "PrepBarData_10sAfter" to be used for comparisons of responses 10s post-stimulus of the ON stimulus vs 10s post-stimulus of the OFF stimulus. There is also "PrepBarData_PrePost" to be used for comparisons of responses 10s PRE-stimulus vs 10s POST-stimulus. *Note: you must pick one stimulus for this, the ON or OFF stimulus.*

* BarData scripts - Preps data to be copied into Excel and/or GraphPad Prism. **UPDATE REQUIRED HERE**

***
### Order to Run Scripts in
