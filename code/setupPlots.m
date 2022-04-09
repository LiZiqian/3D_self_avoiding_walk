function setupPlots()
%% Proposal
% Function 'setupPlots' set the style of picutre. 
%
% Syntax: setupPlots(pile_width)
% Inputs: none
% Outputs: none
%
% Example: setupPlots(10)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% See also: PolyGroth3D.m
%
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%% Setup plot
figure('Name','Graph of configuration of polymer network',...
    'NumberTitle','off',...
    'color', [1 1 1],...
    'units','pixels',...
    'position',[400 40 600 600]);

set(gca, 'Position', [0.04,0.01,0.92,0.96]);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
set(gca,'ztick',[]);


end
%------------- END CODE --------------
