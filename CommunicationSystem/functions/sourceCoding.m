%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% sourceCoding: converts the full string into a matrix with bitvectors for
% each character
% 
% Input: - inputString: string to be coded
% Output: - output: 
%
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = sourceCoding(inputString)

len = length(inputString);

N = 7;

for i = 1:len
    
    dec = double(char(inputString(i)));

    binVec = decToBinVec(dec,N);
    
    if i == 1
        output = binVec;
    else
        output = [output ; binVec];
    end

end




