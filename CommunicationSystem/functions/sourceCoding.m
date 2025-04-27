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

% --- Variable Initialization ---
dimension = size(binVec);  % Get the dimensions of the input binary vector (rows and columns)

output = 0;                % Initialize output variable to store the final encoded binary vector
parityRow = 0;             % Initialize the parity row vector (stores calculated parity bits for rows)
parityCol = 0;             % Initialize the parity column vector (stores calculated parity bits for columns)
N = 7;                     % Set the block size: processing in 7x7 matrices

% --- Main Loop: Process the input block by block ---
% Loop over the input binary vector in steps of N rows
for i = 1:N:dimension(1)
    cache = 0;             % Initialize cache to temporarily hold the current block
    cache = binVec(i:i+N-1, 1:N);  % Extract a 7x7 block starting from row 'i' and columns 1 to N

    % --- Step 1: Calculate Row Parity ---
    % For each row of the block, compute a parity bit
    for k = 1:N
        parityRow(k) = mod(sum(cache(k, 1:N)), 2);  % Calculate sum of the row, take modulo 2
    end

    % Make sure parityRow is a column vector (only necessary for the first block)
    if i < 7
        parityRow = parityRow';
    end

    % Append the row parity bits as an additional column to the block
    cache = [cache parityRow];

    % --- Step 2: Calculate Column Parity ---
    % For each column of the extended block, compute a parity bit
    for k = 1:N
        parityCol(k) = mod(sum(cache(1:N, k)), 2);  % Calculate sum of the column, take modulo 2
    end

    % Calculate the overall parity bit (bottom-right corner of the block)
    % This is the parity of all row parities
    parityCol(k+1) = mod(sum(parityRow), 2);

    % Append the column parity bits (including overall parity) as an additional row
    cache = [cache ; parityCol];

    % --- Step 3: Construct Output ---
    % If this is the first processed block, initialize the output
    if i == 1
        output = cache;
    else
        % Otherwise, append the new block below the existing output
        output = [output ; cache];
    end
end
