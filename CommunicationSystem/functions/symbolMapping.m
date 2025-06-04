%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% symbolMapping - Mapped binäre Eingabedaten auf Symbole aus dem gegebenen Alphabet.
%
% INPUTS:
%   inputVec : Binärvektor (1xN) aus Kanalcodierung
%   alphabet : Vektor oder Matrix mit Symbolen (reell oder komplex)
%
% OUTPUT:
%   output : Symbolvektor (reell oder komplex)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = symbolMapping(inputVec, alphabet)

    % Alphabet-Größe
    dimension = numel(alphabet); 
    
    % Bits pro Symbol
    nBit = log2(dimension);
    
    if mod(length(inputVec), nBit) ~= 0
        error('Die Anzahl der Eingangsbits ist kein Vielfaches der Bitanzahl pro Symbol.');
    end
    
    % Erzeuge Gray-Code-Tabelle
    grayCodes = bitxor((0:dimension-1), floor((0:dimension-1)/2));
    output = zeros(1, length(inputVec)/nBit);  % Output initialisieren
    
    % Mapping
    for idx = 1:nBit:length(inputVec)
        bits = inputVec(idx:idx+nBit-1);
        intVal = bi2de(bits, 'left-msb');
        grayVal = bitxor(intVal, floor(intVal/2));  % Gray-Kodierung
        symbol = alphabet(grayVal + 1);
        output((idx-1)/nBit + 1) = symbol;
    end

    % Wenn komplex, Konstellationsdiagramm plotten
    if ~isreal(alphabet)
        figure(1);
        scatter(real(output), imag(output), 'filled');
        grid on;
        axis equal;
        xlabel('In-Phase');
        ylabel('Quadratur');
        title('Konstellationsdiagramm (SymbolMapping)');
    end
end
