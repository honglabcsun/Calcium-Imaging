### README - Calcium Imaging Raw Data Files
This README file will detail everything you need to know to understand & use the raw Calcium Imaging data files in this repository (github.com/honglabcsun/Calcium-Imaging). 

*Note: I know the way the data is stored might be a bit messy or confusing, and probably doesn't quite adhere perfectly to proper data science / data storage practices. All I have to say about it is (1) my bad, (2) I didn't know what I know now, and (3) I'll do my best here to assist you in navigating through the system I created at the time. Thanks for understanding.*

### 1. Download Data
All the data files are stored in a zip file called "Ca2imgData-All-AsOf2024.zip". You can find this [here](https://github.com/honglabcsun/Calcium-Imaging/tree/main/Salts/data). Go ahead and download it & extract all.

### 2. Navigating Directories & Filename Meanings
#### 2.1 - Strains
Upon opening the now-extracted directory with all the data, you will be met with a directory called "RCaMP_CombinedData2024."
Inside this directory are several other directories. I will explain what their names mean:
The first 3 directories refer to the **strain name** of the *Pristionchus pacificus* nematode strains I imaged for the purposes of [this publication](https://doi.org/10.7554/eLife.103796.1).
* csuEx93 = *Ppa-che-1p::optRCaMP*
* csuEx98 = *
* rlh300 = *

The last directory, "xReAnalyzed_OldData" leads to several other directories containing "old" data from prior experiments conducted for my [Master's thesis](http://hdl.handle.net/20.500.12680/b5645184z). Within this directory are two more directories called "che-1_RCaMP" and "odr-7_GCaMP", which refer to the 2 **calcium sensors** I used (RCaMP & GCaMP) and the gene promoters they're hooked up to (*che-1* & *odr-7*).

#### 2.1 - Strains + 
Upon opening these directories, you will notice several folders containing names separated by underscores. The naming system is as follows:
**strain name** _ **salt** _ **concentration** _ **exposure time**
(e.g., csuEx93_NaCl_25mM)
(e.g., csuEx98_NaCl_25mM_100ms)

*Note: 
Salts you might see are: NaCl, NH4Cl, NH4I, NH4Br
Concentrations you might see are: 25mM, 250mM, 2.5M, 750mM
Exposure times you might see are: 100ms, 500ms*


However, in the directories that follow "xReAnalyzed_OldData", there are some inconsistencies. I will define some here:




