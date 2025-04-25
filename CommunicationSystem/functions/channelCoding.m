%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 22.04.25
%
% 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = channelCoding(binVec)

dimension = size(binVec);

output = 0;
parityRow = 0;
parityCol = 0;
N = 7;

for i = 1:N:dimension(1)
    cache = 0;
    cache = binVec(i:i+N-1,1:N);
    for k = 1:N
        parityRow(k) = mod(sum(cache(k,1:N)),2);
    end
    if i < 7
        parityRow = parityRow';
    end
        cache = [cache parityRow];
    for k = 1:N
        parityCol(k) = mod(sum(cache(1:N,k)),2);
    end
    parityCol(k+1) = mod(sum(parityRow),2);
    cache = [cache ; parityCol];
    if i == 1
        output = cache;

    else
        output = [output ; cache ];

    end
end