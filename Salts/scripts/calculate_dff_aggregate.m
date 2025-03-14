function calculate_dff_aggregate
% =========================================================================
% CALCULATE_DFF_AGGREGATE
% For each subdirectory in the current directory, take LOGFILE, the 
% filename of log file generated from tracking neurons in Metamorph, and 
% generate a plot containing individual and aggregate df/f as percent 
% change in fluorescence. The current directory should contain all log 
% files for a comparison group. 
% =========================================================================
% edited: 10.03.23
% by: Kathleen Quach (kquach@salk.edu)
% MATLAB version: R2021a 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% Initialize aggregate plot
figure;
hold on % Keeps all elements on figure
xlim([0,60]) % x axis limits (for 60s jnl)
% xlim([0,180]) % x axis limits (for 180s jnl)
ylim([-100,100]) % y axis limits
xlabel('Time (seconds)','FontSize',14); 
ylegend = 'dF/F (%)';
ylabel(ylegend, 'FontSize',14);
% Plot vertical lines to indicate notable timepoints (i.e. stimulus changes)
% Manually change time in seconds (e.g. xline(seconds,'r');
% comment out vertical lines for light controls & special JNLs
xline(10,'r'); % r = red, c = cyan
xline(30,'r'); % (for 60s jnl)
% xline(130, 'r'); % (for 180s jnl)

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

    % ==[ Plot individual df/f ]===========================================
    plot(x,dff{i}) 
end

% ==[ Calculate mean dff ]=================================================
% Calculate the maximum number of frames of all log files. For variable
% video lengths, this ensures that all frames are represented. 
max_num_frames = max(num_frames); 
% Get index of log file with max number of frames
max_num_frames_ind = find(num_frames == max_num_frames);
% Use one file index if there are multiple files with max number of frames 
max_num_frames_ind = max_num_frames_ind(1); 

% Initialize array for mean dff
mean_dff = NaN(1,max_num_frames); % Mean dff

for j = 1:max_num_frames % Iterate through each frame
    % Initalize array for all dff values for current frame
    data_frame = NaN(1,num_logs); 
    for k = 1:num_logs % Iterate through each log file
        if length(dff{k}) >= j
            data_frame(k) = dff{k}(j); 
        end
    end
    data_frame = rmmissing(data_frame); % Remove NANs
    mean_dff(j) = mean(data_frame); % Calculate mean for current frame
end

% ==[ Plot mean dff ]======================================================
logfile = log_list{max_num_frames_ind};
data = load(logfile); 
x_max = data(:,2)/1000; % ms/1000
plot(x_max, mean_dff,'k-','LineWidth',2) % k = black

% ==[ Save aggregate plot ]================================================
plotname = 'aggregate_plot.png';
saveas(gcf,plotname) % Save plot
end
