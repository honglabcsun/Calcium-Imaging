function BarData_10sAfter_Max
% ========================================================================
% Purpose of this script is to take existing Calcium imaging dF/F data and
% prepare it for plotting a bar plot.
% It will take the txt files you generated previously (from
% "PrepBarData_10s.m" script) and calculate max values. 
% These will be exported as .txt files for plotting in Prism GraphPad 
% software.
% 
% Important: This script should be run AFTER "PrepBarData_10sAfter.m"
%
% created: 2024-07-23 by Marisa Mackie & Isaiah Martinez
% edited: 2024-07-23
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

%% CALCULATE MAXIMUM VALUES 10s AFTER ON & OFF

% Calculates Max value across 10s window after ON for each conc
maxH1 = max(H1,[],2);
maxL1 = max(L1,[],2);
% Calculates Max value across 10s window after OFF for each conc
maxH2 = max(H2,[],2);
maxL2 = max(L2,[],2);

%% SAVES AVERAGES AS TEXT FILE
% export data files for plotting & statistical analysis in Prism
    writematrix(maxH1,"BarMax_ON_10s-H1");
    writematrix(maxH2,"BarMax_OFF_10s-H2");
    writematrix(maxL1,"BarMax_ON_10s-L1");
    writematrix(maxL2,"BarMax_OFF_10s-L2");
end
