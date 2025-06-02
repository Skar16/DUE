%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% symbolDemapping - Wandelt Symbole aus dem Alphabet wieder in Bits um.
%
% INPUTS:
%   inputVec : Vektor mit Symbolen (reell oder komplex)
%   alphabet : Vektor oder Matrix mit Symbolen (muss zu Gray-Code passen!)
%
% OUTPUT:
%   output : Bitvektor (1xN)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function output = symbolDemapping(inputVec, alphabet)

    % Anzahl Bits pro Symbol
    dimension = numel(alphabet);
    nBit = log2(dimension);
    
    if mod(nBit,1) ~= 0
        error('Alphabetgröße ist keine Zweierpotenz.');
    end

    output = [];

    for k = 1:length(inputVec)
        symbol = inputVec(k);

        % Numerisch stabiler Vergleich: geringster Abstand zum Alphabet
        [~, index] = min(abs(alphabet - symbol));  % robust auch für komplexe Zahlen

        % Gray -> Binär rückwandeln
        grayVal = index - 1;
        binVal = gray2bin(grayVal);

        % Binärzahl → Bitvektor (nBit Länge, MSB zuerst)
        bits = de2bi(binVal, nBit, 'left-msb');

        output = [output bits];
    end
end

% Hilfsfunktion: wandelt Gray-Code in Binärzahl (Integer)
function bin = gray2bin(gray)
    bin = gray;
    while gray > 0
        gray = bitshift(gray, -1);
        bin = bitxor(bin, gray);
    end
end

