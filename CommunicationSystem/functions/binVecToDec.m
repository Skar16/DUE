%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Torben Burandt, Luis Huber
% Date: 22/04/2024
%
% binVecToDec: converts binary vector to decimal
%
% Input: - bin: bin vector(7 long)
% Output: - decOut: decimal value of binary vector
% Example: decToBinVec(0 0 0 1 1 0 0) yields: 12
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [decOut] = binVecToDec(binVec)
decOut = 0; %initalize output

mult = [64;32;16;8;4;2;1]; % multiplication values for binary vector

decOut = binVec * mult;


end

