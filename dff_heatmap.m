function dff_heatmap
% ========================================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% generate a heatmap demonstrating the positive or negative % change in
% dF/F (colors) for each individual worm (each row). The heatmap will be
% generated per condition (i.e. stimulus-strain combination)
%
% created: 2024-02-23 by Marisa Mackie & Isaiah Martinez
% adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-03-28
% ========================================================================

% [STEP 1 - CALCULATE DFF AGGREGATE]======================================
% Does the exact same thing as script "calculate_dff_aggregate".
% Below is Kathleen's code:

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


% [STEP 2 - GENERATE HEATMAP]=============================================

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

%====== Heatmap manual normalization ======%
% normalizes whole matrix of data for heatmap
norm_dff = (dff_copy - min(dff_copy(:))) / (max(dff_copy(:)) - min(dff_copy(:)));
h = heatmap(norm_dff, 'Colormap',hot); % generates heatmap & sets colors
h.XLabel = 'frames'; % x axis label
h.YLabel = strcat('individuals n =', num2str(num_logs)); % y axis label + n
h.GridVisible = 'off'; % removes gridlines so heatmap looks cohesive

% Below generates manual tick labels for x-axis
Xticks = 2:120; % for 60s jnl
%Xticks = 2:1800; % for 180s jnl
newXticks = string(Xticks);
% only labels tick at every 10 frames (for 60s jnl)
% manually change 10 to 100 (for 180s jnl)
newXticks(mod(Xticks,10) ~= 0) = " ";
h.XDisplayLabels = newXticks;

% saves heatmap as .png
saveas(gcf,'heatmap_norm.png')

% %====== Heatmap using imagesc ======%
% colormap('hot') % color palette of heatmap
% imagesc(dff_copy); % creates heatmap using the data you want (uses own scale)
% cb = colorbar; % bar key for which colors represent dff values
% xlabel('frames') % labels x axis
% ylabel(strcat('individuals n =', num2str(num_logs))) % labels y axis
% ylabel(cb,'% dF/F') % labels color bar
% % saves heatmap as .png
% saveas(gcf,'heatmap.png')
