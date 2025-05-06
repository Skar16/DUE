function [partiy_mat] = channelDecoding()
%CHANNELDECODING Summary of this function goes here
%   Detailed explanation goes here

function decodedText = decodeParityMatrices(matrices)
    % matrices: cell array {N} of 8x8 matrices
    % decodedText: output string from decoded ASCII values

    numMatrices = numel(matrices);
    decodedText = '';  % Initialize result string

    for k = 1:numMatrices
        currentMatrix = matrices{k};

        if ~isequal(size(currentMatrix), [8 8])
            error('Matrix %d is not 8x8.', k);
        end

        dataMatrix = currentMatrix(1:7,1:7);  % Extract data bits
        
        % Check row parities (rows 1-7)
        for i = 1:7
            rowSum = sum(currentMatrix(i,1:7));
            expectedParity = mod(rowSum,2);
            if expectedParity ~= currentMatrix(i,8)
                warning('Parity error in row %d of matrix %d', i, k);
            end
        end

        % Check column parities (columns 1-7)
        for j = 1:7
            colSum = sum(currentMatrix(1:7,j));
            expectedParity = mod(colSum,2);
            if expectedParity ~= currentMatrix(8,j)
                warning('Parity error in column %d of matrix %d', j, k);
            end
        end

        % Check overall parity (bottom-right corner)
        totalSum = sum(dataMatrix,'all');
        expectedOverallParity = mod(totalSum,2);
        if expectedOverallParity ~= currentMatrix(8,8)
            warning('Overall parity error in matrix %d', k);
        end

        % Now convert the 7x7 bits into characters (one character per row)
        for i = 1:7
            charBits = dataMatrix(i, :);
            asciiValue = binVecToDec(charBits);  % 7-bit ASCII
            decodedText = [decodedText, char(asciiValue)];
        end
    end
end



end

