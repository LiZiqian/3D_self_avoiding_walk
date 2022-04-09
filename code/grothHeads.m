function [Chains_pos, List] = ...
    grothHeads(Chains_pos, space_width, mon_num_left, cro_num_left, List)
%% Proposal
% Function 'grothHeads' control how a head to add a new particle.
%
% Syntax: [Chains_pos] = grothHeads(Chains_pos, mon_num_left, cro_num_left)
% Inputs:
%	Chains_pos - store all points' coordinates and their sorts.
% Outputs:
%   Chains_pos - see above
%
% Example: [Chains_pos] = grothHeads(Chains_pos)
%
% Other m-files required: none
% Subfunctions: go.m
%               augChainpos.m
% MAT-files required: none
% See also: PolyGroth3D.m
%
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%% initial setup
space_widthby2 = fix(space_width/2);
chains_num = size(Chains_pos,2) / 4;
%% run growing

for chain = 1: chains_num
    
    col = 1 + (chain - 1) * 4;
    theChain = Chains_pos(:, col:col+3);
    theChain(all(theChain == 0, 2),:) = [];
    
    row_num_theChain = size(theChain, 1);
    if theChain(row_num_theChain, 4) > 1
        % if the two ends of current chain are both crosslinkages
        continue;
    else
        
        curt_x = theChain(row_num_theChain, 1); % current point's XYZ
        curt_y = theChain(row_num_theChain, 2);
        curt_z = theChain(row_num_theChain, 3);
        Nebr =...
            AllValdNebr(curt_x,curt_y,curt_z, space_widthby2); % find out all valid neighbors for current point
        if ismember(Nebr, List(:,1:3),'rows')
            % if all neighbors of this point is occupied already, just change its
            % mark value to 2(same as at boundary). It become a dangling end.
            theChain(row_num_theChain, 4) = 2;
        else
            [theChain, List] = go(theChain, List);
        end
        
        
        % tail-end of every theChain
        row_num_theChain = size(theChain, 1);
        if theChain(row_num_theChain - 1, 4) == 1
            dice = unidrnd(mon_num_left + cro_num_left);
            if dice > cro_num_left % monomer
                theChain(row_num_theChain, 4) = 1;
                
            else % crosslinkage
                theChain(row_num_theChain, 4) = 4;
                
                [Chains_pos, List] = ...
                    augChainpos(Chains_pos, theChain(row_num_theChain, :), List);
            end
            
            
        else % the tail-end is a crosslinkage end
            theChain(row_num_theChain,:) = [];
        end
        
        % Copy the values from 'theChain' into 'Chains_pos'
        col_num = size(Chains_pos,2);
        addnewrow = zeros(1, col_num);
        row_num_theChain = size(theChain, 1);
        row_num_Chainspos = size(Chains_pos, 1);
        if row_num_theChain > row_num_Chainspos
            row_dif = row_num_theChain - row_num_Chainspos;
            for row = 1:row_dif
                Chains_pos = cat(1, Chains_pos, addnewrow);
            end
        end
        Chains_pos(1:row_num_theChain, col:col+3) = theChain;
        
    end
    
end
end
%------------- END CODE ----------------
