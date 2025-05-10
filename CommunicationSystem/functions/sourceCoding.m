%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% sourceCoding: Converts the full string into a matrix where each row 
% is a bit vector representing a character in the input string.
% 
% Input: 
%   - inputString: A string to be encoded
% Output: 
%   - output: A matrix of binary vectors (each row corresponds to one character)
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = sourceCoding(inputString)

len = length(inputString);  % Get the length of the input string

N = 7;  % Number of bits to represent each character (ASCII standard)

for i = 1:len
    dec = double(char(inputString(i)));  % Convert character to its ASCII decimal value

    binVec = decToBinVec(dec, N);  % Convert decimal value to binary vector of length N
    
    if i == 1
        output = binVec;  % Initialize the output with the first binary vector
    else
        output = [output ; binVec];  % Append each subsequent binary vector to the output
    end
end
