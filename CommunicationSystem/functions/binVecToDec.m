%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% binVecToDec: converts binary vector to decimal numbers
%
% Input:    - bin: binary vector of one decimal number
% Output:   - dec: converted decimal number
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dec = binVecToDec(bin)

dec = 0;

mult = [64;32;16;8;4;2;1];

dec = bin * mult;

