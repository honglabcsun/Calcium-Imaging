function PrepBarData_10sAfter
% ========================================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a dots/scatter plot.
% It will take each set of logfiles, calculate dff, and keep ONLY the dff
% data of all the logfiles in the 10s windows after the stimulus was
% delivered (dff_10ON) and after the stimulus was removed (dff_10OFF).
%
% The raw data & will then be saved as txt files
% to be exported for plotting in Prism GraphPad software.
% 
% Important: This script should be run prior to "PrepBarData_10s_Avg.m"
%
% created: 2024-02-28 by Marisa Mackie & Isaiah Martinez
% adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-03-28
% ========================================================================

%% CALCULATES AGGREGATE DFF

% Does the exact same thing as script "calculate_dff_aggregate".
% Below is Kathleen's code:
% 
% ==[ Manually input recording parameters ] ===============================
% Indicate the end of the baseline period in seconds
baseline_end_s = 10; 

% ==[ Set up batch processing ]============================================
% List all *.log files in the current directory
log_tmp = dir('*.log'); 
log_list = {log_tmp.name}'; % Make cell array of all *.log filenames  
num_logs = length(log_list);

% Initialize arrays to aggregate individual data
dff = double.empty(0,num_logs); % Individual dff
num_frames = NaN(1,num_logs); % Number of frames in each log file


% Iterate through all .log files
for i = 1:num_logs
    % ==[ Load data ]======================================================
    % Load comma-delimited data 
    logfile = log_list{i};
    data = load(logfile); 

    % Keep only the first three columns
    % col 1: frame
    % col 2: time in ms
    % col 3: background-subtracted fluorescence
    data_sub = data(:,3); 
    num_frames(i) = length(data_sub); % Number of frames in log file

    % ==[ Calculated individual df/f ]=====================================
    % Define x-values as seconds 
    x = data(:,2)/1000; % ms/1000
    % Define baseline as ending 1 second before stimulus starts, to avoid 
    % artifacts associated with transitions
    baseline_ind = find(x <= baseline_end_s-1);
    f0 = mean(data_sub(baseline_ind));
    dff{i} = ((data_sub-f0)/f0) * 100;
end

%% FILTER DFF VALUES FOR 10s WINDOWS AFTER ON & OFF

% Initializes array for expanding "dff"
dff_copy = zeros(num_logs,119); % for 60s jnl
%dff_copy = zeros(num_logs,1799); % for 180s jnl

% This for loop iterates through each log file & stores the dff data in
% new array "dff_copy"
% i is the current log file's dff data
for i = 1:num_logs
    % j is the dff data at the current frame
    % (1:119 for 60s jnl ; manually change to 1:1799 for 180s jnl)
    for j = 1:119
        % dff_copy holds dff values for all log files in one array
        dff_copy(i,j) = dff{1,i}(j);
    end
end

% df/f values for 10s after ON (10-20s; frames 22-41 ; col 21-40)
dff_ON10 = dff_copy(:,[21:40]);
% df/f values for 10s after OFF (30-40s; frames 62-81; col 61-80)
dff_OFF10 = dff_copy(:,[61:80]);
% Note: Find out the cols for 180s JNL

% writes matrices as comma separated text files to use for plotting
isHighConc = true; % creates Boolean defaulting isHighConc to true
isCompare = true; % creates Boolean defaulting isCompare to true
% prompts user to specify if this data is the High or Low concentration
prompt = "\n Are you prepping salt data for the Higher concentration? (i.e. 250mM vs 25mM)\n  *Note: For WT vs mutant, let WT be High & mutant be Low concentration \n   Answer 'true' or 'false': ";
isHighConc = input(prompt); % stores user's answer: true = 1, false = 0
% prompts user to specify if this data is for comparing neurons AM7 vs AM12
prompt = "\n Is this for comparison of neurons AM7 vs AM12? \n  Answer 'true' or 'false': ";
isCompare = input(prompt); % stores user's answer: true = 1, false = 0
if isCompare % if comparing AM7 & AM12
    isAM7 = true;  % creates Boolean defaulting isHighConc to true
    prompt = "\n Is this data for AM7? \n  Answer 'true' for AM7 or 'false' for AM12: ";
    isAM7 = input(prompt); % stores user's answer: true = 1, false = 0
    if isAM7 % if AM7
        if isHighConc
             writematrix(dff_ON10,"ON_10s-H-AM7");
             writematrix(dff_OFF10,"OFF_10s-H-AM7");
        else
             writematrix(dff_ON10,"ON_10s-L-AM7");
             writematrix(dff_OFF10,"OFF_10s-L-AM7");
        end
    else % if AM12
        if isHighConc
             writematrix(dff_ON10,"ON_10s-H-AM12");
             writematrix(dff_OFF10,"OFF_10s-H-AM12");
        else
             writematrix(dff_ON10,"ON_10s-L-AM12");
             writematrix(dff_OFF10,"OFF_10s-L-AM12");
        end
    end
 else % if not comparing AM7 vs AM12
     if isHighConc
           writematrix(dff_ON10,"ON_10s-H");
           writematrix(dff_OFF10,"OFF_10s-H");
     else
             writematrix(dff_ON10,"ON_10s-L");
             writematrix(dff_OFF10,"OFF_10s-L");
     end
end

% ===================PLEASE READ BEFORE PLOTTING========================
% Now you have dff_ON10 and OFF10 for this specific neuron & salt 
% concentration combo.
% In the bar plot, you will want to compare different concentrations for
% the same salt AND same neuron together.
% (i.e., For AM7L, compare 0.25M NH4Cl vs 0.025M NH4Cl)

% What you must do (if not done already):
% Put all of the new .txt files that you want to compare in a single set of
% ON & OFF plots into ONE folder specifically dedicated to that 
% neuron/salt combo.
% Example: (These can all go into 1 folder. They will be plotted together)
% 0025M_NH4Cl_posL-OFF10.txt
% 0025M_NH4Cl_posL-ON10.txt
% 025M_NH4Cl_posL-OFF10.txt
% 025M_NH4Cl_posL-ON10.txt

% Then navigate to that folder & run the script "dff_dots"
