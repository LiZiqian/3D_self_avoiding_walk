function [SpChains_pos_full, List, cro_num_left, mon_num_left, F] = ...
    PolyGroth3D(space_width, cro_total, mon_total, draw_speed)
%% Proposal
% This is the main function
% Consider a saqure 3-D space with linear dimension of 'space_width'. The
% number of polymer monomer is 'mon_num', and the number of crosslinkage is
% 'cro_num'.  For a blank space, set a initail seed for consequent growing.
% the polymer chain can grown at both sides of the seed. In every step, the
% sort of growing molecules depends on the relative number of crosslinkages
% and monomers. Each monomer can only link with two neighbors and one
% crosslinkage can have four monomer neighbors.The program stops when all
% monomers and crosslinkages are run out.
%
% Syntax: [SpChains_pos_full, SpChains_pos, Chains_pos, List, spbias] = ...
%    PolyGroth3D(space_width, cro_total, mon_total, draw_speed)
% Inputs:
%	space_width - Side length of the 3D space
%	mon_num - number of monomers
%	cro_num - number of corsslinkages
%	draw_speed - control the speed of drawing picture
% Outputs: none
%
% Example:
%   [SpChains_pos_full, List, cro_num_left, mon_num_left, F] = PolyGroth3D(89, 9, 19494, 0.001);
%
% Other m-files required: none
% Subfunctions: countParticle.m
%               countHead.m
%               grothHeads.m
%               plotSpace.m
% MAT-files required: none
% See also: none
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%% initial setup

%----Set up initial growing point----%
Chains_pos = zeros(3,8);
seedx = 10000;
seedy = 10000;
seedz = 10000;
Chains_pos(1,1:8) = [seedx, seedy, seedz, 1, seedx, seedy, seedz, 1];
%-----------------------------------%

SpChains_pos = sparse(10,10);
List = Chains_pos(1,1:3); % 'List' store all points' information
spbias = 0; % used for locating colum-number of sparse SpChians_pos
t_vedio = 1;
mon_num_left_pre = 0;
cro_num_left_pre = 0;
%% Run model
while 1
    
    %---------------------------Stop condition----------------------------%
    %Calculate the number of monomers and crosslinkages left.
    [mon_num_left, cro_num_left] = ...
        countParticle(SpChains_pos, Chains_pos, mon_total, cro_total, List);
    if mon_num_left < cro_total*3
        break;
    end
    if mon_num_left_pre == mon_num_left && cro_num_left_pre == cro_num_left
        break;
    else
        mon_num_left_pre = mon_num_left;
        cro_num_left_pre = cro_num_left;
    end
    
    %---------------------------------------------------------------------%
    
    
    %-----------------Go ahead for every heads in this step---------------%
    spl_wid = size(Chains_pos,2); % the colum-width of Chains_pos that grows in every step
    [Chains_pos, List] = periodicBC(Chains_pos, space_width, List); % update coordinates in Periodic Boundary Condition
    [Chains_pos, List] = ...
        grothHeads(Chains_pos, space_width, mon_num_left, cro_num_left, List); % grow a step for every head
    %---------------------------------------------------------------------%
    
    
    %---------Dispose Chains_pos in order to reduce compute cost----------%
    if size(Chains_pos,2) > spl_wid
        % a new crosslink emerge or a chain touch the side of the space,
        % which means chains_pos augments itself.
        
        % split chains_pos into two parts, one is 'store' part which used
        % to store in 'SpChains_pos'; another part is 'update' part in
        % which the ID value is not 1 and update it to 'Chains_pos' for
        % next 'while loop'.
        c_S = 1; % for Chains_posStore
        c_U = 1; % for Chains_posUpdate
        Chains_posUpdate = [];
        Chains_posStore = [];
        for chain = 1: (size(Chains_pos,2)/4)
            col = 1 + (chain - 1) * 4;
            theChain = Chains_pos(:, col:col+3);
            theChain(all(theChain == 0, 2),:) = [];
            if theChain(size(theChain, 1), 4) == 1
                Chains_posUpdate(1:size(Chains_pos,1), c_U:c_U+3) ...
                    = Chains_pos(:, col:col+3);% pick out those chain which are going to grow
                c_U = c_U + 4;
            else
                Chains_posStore(1:size(Chains_pos,1), c_S:c_S+3) ...
                    = Chains_pos(:, col:col+3);% pick out those chain which never change
                c_S = c_S + 4;
            end
        end
        
        % store 'Chians_posStore' into 'SpChains_pos'
        [C_i, C_j, C_s] = find(sparse(Chains_posStore));
        C_j = C_j + spbias; % correct colum number
        [SpC_i, SpC_j, SpC_s] = find(SpChains_pos);
        temp = ...
            cat(1, [SpC_i, SpC_j, SpC_s], [C_i, C_j, C_s]);
        SpChains_pos = sparse(temp(:,1), temp(:,2), temp(:,3));
        
        % update Chains_pos
        Chains_pos = Chains_posUpdate;
        
        spbias = spbias + size(Chains_posStore, 2);
    end
    %---------------------------------------------------------------------%
    
    
    %----------Draw the whole process of growing polymer network----------%
    % If you want to draw the picture of growing polymer network process
    % during run this programme, uncomment 130-135 and 137. But it will greatly
    % increase computating cost.
    % If you want to output vedio, uncomment 136, 138 and 'Section Output
    % Video'. Still, it will increase time cost.
    SpChains_pos_full = full(SpChains_pos);
    col_start = spbias+1;
    col_end = size(Chains_pos,2);
    row_end = size(Chains_pos,1);
    SpChains_pos_full(1:row_end, col_start:col_start+col_end-1) = Chains_pos;
    plotSpace(SpChains_pos_full, space_width, draw_speed);
    F(t_vedio) = getframe(gcf); % get present picture as present frame of the video
    clf;
    t_vedio = t_vedio + 1;
    %---------------------------------------------------------------------%
end

SpChains_pos_full = full(SpChains_pos);
col_start = spbias+1;
col_end = size(Chains_pos,2);
row_end = size(Chains_pos,1);
SpChains_pos_full(1:row_end, col_start:col_start+col_end-1) = Chains_pos;

setupPlots();
plotSpace(SpChains_pos_full, space_width, draw_speed);

fprintf('The growing finish!\n');
fprintf('The space width is %g.\n', space_width);
fprintf('The number of crosslinkages in space are %g,', cro_total-cro_num_left);
fprintf(' and the number of monomer used are %g.\n', mon_total - mon_num_left);


%% Output Video
%  video = VideoWriter('Polymer Growth' , 'MPEG-4');
%  video.FrameRate = 30;
%  open(video)
%  writeVideo(video,F);
%  close(video);
end
%------------- END CODE --------------
