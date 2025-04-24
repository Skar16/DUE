%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Torben Burandt, Luis Huber
% Date: 22/04/2024
%
% sourceCoding
%
% Input: - str: String with maximum ASCII Values of 127
% Output: - bin: vector of bit values (0 or 1) MSB at index 1
% Example: sourceCoding(12,7) yields: [0 0 0 1 1 0 0]
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [outputBinVec] = sourceCoding(strValue)


len = length(strValue);

% outputBinVec = zeros(len*7); % could possibly safe time to initalize
% vector

for i = 1:lenoutputArg1 = strValue;out2

dec = double(char(strValue(i)));
bitVec = decToBinVec(dec, 7);
    
if i == 1
        outputBinVec = bitVec % init vector 
    end
outputBinVec = [outputBinVec, bitVec]; % same as horzcat(outputBinVec, bitVec) connetication
% outputBinVec = [outputBinVec ;  bitVec]; make a 7*x matrix 
end


end

