%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% channelCoding: selects N binary vectors and adds a parity column and a
%                parity row to enable error checking
%
% Input:    - binVec: fullsize binary vector
% Output:   - output: binary vector with added parity rows and columns 
% 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = channelCoding(binVec)

dimension = size(binVec);  % Get the size of the input binary vector

output = 0;                % Initialize output variable (will store the final result)
parityRow = 0;             % Initialize parity row (stores parity bits for each row)
parityCol = 0;             % Initialize parity column (stores parity bits for each column)
N = 7;                     % Block size (7x7) for processing

% Loop over the input binary vector in blocks of NxN
for i = 1:N:dimension(1)
    cache = 0;             % Initialize cache to temporarily hold a block
    cache = binVec(i:i+N-1,1:N);  % Select the current NxN block from the input

    % Calculate the parity bit for each row in the block
    for k = 1:N
        parityRow(k) = mod(sum(cache(k,1:N)),2);  % Sum the row and calculate modulo 2
    end

    % Ensure the parityRow is a column vector for the first block
    if i < 7
        parityRow = parityRow';
    end

    % Add the parity column to the right of the cache block
    cache = [cache parityRow];

    % Calculate the parity bit for each column (including the newly added parity column)
    for k = 1:N
        parityCol(k) = mod(sum(cache(1:N,k)),2);  % Sum the column and calculate modulo 2
    end

    % Calculate the final overall parity bit (for the new last column)
    parityCol(k+1) = mod(sum(parityRow),2);

    % Add the parity row (including overall parity bit) to the bottom of the cache block
    cache = [cache ; parityCol];

    % If this is the first block, initialize output
    if i == 1
        output = cache;
    else
        % Otherwise, concatenate the new block to the existing output
        output = [output ; cache];
    end
end
