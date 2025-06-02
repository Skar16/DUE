%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 12.05.25
%
% symbolDemapping(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = symbolDemapping(inputVec,alphabet)

nBit = log2(size(alphabet,1));

output = 1;

for k = 1:length(inputVec)

    mapped = inputVec(k);
    index = find(alphabet == mapped);
    bits = int2bit(index-1,nBit);

    if k == 1
        output = bits';
    else
        output(end+1:end+2) = bits';
    end
end


