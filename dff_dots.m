function dff_dots
% ========================================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% generate a combined bar/scatter plot. The points will represent the
% average percent change in dff of each individual animal. Multiple data 
% sets will be plotted for comparison between salts at different 
% concentrations.
% This script is to be used after "dff_prep4dots"
%
% created: 2024-03-03 by Marisa Mackie & Isaiah Martinez
% edited: 2024-03-28
% ========================================================================

% ===================PLEASE READ BEFORE PLOTTING========================
% Before using this script, please make sure you have already done the
% following two steps:
% (1) Ran "dff_prep4dots" for desired files
% (2) Put all of the newly generated .txt files that you want to compare 
% in a single set of ON & OFF plots into ONE folder specifically 
% dedicated to that neuron/salt combo.
% Make sure you navigate to that folder when you want to run this script &
% add it to your path
% =======================================================================

% H represents Higher concentration of the salt
% L represents Lower concentration of the salt
% ON / 1 represents the 10s window after the stimulus was turned ON
% OFF / 2 represents the 10s window after the stimulus was turned OFF

% reads in the txt files. You must manually specify their names.
% rows = individual worm ; cols = frames
H1 = readmatrix("025M_NH4Cl_posR-ON10.txt"); % higher conc, ON
H2 = readmatrix("025M_NH4Cl_posR-OFF10.txt"); % higher conc, OFF
L1 = readmatrix("rlh300_025M_NH4Cl_posR-ON10.txt"); % lower conc, ON
L2 = readmatrix("rlh300_025M_NH4Cl_posR-OFF10.txt"); % lower conc, OFF


nH = size(H1,1); % counts num of worms (rows) in H matrix
nL = size(L1,1); % counts num of worms (rows) in L matrix
% note: size of H1 should always be equal to H2. Same goes for L1 & L2.
% This will be used for plotting x later


% avg dff values of all frames (averages the 10s) for each animal (n=10)
% generates n values (points)
% also transposes col -> rows
ind_avgsH1 = transpose(mean(H1, 2));
ind_avgsH2 = transpose(mean(H2, 2));
ind_avgsL1 = transpose(mean(L1, 2));
ind_avgsL2 = transpose(mean(L2, 2));

% prep for plotting
xH = ones(nH); % number inside = number of logfiles (worms)
xL = (ones(nL)) + 1; % +1 to fill matrix with 2s instead of 1s

%[STEP 4 - PLOT DOTS ]==========================================

figure('Position',[400 200 350 470]); % creates figure, manually specify size
% note: default size for figure is 580 x 470 (last 2 numbers)

% 1st plot - 10s after ON (administration)
subplot(1,2,1); % sets position of plot 
yline(0, 'k') % adds horizontal black line at y = 0
hold on;
scatter(xH, ind_avgsH1, 'MarkerEdgeColor',[0.5 0.5 0.5], 'LineWidth', 1); % plots points for H1
% colors: 'r' for higher conc; 'MarkerEdgeColor', [0.5 0.5 0.5] for wt
hold on;
scatter(xL, ind_avgsL1, 'm', 'LineWidth', 1); % plots points for L1
% colors: 'b' for lower conc; 'm' for mutant
ylim([-100 100]); % sets y-axis limits
xlim([0.3,2.5]); % sets x-axis limits
xticks([1 2]) % sets tick values for x axis
ylabel('Average % dF/F')
hold off;

%2nd plot - 10s after OFF (removal)
subplot(1,2,2); % sets position of plot
yline(0, 'k') % adds horizontal black line at y = 0
hold on;
scatter(xH, ind_avgsH2, 'MarkerEdgeColor', [0.5 0.5 0.5], 'LineWidth', 1); % plots points for H2
% colors: 'r' for higher conc; 'MarkerEdgeColor', [0.5 0.5 0.5] for wt
hold on;
scatter(xL, ind_avgsL2, 'm', 'LineWidth', 1); % plots points for L2
% colors: 'b' for lower conc; 'm' for mutant
ylim([-100 100]);  % sets y-axis limits
xlim([0.3,2.5]); % sets x-axis limits
xticks([1 2]) % sets tick values for x axis
hold off;

% save plot as png
plotname = 'dots.png';
saveas(gcf,plotname) % Save plot
end