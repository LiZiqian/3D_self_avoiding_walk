function Nebr = AllNebr2(FireSrce)
%% Proposal

%------------- BEGIN CODE --------------
%%
step = 1;
Nebr = [];
for i = 1:size(FireSrce,1)
    fireX = FireSrce(i, 1);
    fireY = FireSrce(i, 2);
    fireZ = FireSrce(i, 3);
    
    % neighbors on cubic faces
    neiborF1 = [fireX + step, fireY, fireZ];
    neiborF2 = [fireX - step, fireY, fireZ];
    neiborF3 = [fireX, fireY + step, fireZ];
    neiborF4 = [fireX, fireY - step, fireZ];
    neiborF5 = [fireX, fireY, fireZ + step];
    neiborF6 = [fireX, fireY, fireZ - step];
    
    % neighbors on cubic sides
    neiborS1 = [fireX + step, fireY + step, fireZ];
    neiborS2 = [fireX + step, fireY - step, fireZ];
    neiborS3 = [fireX + step, fireY, fireZ + step];
    neiborS4 = [fireX + step, fireY, fireZ - step];
    neiborS5 = [fireX - step, fireY + step, fireZ];
    neiborS6 = [fireX - step, fireY - step, fireZ];
    neiborS7 = [fireX - step, fireY, fireZ + step];
    neiborS8 = [fireX - step, fireY, fireZ - step];
    neiborS9 = [fireX, fireY + step, fireZ + step];
    neiborS10 = [fireX, fireY + step, fireZ - step];
    neiborS11 = [fireX, fireY - step, fireZ + step];
    neiborS12 = [fireX, fireY - step, fireZ - step];
    
    % neighbors on cubic corners
    neiborC1 = [fireX + step, fireY + step, fireZ + step];
    neiborC2 = [fireX + step, fireY + step, fireZ - step];
    neiborC3 = [fireX + step, fireY - step, fireZ + step];
    neiborC4 = [fireX + step, fireY - step, fireZ - step];
    neiborC5 = [fireX - step, fireY + step, fireZ + step];
    neiborC6 = [fireX - step, fireY + step, fireZ - step];
    neiborC7 = [fireX - step, fireY - step, fireZ + step];
    neiborC8 = [fireX - step, fireY - step, fireZ - step];
    
    nebr = [neiborF1; neiborF2;neiborF3;neiborF4;neiborF5;neiborF6;...
        neiborS1; neiborS2; neiborS3; neiborS4; neiborS5; neiborS6;...
        neiborS7; neiborS8; neiborS9; neiborS10; neiborS11; neiborS12;...
        neiborC1; neiborC2; neiborC3; neiborC4;  neiborC5; neiborC6;...
        neiborC7; neiborC8];
    
    Nebr = cat(1, Nebr, nebr);
    
end
end
%------------- END CODE --------------
