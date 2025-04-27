%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% sourceDecoding: converts a matrix of bitvectors back into the original string
% 
% Input:    - binVec: matrix with bitvectors (each row represents one character)
% Output:   - decode: reconstructed string from the bitvectors
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function decode = sourceDecoding(binVec)

% --- Variable Initialization ---
dimension = size(binVec);   % Get the size of the input matrix (number of rows and columns)

N = 7;                      % Number of bits per character (7-bit ASCII encoding)

% --- Main Loop: Decode each bitvector ---
for i = 1:dimension(1)
    
    % Convert the i-th binary vector (row) into its decimal equivalent
    dec = binVecToDec(binVec(i,1:N));
    
    % Convert the decimal value into its corresponding character
    % and build the output string
    if i == 1
        decode = char(dec);            % Initialize decode with the first character
    else
        decode = append(decode, char(dec));  % Append subsequent characters
    end
    
end
