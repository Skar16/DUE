%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% channelDecoding: 
%
% Input:    - binVec: binary vector 
% Output:   - output: 
%           - errorsDet: 
%           - errorsCor: 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output, errorsDet, errorsCor] = channelDecoding(binVec)

numBlocks = size(binVec,1) / 8;
if mod(numBlocks,1) ~= 0
    error('Input size must be a multiple of 8 rows');
end

errorsDet = 0;
errorsCor = 0;
output = [];


for k = 1:numBlocks
    block = binVec((k-1)*8+1:k*8,:); % extract 8x8 chunk, 0?

     % Check row parities (including the parity column)
    rowParityCheck = mod(sum(block(:,1:7), 2), 2);
    rowParityError = rowParityCheck ~= block(:,8);

  % Check column parities (including the parity row)
    colParityCheck = mod(sum(block(1:7,:), 1), 2);
    colParityError = colParityCheck ~= block(8,:);

    % Count number of errors in rows and columns
    numRowErrors = sum(rowParityError(1:7));
    numColErrors = sum(colParityError(1:7));



    if numRowErrors > 0 || numColErrors > 0
        errorsDet = errorsDet + 1;
    end

     % If one bit error, correct it
        if numRowErrors == 1 && numColErrors == 1
            rowIdx = find(rowParityError(1:7));
            colIdx = find(colParityError(1:7));
            block(rowIdx, colIdx) = mod(block(rowIdx, colIdx) + 1, 2); % flip bit
            errorsCor = errorsCor + 1;
        end

       % Append corrected data (7x7 block)
    output = [output; block(1:7,1:7)];
end

     % Pass concatenated data to binToDec function
    %output = binToDec(outputData);
end

