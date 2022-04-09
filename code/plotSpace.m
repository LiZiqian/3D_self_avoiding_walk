function plotSpace(SpChains_pos_full, space_width, draw_speed)
%% Proposal
% Function 'plotSpace' plots the 3D space
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
% See also: PolyGroth3D.m
%
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%% Initialize
Crosslink = [];
Head = [];

%% get point and draw picture
chains_num = size(SpChains_pos_full,2) / 4;
for i = 1: chains_num
    col = 1 + (i-1) * 4;
    theChain = SpChains_pos_full(:, col:col+3);
    theChain(all(theChain == 0, 2),:) = [];
    
    row_num_theChain = size(theChain, 1);
    % find corsslinkage and head
    if theChain(row_num_theChain, 4) == 4
        Crosslink = ...
            cat(1, Crosslink, theChain(row_num_theChain, 1:3));
    elseif theChain(row_num_theChain, 4) == 1
        Head = cat(1, Head, theChain(row_num_theChain, 1:3));
    end
end
Head = unique(Head, 'rows');
if ~isempty(Head)
    Head_X = Head(:,1);
    Head_Y = Head(:,2);
    Head_Z = Head(:,3);
    plot3(Head_X, Head_Y, Head_Z, 'k.',...
        'Markersize', 10);
    hold on;  
end

if ~isempty(Crosslink)
    Cross_X = Crosslink(:,1);
    Cross_Y = Crosslink(:,2);
    Cross_Z = Crosslink(:,3);
    plot3(Cross_X, Cross_Y, Cross_Z, 'k.',...
        'Markersize', 35);
end


for i = 1: chains_num
    col = 1 + (i-1) * 4;
    theChain = SpChains_pos_full(:, col:col+3);
    theChain(all(theChain == 0, 2),:) = [];
    
    x = theChain(:,1);
    y = theChain(:,2);
    z = theChain(:,3);
    
    line(x, y, z,...
        'linewidth',0.1,...
        'Color',[125 125 125]/255);
end

%% setup picture
set(gcf,'color', [1 1 1],...
    'units','pixels',...
    'position',[400 200 600 600]);

% title('3D Self-avoiding Walk','fontsize',20','FontName','Times New Roman','FontWeight','bold');
grid on;
xlim([10000-space_width/2 10000+space_width/2]);
ylim([10000-space_width/2 10000+space_width/2]);
zlim([10000-space_width/2 10000+space_width/2]);
set(gca, 'Position', [0.04,0.01,0.92,0.96]);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
set(gca,'ztick',[]);
view([-30 20]);
box on;
set(gca, 'BoxStyle','full');
pause(draw_speed)

end
%------------- END CODE --------------
