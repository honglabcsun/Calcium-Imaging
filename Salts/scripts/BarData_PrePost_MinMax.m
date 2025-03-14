function BarData_PrePost_MinMax
%% [Introduction]=========================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a bar plot.
%
% It will take the txt files you generated previously (from
% "PrepBarData_PrePost.m" script) and calculate a Post/Pre ratio at each
% time point across the 10s window Before (pre) and After (post) the
% stimulus (ON or OFF, user choice).
% After calculating the ratios, they will be averaged. These values will be
% exported as .txt files that you for plotting in Prism GraphPad software.
% 
% Important: This script should be run AFTER "PrepBarData_PrePost.m"
%
% created: 2024-07-16 by Marisa Mackie & Isaiah Martinez
% Parts adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-07-16
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
%% CALCULATE PRE-MINs and POST-MAXs

% Calculates Minimum value across 10s Pre-stimulus window for each conc
minH1 = min(H1,[],2);
minL1 = min(L1,[],2);
% Calculates Maximum value across 10s Post-stimulus window for each conc
maxH2 = max(H2,[],2);
maxL2 = max(L2,[],2);

%% SAVES MIN-MAX DATA AS TEXT FILE
% export data files for plotting & statistical analysis in Prism
if isON % for analyzing ON
    writematrix(minH1,"BarMin-HPre-ON");
    writematrix(maxH2,"BarMax_HPost-ON");
    writematrix(minL1,"BarMin_LPre-ON");
    writematrix(maxL2,"BarMax_LPost-ON");
else % for analyzing OFF
    writematrix(minH1,"BarMin-HPre-OFF");
    writematrix(maxH2,"BarMax_HPost-OFF");
    writematrix(minL1,"BarMin_LPre-OFF");
    writematrix(maxL2,"BarMax_LPost-OFF");
end
%% READ ME BEFORE NEXT STEP
% ===================PLEASE READ BEFORE PROCEEDING========================
% Now you have the Averages text files for comparing the differences
% between Post/Pre ratios for High & Low concentrations of a salt for a 
% single neuron. Can also be used for later comparisons of WT Post/Pre vs
% mutant Post/Pre.

% You can take these Average txt files (labeled with "DotsYData") and
% import into Prism GraphPad software for plotting.
