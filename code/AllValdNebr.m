function Nebr = AllValdNebr(X,Y,Z, space_widthby2)
%% Proposal

%------------- BEGIN CODE --------------
%%
% neighbors on cubic faces
neiborF1 = [X + 1, Y, Z];
neiborF2 = [X - 1, Y, Z];
neiborF3 = [X, Y + 1, Z];
neiborF4 = [X, Y - 1, Z];
neiborF5 = [X, Y, Z + 1];
neiborF6 = [X, Y, Z - 1];

% neighbors on cubic sides
neiborS1 = [X + 1, Y + 1, Z];
neiborS2 = [X + 1, Y - 1, Z];
neiborS3 = [X + 1, Y, Z + 1];
neiborS4 = [X + 1, Y, Z - 1];
neiborS5 = [X - 1, Y + 1, Z];
neiborS6 = [X - 1, Y - 1, Z];
neiborS7 = [X - 1, Y, Z + 1];
neiborS8 = [X - 1, Y, Z - 1];
neiborS9 = [X, Y + 1, Z + 1];
neiborS10 = [X, Y + 1, Z - 1];
neiborS11 = [X, Y - 1, Z + 1];
neiborS12 = [X, Y - 1, Z - 1];

% neighbors on cubic corners
neiborC1 = [X + 1, Y + 1, Z + 1];
neiborC2 = [X + 1, Y + 1, Z - 1];
neiborC3 = [X + 1, Y - 1, Z + 1];
neiborC4 = [X + 1, Y - 1, Z - 1];
neiborC5 = [X - 1, Y + 1, Z + 1];
neiborC6 = [X - 1, Y + 1, Z - 1];
neiborC7 = [X - 1, Y - 1, Z + 1];
neiborC8 = [X - 1, Y - 1, Z - 1];

Nebr = [neiborF1; neiborF2;neiborF3;neiborF4;neiborF5;neiborF6;...
    neiborS1; neiborS2; neiborS3; neiborS4; neiborS5; neiborS6;...
    neiborS7; neiborS8; neiborS9; neiborS10; neiborS11; neiborS12;...
    neiborC1; neiborC2; neiborC3; neiborC4;  neiborC5; neiborC6;...
    neiborC7; neiborC8];

Valid =abs(Nebr - 10000) < space_widthby2;
Nebr = Nebr(all(Valid == 1,2),:);

end
%------------- END CODE --------------
