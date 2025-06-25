# Instructions on how to use these scripts
This document will detail what each script does and how/what order to use them with the calcium imaging data output (logfiles from MetaMorph).
As mentioned in the README of this repo, I do not currently have a "main" script where I run all these scripts in order. Some of these scripts also require manual movement of files into other folders before you can run the script. Therefore, you will have to run scripts one by one. It's kind of a hassle because I ultimately didn't have the time to future-proof all this code before my thesis defense (with my very limited comp sci knowledge). Alternatively, I've decided to try to leave very detailed instructions here to make this as easy as possible for anyone who dares to try to use this code as is.

***

### Description of Scripts
Below is a description of each script in this repository and what it does. This information is also included in the each of the scripts themselves.

#### For calcium trace plots

* **calculate_dff_aggregate** - Generates a single plot of mean % dF/F (average percent change in fluorescence intensity) over time. This plot contains colored traces from individual worm samples, as well as one thick black line showing the average trace across all worms tested. The default is for data collected with the 60s JNL program (10off_20on_30off). There is also "calculate_dff_aggregate180" exclusively for data collected using the 180s JNL program (10off_120on_50off).

* **ConfidenceIntervalRibbon** - Generates a plot of mean % dF/F (average percent change in fluorescence intensity) over time. This plot contains _only_ the average trace as a thick line that includes shaded ribbons representing 95% confidence interval (CI). The default is for data collected with the 60s JNL program (10off_20on_30off). There is also "ConfidenceIntervalRibbon180" exclusively for data collected using the 180s JNL program (10off_120on_50off).

#### For heatmaps:

* **dff_heatmap** - Generates a normalized heatmap of % dF/F (average percent change in fluorescence intensity) over time, where each row indicates responses from a single individual. The values are normalized from 0 (most negative values, dark color) to 1 (most positive values, light color). The default is for data collected with the 60s JNL program (10off_20on_30off). There is also "df_heatmap180" exclusively for data collected using the 180s JNL program (10off_120on_50off).

#### For Bar Plots:

##### Prep scripts:
* **PrepBarData** scripts - Organizes data to be used in the "BarData" scripts. *Note: You must manually move the log files that you wish to compare into the same directory.* There are 2 versions of the PrepBarData scripts, I will break them down here:
  * **PrepBarData_10sAfter** calculates dff only for comparing the 10s after the ON stimulus vs the 10s after the OFF stimulus, and stores these as .txt files. This will be run prior to any Barplot scripts with "10s" in the name.
  * **PrepBarData_PrePost** calculates dff only for comparing the 10s BEFORE a stimulus vs the 10s AFTER the same stimulus, and stores these as .txt files. For example, comparing 10s PRE ON-stimulus vs 10s POST ON-stimulus. In other words, you must pick which stimulus you are analyzing "pre-" and "post-" states for, _either_ the ON stimulus or OFF stimulus. This will be run prior to any Barplot scripts with "PrePost" in the name.

##### Bar scripts:
* **BarData** scripts - For use AFTER the PrepBarData scripts. These scripts organize the data to be copied & pasted into Excel and/or GraphPad Prism. There are several of versions of these as well, each serving a different purpose. I will break them down here:
  
  10sAfter Group - Any one of these scripts can be run after "PrepBarData_10sAfter"
  * **BarData_10sAfter_Avg** - Takes the txt files you generated from the PrepData script and calculates averages. These averages will be exported as .txt files for plotting.
  * **BarData_10sAfter_Max** - Takes the txt files you generated from the PrepData script and calculates max values. These max values will be exported as .txt files for plotting.
  * **Bar_10s_AM7vAM12** - Takes txt files you generated and prepares it for plotting a bar plot SPECIFICALLY comparing AM7 vs AM12 responses for the same salt condition.
  * **Bar_10s_AM7vAM12_Max** - Takes txt files you generated and prepares it for plotting a bar plot SPECIFICALLY comparing the MAX values of AM7 vs AM12 responses for the same salt condition.

  PrePost Group - Any one of these scripts can be run after "PrepBarData_PrePost"
  * **BarData_PrePost_Avg** - Takes the txt files you generated from the PrepData script and calculates averages. These averages will be exported as .txt files for plotting.
  * **BarData_PrePost_MinMax** - Takes the txt files you generated from the PrepData script and calculates the minimum value across the 10s window Before (pre) stimulus and the maximum value across the 10s window After (post) stimulus for the stimulus of choice. These min and max values will be exported as .txt files for plotting.
  * **BarData_PrePost_Ratios** - Takes the txt files you generated from the PrepData script and calculates a "Post/Pre ratio" at each time point across the 10s window Before (pre) and After (post) the stimulus of choice. After calculating the ratios, they will be averaged and exported as .txt files for plotting.
  * **Bar_PrePost_AM7vAM12** - Takes txt files you generated and prepares it for plotting a bar plot SPECIFICALLY comparing AM7 vs AM12 responses for the same salt condition.

Others:    
* **dff_prep4dots** - Organizes data to be used in "dff_dots" script. Calculates dff & keeps only data for 10s after the ON stimulus and 10s after the OFF stimulus.
* **dff_dots** - To be used after "dff_prep4dots" script.Generates a combined bar/scatter plot. The points will represent the average percent change in dff of each individual animal.
  
***
### Order to Run Scripts in:
Each of these scripts (mostly) will re-calculate dff every time you run it. So depending in your needs, you may only need to run one or two scripts.

A. If you want to see the individual calcium traces and the average trace on the same plot, just use the **Calculate dff** script (based on either the 60s or 180s JNL).
B. If you want to see just the average calcium traces with shaded confidence intervals, just use the **Confidence intervals** script (based on either the 60s or 180s JNL).
C. If you want to see the heatmaps, just use the **heatmaps** script (based on either the 60s or 180s JNL).

For bar plots, you only need to run the appropriate "Prep" script before any one of the "Bar" / "BarData" scripts. Usually you'll run one "prep" script and then run one "bardata" script after it. Be sure to be in the correct directory / path in Matlab when you run these scripts.
A. Run "PrepBarData_10sAfter" before any of the scripts in the "10sAfter" Group listed above.
B. Run "PrepBarData_PrePost" before any of the scripts in the "PrePost" Group listed above.

***

### Additional Notes:

* When you run some of the scripts, they might have flags that prompt you, the user, to answer "true" or "false" depending on the output you want for each plot. There's more detail about this within the comments of each script.

* You likely don't need to use the "dff_prep4dots" or "dff_dots" scripts. They exist in this repo for storage only but I don't think they made it to the "final cut" of scripts we ultimately used for procesing data for the publication. You can essentially disregard them.

