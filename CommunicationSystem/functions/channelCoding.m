%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Torben Burandt, Luis Huber
% Date: 22/04/2024
%
% channelCoding: converts binary vector to decimal
%
% Input: - binVec: bin vector(7 long)
% Output: - decOut: decimal value of binary vector
% Example: decToBinVec(0 0 0 1 1 0 0) yields: 12
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [partiy_mat] = channelCoding(binMat)

N = 7;

% Split Nx7 Matrix into 7x7 

% matrix col and row
[rows, cols] = size(binMat)

% how many chunks are needed
num_chunks = ceil(rows/N);

% TODO split matrix into chunks of 7x7 and fill missing rows with * if not
% factor of 7 
row_fill = 42* ones(1.7) % fill missing rows with '*' 

for i= 1:num_chunks
    start_idx = (i-1)*7+1;
    end_idx = min(i*7, rows);

    chunk = M(start_idx,end_idx, :);

    if size(chunk, 1) <7
        pad_size = 7 - size(chunk,1);
        chunk= [ chunk;repmat(row_fill, pad_size, 1)];
    end

% row parity, sum over colum with 7x7 * 7*x
row_parity = mod(chunk * ones(7,1), 2);

% colum parity, sum over row with 1x7 * 7x7
col_parity = mod(ones(1,7) * chunk, 2);

% bottom right parity
corner_parity = mod(sum(row_parity), 2);

% Assemble final 8x8 matrix
binMat_partiy = [chunk, row_parity];              % Append row parity bits
binMat_partiy = [binMat_partiy; [col_parity, corner_parity]]; % Append col parity bits + corner bit

partiy_mat{i} = binMat_partiy;

%disp(binMat_partiy)
    end
end

