function BarData_PrePost_Avg
%% [Introduction]=========================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a bar plot.
% It will take the txt files you generated previously (from
% "PrepBarData_PrePost.m" script) and calculate averages. These averages
% will be exported as .txt files that you for plotting in Prism GraphPad 
% software.
% 
% Important: This script should be run AFTER "PrepBarData_PrePost.m"
%
% created: 2024-06-01 by Marisa Mackie & Isaiah Martinez
% Parts adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-06-02
% ========================================================================
%% PREPS DATA FOR AVERAGING - DECIDE IF MEASURING ON OR OFF

% H represents Higher concentration of the salt
% L represents Lower concentration of the salt
% 1 / Pre represents the 10s window before the ON or OFF stimulus
% 2 / Post represents the 10s window after the ON or OFF stimulus

% reads in the txt files. You must manually specify their names.
% rows = individual worm ; cols = frames

isON = true; % creates Boolean defaulting isON to true
% prompts user to specify if plotting for ON (true) or OFF (false)
prompt = "\n Are you plotting dots for stimulus ON? \n Answer 'true' or 'false': ";
isON = input(prompt); % stores user's answer: true = 1, false = 0

% Based on value of isON (true or false), determines which txt files to
% read generated from from "PrepBarData_PrePost"
if isON % reads files for ON
    H1 = readmatrix("ON_10Pre-H.txt"); % higher conc, ON Pre
    H2 = readmatrix("ON_10Post-H.txt"); % higher conc, ON Post
    L1 = readmatrix("ON_10Pre-L.txt"); % lower conc, ON Pre
    L2 = readmatrix("ON_10Post-L.txt"); % lower conc, ON Post
else % reads files for OFF
    H1 = readmatrix("OFF_10Pre-H.txt"); % higher conc, OFF Pre
    H2 = readmatrix("OFF_10Post-H.txt"); % higher conc, OFF Post
    L1 = readmatrix("OFF_10Pre-L.txt"); % lower conc, OFF Pre
    L2 = readmatrix("OFF_10Post-L.txt"); % lower conc, OFF Post
end

%% AVERAGES DFF VALUES ACROSS 10s WINDOW PER SAMPLE

% avg dff values across 10s window for each animal (n=10)
% generates n values (points)
% also transposes col -> rows
ind_avgsH1 = transpose(mean(H1, 2));
ind_avgsH2 = transpose(mean(H2, 2));
ind_avgsL1 = transpose(mean(L1, 2));
ind_avgsL2 = transpose(mean(L2, 2));

%% SAVES AVERAGES AS TEXT FILE
% export data files for plotting & statistical analysis in Prism
if isON % for analyzing ON
    writematrix(ind_avgsH1,"DotsYData_H1-ON");
    writematrix(ind_avgsH2,"DotsYData_H2-ON");
    writematrix(ind_avgsL1,"DotsYData_L1-ON");
    writematrix(ind_avgsL2,"DotsYData_L2-ON");
else % for analyzing OFF
    writematrix(ind_avgsH1,"DotsYData_H1-OFF");
    writematrix(ind_avgsH2,"DotsYData_H2-OFF");
    writematrix(ind_avgsL1,"DotsYData_L1-OFF");
    writematrix(ind_avgsL2,"DotsYData_L2-OFF");
end

%% READ ME BEFORE NEXT STEP
% ===================PLEASE READ BEFORE PROCEEDING========================
% Now you have the Averages text files for comparing the differences
% in Pre & Post 10s windows for High & Low concentrations of a salt for a 
% single neuron.

% You can take these Average txt files (labeled with "DotsYData") and
% import into Prism GraphPad software for plotting. 