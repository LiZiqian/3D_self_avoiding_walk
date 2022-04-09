function [Chains_pos, List] = augChainpos(Chains_pos, croend_pos, List)
%% Proposal
% Function 'augChainpos' can augment the Chain_pos when a new crosslinkage
% is added to 'theChain'
%
% Syntax: Chains_pos = augChainpos(Chains_pos, croend_pos)
% Inputs:
%	Chains_pos - store all points' coordinates and their sorts.
%	croend_pos - the coordinate positions of current chain-end
% Outputs:
%    Chains_pos - see above
%
% Example:
%    augChainpos(Chains_pos, croend_pos)
%
% Other m-files required: none
% Subfunctions: go.m
% MAT-files required: none
% See also: grothHeads.m
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%%
row_num = size(Chains_pos,1);
Augment = zeros(row_num,4);

for i = 1:3
    Aug = croend_pos;
    [Aug, List] = go(Aug, List);
    Aug(2,4) = 1;
    Augment(1:2,1:4) = Aug;
    Chains_pos = cat(2, Chains_pos, Augment);
end

end
%------------- END CODE --------------