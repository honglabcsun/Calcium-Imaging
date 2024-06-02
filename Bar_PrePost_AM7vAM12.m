function Bar_PrePost_AM7vAM12
%% [Introduction]=========================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a bar plot SPECIFICALLY comparing AM7 vs AM12
% for the same salt conc (i.e. AM7L vs AM12LR for 250mM NH4Cl)
%
% In other words, this script is the same as "PrepBarData_PrePost_10s_Avg"
% but adapted for comparisons of AM7 vs AM12

% created: 2024-06-02 by Marisa Mackie & Isaiah Martinez
% Parts adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-06-02
% ========================================================================
%% PREPS DATA FOR AVERAGING - DECIDE IF MEASURING ON OR OFF

% H represents Higher concentration of the salt
% L represents Lower concentration of the salt
% 7 represents AM7
% 12 represents AM12
% Pre represents the 10s window before the ON or OFF stimulus
% Post represents the 10s window after the ON or OFF stimulus

% reads in the txt files. You must manually specify their names.
% rows = individual worm ; cols = frames

% writes matrices as comma separated text files to use for plotting
isHighConc = true; % creates Boolean defaulting isHighConc to true
% prompts user to specify if this data is the High or Low concentration
prompt = "Are you prepping salt data for the Higher concentration? (i.e. 250mM vs 25mM)\n  *Note: For WT vs mutant, let WT be High & mutant be Low concentration \n   Answer 'true' or 'false': ";
isHighConc = input(prompt); % stores user's answer: true = 1, false = 0

isON = true; % creates Boolean defaulting isON to true
% prompts user to specify if plotting for ON (true) or OFF (false)
prompt = "Are you plotting dots for stimulus ON? \n Answer 'true' or 'false': ";
isON = input(prompt); % stores user's answer: true = 1, false = 0

% Based user input (true or false), determines which txt files to
% read generated from PrepBarData scripts
if isON % reads files for ON
    if isHighConc % reads H files
     Pre7 = readmatrix("ON_10Pre-H-AM7.txt"); % AM7 H, ON Pre
     Post7 = readmatrix("ON_10Post-H-AM7.txt"); % AM7 H, ON Post
     Pre12 = readmatrix("ON_10Pre-H-AM12.txt"); % AM12 H, ON Pre
     Post12 = readmatrix("ON_10Post-H-AM12.txt"); % AM12 H, ON Post
    else % reads L files
     Pre7 = readmatrix("ON_10Pre-L-AM7.txt"); % AM7 L, ON Pre
     Post7 = readmatrix("ON_10Post-L-AM7.txt"); % AM7 L, ON Post
     Pre12 = readmatrix("ON_10Pre-L-AM12.txt"); % AM12 L, ON Pre
     Post12 = readmatrix("ON_10Post-L-AM12.txt"); % AM12 L, ON Post
    end
else % reads files for OFF
     if isHighConc % reads H files
     Pre7 = readmatrix("OFF_10Pre-H-AM7.txt"); % AM7 H, OFF Pre
     Post7 = readmatrix("OFF_10Post-H-AM7.txt"); % AM7 H, OFF Post
     Pre12 = readmatrix("OFF_10Pre-H-AM12.txt"); % AM12 H, OFF Pre
     Post12 = readmatrix("OFF_10Post-H-AM12.txt"); % AM12 H, OFF Post
    else % reads L files
     Pre7 = readmatrix("OFF_10Pre-L-AM7.txt"); % AM7 L, OFF Pre
     Post7 = readmatrix("OFF_10Post-L-AM7.txt"); % AM7 L, OFF Post
     Pre12 = readmatrix("OFF_10Pre-L-AM12.txt"); % AM12 L, OFF Pre
     Post12 = readmatrix("OFF_10Post-L-AM12.txt"); % AM12 L, OFF Post
    end
end

%% AVERAGES DFF VALUES ACROSS 10s WINDOW PER SAMPLE

% avg dff values across 10s window for each animal (n=10)
% generates n values (points)
% also transposes col -> rows
ind_avgsPre7 = transpose(mean(Pre7, 2));
ind_avgsPost7 = transpose(mean(Post7, 2));
ind_avgsPre12 = transpose(mean(Pre12, 2));
ind_avgsPost12 = transpose(mean(Post12, 2));

%% SAVES AVERAGES AS TEXT FILE
% export data files for plotting & statistical analysis in Prism
if isON % for analyzing ON
    writematrix(ind_avgsPre7,"DotsYData_Pre7-ON");
    writematrix(ind_avgsPost7,"DotsYData_Post7-ON");
    writematrix(ind_avgsPre12,"DotsYData_Pre12-ON");
    writematrix(ind_avgsPost12,"DotsYData_Post12-ON");
else % for analyzing OFF
    writematrix(ind_avgsPre7,"DotsYData_Pre7-OFF");
    writematrix(ind_avgsPost7,"DotsYData_Post7-OFF");
    writematrix(ind_avgsPre12,"DotsYData_Pre12-OFF");
    writematrix(ind_avgsPost12,"DotsYData_Post12-OFF");
end

%% READ ME BEFORE NEXT STEP
% ===================PLEASE READ BEFORE PROCEEDING========================
% Now you have the Averages text files for comparing the differences
% in Pre & Post 10s windows for AM7 & AM12 at a specific salt &
% concentration.

% You can take these Average txt files (labeled with "DotsYData") and
% import into Prism GraphPad software for plotting. 