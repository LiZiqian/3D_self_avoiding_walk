function     [mon_num_left, cro_num_left] = ...
    countParticle(SpChains_pos, Chains_pos, mon_total, cro_total, List)
%% Proposal
% Function 'countParticle' counts how many partiles have been used and how
% many left.
%
% Syntax: [mon_num_left, cro_num_left] = ...
%     countParticle(Chains_pos, mon_total, cro_total)
% Inputs
%	Chains_pos - store all points' coordinates and their sorts.
%   mon_total - the total number of monomers
%   cro_total - the total number of crosslinkages
% Outputs:
%   mon_num_left - the number of monomers left
%   cro_num_left - the number of monomers left
%
% Example: [mon_num_left, cro_num_left] = ...
%    countParticle(Chains_pos, mon_total, cro_total)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% See also: PolyGroth3D.m
%
% Author: Li Ziqian

%------------- BEGIN CODE --------------
%% initialize
Chains_pos = sparse(Chains_pos);

cro_num_used = ...
    (length(find(SpChains_pos == 4)) + length(find(Chains_pos == 4))) / 4;
cro_num_left = cro_total - cro_num_used;

mon_num_onPeriodBC =...
    (length(find(Chains_pos == 2)) + length(find(SpChains_pos == 2))) / 2;
mon_num_used = size(List,1) - cro_num_used - fix(mon_num_onPeriodBC/2); 
% the number of monomer on Period Boundry is only counted as half of itself

mon_num_left = mon_total - mon_num_used;

end
%------------- END CODE --------------