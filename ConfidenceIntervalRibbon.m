function ConfidenceIntervalRibbon
% ========================================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% plot a single average line, with a shaded ribbon around the line to
% represent confidence intervals.
%
% created: 2024-02-13 by Marisa Mackie
% adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-03-06
% ========================================================================

% [STEP 1 - CALCULATE DFF AGGREGATE]======================================
% Does the exact same thing as script "calculate_dff_aggregate", but 
% excludes the individual traces. We should have a plot with only a single
% average line. Below is Kathleen's code:

% ==[ Manually input recording parameters ]=====
% Indicate the end of the baseline period in seconds
baseline_end_s = 10; 

% ==[ Set up batch processing ]=====
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
    % ==[ Load data ]=====
    % Load comma-delimited data 
    logfile = log_list{i};
    data = load(logfile); 

    % Keep only the first three columns
    % col 1: frame
    % col 2: time in ms
    % col 3: background-subtracted fluorescence
    data_sub = data(:,3); 
    num_frames(i) = length(data_sub); % Number of frames in log file

    % ==[ Calculated individual df/f ]=====
    % Define x-values as seconds 
    x = data(:,2)/1000; % ms/1000
    % Define baseline as ending 1 second before stimulus starts, to avoid 
    % artifacts associated with transitions
    baseline_ind = find(x <= baseline_end_s-1);
    f0 = mean(data_sub(baseline_ind));
    dff{i} = ((data_sub-f0)/f0) * 100;
end

% ==[ Calculate mean dff and standard deviation]=====
% Calculate the maximum number of frames of all log files. For variable
% video lengths, this ensures that all frames are represented. 
max_num_frames = max(num_frames); 
% Get index of log file with max number of frames
max_num_frames_ind = find(num_frames == max_num_frames);
% Use one file index if there are multiple files with max number of frames 
max_num_frames_ind = max_num_frames_ind(1); 

% Initialize array for mean dff
mean_dff = NaN(1,max_num_frames); % Mean dff

% Initialize array for std dff
std_dff = NaN(1,max_num_frames); % Std dff

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
    std_dff(j) = std(data_frame); % Calculate std for current frame

    % ==[ Calculate Rolling Confidence Intervals ]=====
    % Rolling CIs are for time-series, which is why this calculation is
    % inside the for-loop
    % Formula: CI = X +- Z(S/sqrt(n)) or CI = X +- moe
    % X = sample mean
    % Z = Z-score from table or T-score. Using T-score because n < 30
    % S = population standard deviation
    % n = sample size
    % moe = margin of error
    % + or - used to calculate upper and lower margins for CI

    % set confidence level (for calculating CI later)
    conf = 0.95;

    % calculate t-score for current frame with given confidence level
    tscore(j) = tinv((1 + conf) / 2, length(data_frame) - 1);
    % calculate margin of error (moe) for current frame
    moe(j) = tscore(j) * (std_dff(j)/sqrt(length(data_frame) - 1));
    % calculate confidence interval (upper & lower) for current frame
    CI_upper(j) = mean_dff(j) + moe(j);
    CI_lower(j) = mean_dff(j) - moe(j);
  
end

% ==[ Plot mean dff ]=====
logfile = log_list{max_num_frames_ind};
data = load(logfile); 
x_max = data(:,2)/1000; % ms/1000
plot(x_max, mean_dff,'k-','LineWidth',2) % k = black, b = blue, r = red

% ==[ CI Ribbon ]=====
% set CI bounds
x_tp = transpose(x_max); % transpose x so vectors are same length
xconf = [x_tp, x_tp(end:-1:1)];
yconf = [CI_upper, CI_lower(end:-1:1)];

% fill ribbon between conf bounds in gray
ribbon = fill(xconf, yconf, [0.5, 0.5, 0.5]); % [0.5, 0.5, 0.5] = gray

% makes ribbon transparent & have no edge line
set(ribbon, 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% ==[ Save aggregate plot ]================================================
plotname = 'aggregate_plot_ribbonCI.png';
saveas(gcf,plotname) % Save plot
end







