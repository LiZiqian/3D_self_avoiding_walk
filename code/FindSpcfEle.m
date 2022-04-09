function [Col_FireSrce, Row_FireSrce] = FindSpcfEle2(SpChains_pos_full, FireSrce)
%% Proposal

%------------- BEGIN CODE --------------
%%
chains_num = size(SpChains_pos_full,2) / 4;
Row_FireSrce = [];
Col_FireSrce = [];
for chain = 1: chains_num
    col = 1 + (chain - 1) * 4;
    theChain = SpChains_pos_full(:, col:col+3);
    theChain(all(theChain == 0, 2),:) = [];
    
    [~, row_SpcfEle] = ismember(FireSrce, theChain(:, 1:3), 'rows');
    
    Row_FireSrce = cat(1, Row_FireSrce, row_SpcfEle(row_SpcfEle>0,:));
    Col_FireSrce = ...
        cat(1, Col_FireSrce, ones(length(row_SpcfEle(row_SpcfEle>0,:)),1)*col);
end

end
%------------- END CODE --------------