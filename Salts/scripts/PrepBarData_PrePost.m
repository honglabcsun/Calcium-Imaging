function PrepBarData_PrePost
%% [Introduction]=========================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a bar plot.
% It will calculate dff for each set of logfiles and keep ONLY the dff
% data of all the logfiles within 10s pre-stimulus & 10s post-stimulus. (No break windows)
% Whether these time windows will measure for ON or OFF stimulus is decided 
% by the user.
% The raw data & will then be saved as txt files
% to be exported for plotting in Prism GraphPad software.
% 
% Important: This script should be run prior to "PrepBarData_PrePost_Avg.m"
%
% created: 2024-06-01 by Marisa Mackie & Isaiah Martinez
% Parts adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-06-01
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

%% FILTER DFF VALUES FOR 10s PRE & POST WINDOWS

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

% df/f values for 5s Pre-ON (0s-10s = frame 2-21 = col 1-20)
ON_10Pre = dff_copy(:,[1:20]);
% df/f values for 5s Post-ON (10s-20s = frames 22-41 = col 21-40)
ON_10Post = dff_copy(:,[21:40]);
% df/f values for 5s Pre-OFF (20s-30s = frames 42-61 = col 41-60)
OFF_10Pre = dff_copy(:,[41:60]);
% df/f values for 5s Post-OFF (30s-40s = frames 62-81 = col 61-80)
OFF_10Post = dff_copy(:,[61:80]);

% writes matrices as comma separated text files to use for plotting
isHighConc = true; % creates Boolean defaulting isHighConc to true
% prompts user to specify if this data is the High or Low concentration
prompt = "Are you prepping salt data for the Higher concentration? (i.e. 250mM vs 25mM)\n  *Note: For WT vs mutant, let WT be High & mutant be Low concentration \n   Answer 'true' or 'false': ";
isHighConc = input(prompt); % stores user's answer: true = 1, false = 0
if isHighConc
    writematrix(ON_10Pre,"ON_10Pre-H");
    writematrix(ON_10Post,"ON_10Post-H");
    writematrix(OFF_10Pre,"OFF_10Pre-H");
    writematrix(OFF_10Post,"OFF_10Post-H");
else
    writematrix(ON_10Pre,"ON_10Pre-L");
    writematrix(ON_10Post,"ON_10Post-L");
    writematrix(OFF_10Pre,"OFF_10Pre-L");
    writematrix(OFF_10Post,"OFF_10Post-L");
end


%% READ ME BEFORE NEXT STEP
% ===================PLEASE READ BEFORE PROCEEDING========================
% Now you have new text files for this specific neuron & salt 
% concentration combo.
% In the bar plot, you will want to compare different concentrations for
% the same salt AND same neuron together.
% (i.e. Compare 250mM vs 25mM NH4Cl for AM7L)

% What you must do (if not done already):
% Put all of the new .txt files that you want to compare into ONE folder 
% specifically dedicated to that neuron/salt combo.
%   Example: (These can all go into 1 folder. They will be plotted together)
%   OFF-10Pre-H
%   OFF-10Post-H
%   OFF-10Pre-L
%   OFF-10Post-L

% Then navigate to that folder within the Matlab Path
% Then run the script "PrepBarData_PrePost_Avg.m"

%========================================================================
% Special note: For comparing AM7L/R with AM12 directly, you must
% Put all of the new .txt files that you want to compare into ONE folder 
% specifically dedicated to that AM7-AM12 comparison for that SALT at that
% CONCENTRATION (i.e. AM7 v AM12 at 250mM NH4Cl)
% Then you must add "-AM7" or "-AM12" at the end of the file name like so:
%   OFF-10Pre-H-AM7
%   OFF-10Post-H-AM7
%   OFF-10Pre-H-AM12
%   OFF-10Post-H-AM12

% Then you can navigate to that folder and run the script called
% "PrePost_AM7vAM12.m"

