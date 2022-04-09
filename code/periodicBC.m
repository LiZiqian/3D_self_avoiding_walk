function [Chains_pos,List] = periodicBC(Chains_pos, space_width, List)
%% Proposal

%%
space_widthby2 = fix(space_width/2);
chains_num = size(Chains_pos,2) / 4;
for chain = 1: chains_num
    
    % extract all points' information for one chain in 'Chains_pos'
    col = 1 + (chain - 1) * 4;
    theChain = Chains_pos(:, col:col+3);
    theChain(all(theChain == 0, 2),:) = [];
    
    row_num_theChain = size(theChain, 1);
    if theChain(row_num_theChain, 4) == 2
        % if the point at last row whose mark value is 2, which means
        % current 'theChain' is no longer able to grow and the whole chain
        % will store in 'SpChains_pos' later.
        continue;
    else
        
        % transltion to coordinates system whih has orginal points (0 0 0),
        % it is easier to judge weather the chain reach the period boundary
        row_num_theChain = size(theChain, 1);
        tail_x = theChain(row_num_theChain, 1) -10000;
        tail_y = theChain(row_num_theChain, 2) -10000;
        tail_z = theChain(row_num_theChain, 3) -10000;
        
        
        if (abs(tail_x) == space_widthby2) ||(abs(tail_y) == space_widthby2) ||(abs(tail_z) == space_widthby2)
            
            %update corresponding 'Chains_pos'
            if theChain(row_num_theChain, 4) == 1
                theChain(row_num_theChain, 4) = 2;
            end
            row_num_theChain = size(theChain, 1);
            Chains_pos(1:row_num_theChain, col:col+3) = theChain;
            
            % reverse coordinates
            if abs(tail_x) == space_widthby2
                tail_x = -tail_x;
            end
            if abs(tail_y) == space_widthby2
                tail_y = -tail_y;
            end
            if abs(tail_z) == space_widthby2
                tail_z = -tail_z;
            end
            % reverse back to previous coordinates system whose orginal
            % point is at (10000,10000,10000)
            xyzBC = [tail_x+10000, tail_y+10000, tail_z+10000];
            
            if ismember(xyzBC, List(:,1:3),'rows')
                % if fliped XYZ coordinates are already exist, skip this
                % loop. Result in reduce one growing head. That is the
                % current growing head become a dangling end.
                continue;
            else
                
                % if fliped XYZ is at a new point, which means the chain
                % can continue to grow from new period boundary.
                
                List = cat(1, List, xyzBC); % store the new point's information to List
                
                row_num_Chainspos = size(Chains_pos, 1); % creat a new matrix 'Augment' to store the next point's information and add it to 'Chains_pos'
                Augment = zeros(row_num_Chainspos, 4);
                
                Nebr =...
                    AllValdNebr(tail_x+10000,tail_y+10000,tail_z+10000, space_widthby2); % find out all valid neighbors for this point
                
                if ismember(Nebr, List(:,1:3),'rows')
                    % ismember(Nebr, List(:,1:3),'rows') return all-one,
                    % satisify IF condition, which all neighbors of this 
                    % point is occupied already; or Nebr is empty which
                    % this point go into a dangling end. Just add itself to
                    % 'Chains_pos'.
                    Augment(1,1:4) = [xyzBC, 2];
                    Chains_pos = cat(2, Chains_pos, Augment);
                elseif isempty(Nebr)
                    Augment(1,1:4) = [xyzBC, 2];
                    Chains_pos = cat(2, Chains_pos, Augment);
                else
                    % if it has other valid neighbors for continue growing,
                    % just go ahead one step and store this point and its
                    % new neighbor to 'Chains_pos'.
                    c = 1;
                    while 1
                        Aug = [xyzBC, 2];
                        [Aug, List] = go(Aug, List); % just go ahead one step
                        if (abs(Aug(2, 1)-10000) < space_widthby2) && ...
                                (abs(Aug(2, 2)-10000) < space_widthby2) &&...
                                (abs(Aug(2, 3)-10000) < space_widthby2)
                            % only if this new one step is located within
                            % the periodBC space, the loop break out.
                            break;
                        end
                        % otherwise delete this new step XYZ information
                        % and go ahead again.
                        List(size(List,1),:) = [];
                        c =c +1;
                        if c > 2000
                            fprintf('periodicBC ≥ˆœ÷À¿—≠ª∑.\n');
                            pause;
                        end
                    end
                    Aug(2,4) = 1;
                    Augment(1:2,1:4) = Aug;
                    Chains_pos = cat(2, Chains_pos, Augment);
                end
            end
            
        else
            continue;
        end
        
        
    end
    
    
    
end
end