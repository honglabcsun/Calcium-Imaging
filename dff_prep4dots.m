function dff_prep4dots
% ========================================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a dots/scatter plot.
% It will take each set of logfiles, calculate dff, and keep ONLY the dff
% data of all the logfiles in the 10s windows after the stimulus was
% delivered (dff_10ON) and after the stimulus was removed (dff_10OFF).
% These matrices will then be saved as a txt file & stored in proper
% folders for use with script "dff_dots"
%
% created: 2024-02-28 by Marisa Mackie & Isaiah Martinez
% adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-03-28
% ========================================================================

% [STEP 1 - CALCULATE DFF AGGREGATE]======================================
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

% [STEP 2 - FILTER DFF VALUES ]============================================

% Initializes array for expanding "dff"
dff_copy = zeros(num_logs,119);

% This for loop iterates through each log file & stores the dff data in
% new array "dff_copy"
% i is the current log file's dff data
for i = 1:num_logs
    % j is the dff data at the current frame
    for j = 1:119
        % dff_copy holds dff values for all log files in one array
        dff_copy(i,j) = dff{1,i}(j);
    end
end

% df/f values for 10s after ON (10-20s; frames 20-40 ; col 19-39) 
dff_ON10 = dff_copy(:,[19:38]);
% df/f values for 10s after OFF (30-40s; frames 60-80; col 59-79)
dff_OFF10 = dff_copy(:,[59:78]);

% writes matrices as comma separated text files to use for plotting
% For filename:
% Manually specify salt_conc,  neuron, and indicate ON10 or OFF10
% Do not put "." in the filename, matlab treats it as a file extension
writematrix(dff_ON10,"rlh300_025M_NH4Cl_posR-ON10");
writematrix(dff_OFF10,"rlh300_025M_NH4Cl_posR-OFF10");

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