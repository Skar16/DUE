%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 12.05.25
%
% symbolMapping(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = symbolMapping(inputVec,alphabet)

dimension = size(alphabet,1);

nBit = log2(dimension);

dimensionVec= length(inputVec);

output = 1;

for k = 1:2:dimensionVec

    bits = inputVec(k:k+1);
    count = bit2int(bits',nBit);
    mapped = alphabet(count+1);
    if k == 1
        output = mapped;
    else
        output(end+1) = mapped;
    end
end



