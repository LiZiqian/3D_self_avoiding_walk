function [theChain, List] = go(theChain, List)
%% Proposal
% Function 'go' determine where to go in this step for the tail-ends of
% 'theChain'
%
% Syntax: [theChain, List] = go(theChain, List)
% Inputs:
%	theChain - store the points' coodinates and their sorts of current
%	chain
%	List - a list that stores all used points' XYZ information
% Outputs:
%   theChain - see above
%   List - see above
%
% Example: [theChain, List] = ...
%           go([9999,10000,10001,2;9998,10000,10002,1], [1,2,3;4,5,6])
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% See also: grothHeads.m
%           augChainpos.m
%
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%% initialize
row_num_theChain = size(theChain, 1);
step =1;

%%
while 1
    
    dice = unidrnd(3);
    if dice == 1
        theChain(row_num_theChain + 1, 1) =...
            theChain(row_num_theChain, 1) + step;
    elseif dice == 2
        theChain(row_num_theChain + 1, 1) =...
            theChain(row_num_theChain, 1) - step;
    else
        theChain(row_num_theChain + 1, 1) = theChain(row_num_theChain, 1);
    end
    
    dice = unidrnd(3);
    if dice == 1
        theChain(row_num_theChain + 1, 2) =...
            theChain(row_num_theChain, 2) + step;
    elseif dice == 2
        theChain(row_num_theChain + 1, 2) =...
            theChain(row_num_theChain, 2) - step;
    else
        theChain(row_num_theChain + 1, 2) = theChain(row_num_theChain, 2);
    end
    
    dice = unidrnd(3);
    if dice == 1
        theChain(row_num_theChain + 1, 3) =...
            theChain(row_num_theChain, 3) + step;
    elseif dice == 2
        theChain(row_num_theChain + 1, 3) =...
            theChain(row_num_theChain, 3) - step;
    else
        theChain(row_num_theChain + 1, 3) = theChain(row_num_theChain, 3);
    end
    
    if ismember(theChain(row_num_theChain + 1, 1:3), List(:,1:3),'rows')
        theChain(row_num_theChain + 1, :) = [];
    else
        List = cat(1, List, theChain(row_num_theChain + 1, 1:3));
        break;
    end
end


end
%------------- END CODE --------------