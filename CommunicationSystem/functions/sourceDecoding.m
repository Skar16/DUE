%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function decode = sourceDecoding(binVec)

dimension = size(binVec);

N = 7;

for i = 1:dimension(1)

    dec = binVecToDec(binVec(i,1:N));
    if i == 1
        decode = char(dec);
    else
        decode = append(decode,char(dec));
    end
end

