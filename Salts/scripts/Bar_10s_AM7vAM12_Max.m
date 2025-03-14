function Bar_10s_AM7vAM12_Max
%% [Introduction]=========================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a bar plot SPECIFICALLY comparing AM7 vs AM12
% for the same salt conc (i.e. AM7L vs AM12LR for 250mM NH4Cl)
% Specifically comparing Max values
%
% In other words, this script is the same as "PrepBarData_10s_Avg"
% but adapted for comparisons of AM7 vs AM12

% created: 2024-07-23 by Marisa Mackie & Isaiah Martinez
% Parts adapted from script created by Kathleen Quach 2023-10-03
% edited: 2024-07-23
% ========================================================================
%% PREPS DATA FOR AVERAGING - DECIDE IF MEASURING ON OR OFF

% H represents Higher concentration of the salt
% L represents Lower concentration of the salt
% 7 represents AM7
% 12 represents AM12

% reads in the txt files. You must manually specify their names.
% rows = individual worm ; cols = frames

% writes matrices as comma separated text files to use for plotting
isHighConc = true; % creates Boolean defaulting isHighConc to true
% prompts user to specify if this data is the High or Low concentration
prompt = "Are you prepping salt data for the Higher concentration? (i.e. 250mM vs 25mM)\n  *Note: For WT vs mutant, let WT be High & mutant be Low concentration \n   Answer 'true' or 'false': ";
isHighConc = input(prompt); % stores user's answer: true = 1, false = 0

% Based user input (true or false), determines which txt files to
% read generated from PrepBarData scripts
% Will read ON & OFF files
    if isHighConc % reads H files
     Post7ON = readmatrix("ON_10s-H-AM7.txt"); % AM7 H, ON Post
     Post12ON = readmatrix("ON_10s-H-AM12.txt"); % AM12 H, ON Post
     Post7OFF = readmatrix("OFF_10s-H-AM7.txt"); % AM7 H, OFF Post
     Post12OFF = readmatrix("OFF_10s-H-AM12.txt"); % AM12 H, OFF Post
    else % reads L files
     Post7ON = readmatrix("ON_10s-L-AM7.txt"); % AM7 L, ON Post
     Post12ON = readmatrix("ON_10s-L-AM12.txt"); % AM12 L, ON Post
     Post7OFF = readmatrix("OFF_10s-L-AM7.txt"); % AM7 L, OFF Post
     Post12OFF = readmatrix("OFF_10s-L-AM12.txt"); % AM12 L, OFF Post
    end

%% CALCULATE MAX VALUES AT EACH IMPORTANT POINT (10s AFTER ON & OFF)

% Calculates Max value across 10s after ON window for AM7 & AM12
Max7ON = max(Post7ON,[],2);
Max12ON = max(Post12ON,[],2);
% Calculates Max value across 10s after OFF window for AM7 & AM12
Max7OFF = max(Post7OFF,[],2);
Max12OFF = max(Post12OFF,[],2);

%% SAVES AVERAGES AS TEXT FILE
% export data files for plotting & statistical analysis in Prism
    writematrix(Max7ON,"Bar_Max7ON");
    writematrix(Max7OFF,"Bar_Max7OFF");
    writematrix(Max12ON,"Bar_Max12ON");
    writematrix(Max12OFF,"Bar_Max12OFF");
end
