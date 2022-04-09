function plotTransmit(FireSrce, Fired, space_width, draw_speed)
%% Proposal
% Function 'plotTransmit' plots the 3D space
%
% Syntax: plotPile(Pile,draw_speed)
% Inputs:
%	Chains_pos - stores all points' coordinate
%	draw_speed - Speed of animation
% Outputs: none
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% See also: EnergyTransmit.m
%
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%% draw picture
Fired_X = Fired(:,1);
Fired_Y = Fired(:,2);
Fired_Z = Fired(:,3);
FireSrce_X = FireSrce(:,1);
FireSrce_Y = FireSrce(:,2);
FireSrce_Z = FireSrce(:,3);

scatter3(Fired_X, Fired_Y, Fired_Z,10,'k','filled');
hold on;
scatter3(FireSrce_X, FireSrce_Y, FireSrce_Z,10, 'g', 'filled');



%% setup picture
set(gca,'fontSize',18);
title('Energy Transfer','fontsize',20,'FontName','Times New Roman','FontWeight','bold');
grid on;
xlim([10000-space_width/2 10000+space_width/2]);
ylim([10000-space_width/2 10000+space_width/2]);
zlim([10000-space_width/2 10000+space_width/2]);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
set(gca,'ztick',[]);
view([-30 20]);
box on;
set(gca, 'BoxStyle','full');
pause(draw_speed)

end
%------------- END CODE --------------
