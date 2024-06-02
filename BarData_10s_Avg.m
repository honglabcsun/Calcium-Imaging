function BarData_10s_Avg
% ========================================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a bar plot.
% It will take the txt files you generated previously (from
% "PrepBarData_10s.m" script) and calculate averages. These averages
% will be exported as .txt files that you for plotting in Prism GraphPad 
% software.
% 
% Important: This script should be run AFTER "PrepBarData_10s.m"
%
% created: 2024-03-03 by Marisa Mackie & Isaiah Martinez
% edited: 2024-06-01
% ========================================================================
%% READS FILES

% H represents Higher concentration of the salt
% L represents Lower concentration of the salt
% ON / 1 represents the 10s window after the stimulus was turned ON
% OFF / 2 represents the 10s window after the stimulus was turned OFF

% reads in the txt files. You must manually specify their names.
% rows = individual worm ; cols = frames
H1 = readmatrix("ON_10s-H"); % higher conc, ON
H2 = readmatrix("OFF_10s-H"); % higher conc, OFF
L1 = readmatrix("ON_10s-L"); % lower conc, ON
L2 = readmatrix("OFF_10s-L"); % lower conc, OFF

%% AVERAGES DFF VALUES ACROSS 10s WINDOW PER SAMPLE
% avg dff values of all frames (averages the 10s) for each animal (n=10)
% generates n values (points)
% also transposes col -> rows
ind_avgsH1 = transpose(mean(H1, 2));
ind_avgsH2 = transpose(mean(H2, 2));
ind_avgsL1 = transpose(mean(L1, 2));
ind_avgsL2 = transpose(mean(L2, 2));

%% SAVES AVERAGES AS TEXT FILE
% export data files for plotting & statistical analysis in Prism
    writematrix(ind_avgsH1,"BarY_ON_10s-H1");
    writematrix(ind_avgsH2,"BarY_OFF_10s-H2");
    writematrix(ind_avgsL1,"BarY_ON_10s-L1");
    writematrix(ind_avgsL2,"BarY_OFF_10s-L2");
end

%% READ ME BEFORE NEXT STEP
% ===================PLEASE READ BEFORE PROCEEDING========================
% Now you have the Averages text files for comparing the ON vs OFF
% differences in 10s windows for High & Low concentrations of a salt for a 
% single neuron.

% You can take these Average txt files (labeled with "BarY") and
% import into Prism GraphPad software for plotting.