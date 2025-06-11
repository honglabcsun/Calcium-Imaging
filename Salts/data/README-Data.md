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
The strains you will find associated with this folder are:
* csuEx72 = *
* csuEx89 = *

#### 2.2 - File Naming Convention
Upon opening these directories, you will notice several folders containing names separated by underscores. The naming system is (mostly) as follows:
**strain name** _ **salt** _ **concentration** _ **exposure time**
(e.g., csuEx93_NaCl_25mM)
(e.g., csuEx98_NaCl_25mM_100ms)

*Note: 
Salts you might see are: NaCl, NH4Cl, NH4I, NH4Br, NaAc
Concentrations you might see are: 25mM, 250mM, 2.5M, 750mM
Exposure times you might see are: 100ms, 500ms*


However, in the directories that follow "xReAnalyzed_OldData", there are some inconsistencies. I will define them below:

1. Instead of salts, sometimes you might see other stimuli & concentrations in the filename.
  * "greenlightbasal" and "bluelightbasal" refer to
  
  * "1oct_10percent"
  * "Bcary_5percent"
  * "Myristate_1percent"

2. Journal Names. "Journals" or "jnl" refer to the programmed timing condition for turning "ON" and "OFF" the stimulus during imaging.
  * "60jnl" - refers to a jnl that lasted a total of 60s (1 min). I used this program the most. If the "jnl" is not listed in the filename, I most likely used the 60s jnl (treat it as the default). This jnl consisted of 10s OFF, 20s ON, 30s OFF condition for switching the stimulus ON/OFF. Sometimes this will be referred to as "JNL_10off_20on_20off"
  * "180jnl" - refers to a jnl that lasted a total of 180s (3 min). This jnl consisted of 10s OFF, 120s ON, 50s OFF condition for switching the stimulus ON/OFF. Sometimes this will be referred to as "JNL_10off_120on_50off"

#### 2.3 - Neuron Imaged

Upon entering the directories with strain name + salt + concentration + exposure time (and all other variations), you may notice even more directories. These refer to which neuron pair was imaged. I will define them in detail below:

For all che-1 RCaMP strains:
* "ant" refers to the anterior neuron, in this case, the AM12
* "pos" refers to the posterior neuron, in this case, the AM7
* "AM12" refers to
* "AM7" refers to

For all odr-7 GCaMP strains:
* "ant" refers to the anterior neuron, in this case, 
* "pos" refers to the posterior neuron, in this case, 
* "both" refers to BOTH neurons being imaged within the same tracking. This means the single track captures BOTH the anterior and posterior neuron.

#### 2.4 - Neuron Imaged - L/R

Upon entering those directories, you may notice additional directories. These refer to whether the specific neuron imaged within the pair, i.e., whether it was the Left or Right neuron.
Whereever you see "L" refers to the Left Neuron
Wherever you see "R" refers to the Right Neuron
For example:

* "antL" refers to
* "posL" refers to

* "antR" refers to
* "posR" refers to

* "antLR" refers to
* "posLR" refers to

* "AM12L" refers to
* "AM12R" refers to
  




