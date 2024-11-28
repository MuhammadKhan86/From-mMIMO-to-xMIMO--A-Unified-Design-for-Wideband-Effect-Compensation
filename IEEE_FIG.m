function IEEE_FIG(fontSize, height, width)

params.figFontSize = fontSize;
params.deafultFontName = 'Times';
% IEEE Single Column
% params.defaultFigPosition = [0 0 8.89 4];
%% for fig 5 a
% params.defaultFigPosition = [0 0 4.9 5];
%% for fig 5 CDE
% params.defaultFigPosition = [0 0 4.433 5];
% IEEE Double Column
% params.defaultFigPosition = [0 0 18.2 4];
% params.defaultFigPosition = [0 0 19 4];
params.defaultFigPosition = [0 0 width height];



set(0,'DefaultAxesFontSize',params.figFontSize); %Eight point Times is suitable typeface for an IEEE paper. Same as figure caption size
set(0,'DefaultFigureColor','w')
set(0,'defaulttextinterpreter','tex') %Allows us to use LaTeX maths notation
set(0,'DefaultAxesFontName', params.deafultFontName);
set(0,'defaultFigureUnits', 'centimeters', 'defaultFigurePosition', params.defaultFigPosition);