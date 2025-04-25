%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Single Carrier Communication
% Name: Huber, Burandt
% Datum: 22.04.25
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
close all
%addpath('functions\');
%% Definieren Sie eine Nachricht, 
% die versendet werden soll:
msg = 'Hallo hier ist eine wichtige Nachricht!';
% Diese Nachricht stellt die Quelle für unsere Kommunikation dar.

nBit = 7;       % Anzahl an Bits

len = length(msg);  % Anzahl der Zeichen der Nachricht
modulo = mod(len,nBit); % Vielfaches der Anzahl an Bits

% Auffüllen der Nachricht mit '*', um ein Vielfaches der Anzahl an Bits zu
% bekommen
if modulo > 0
    for i = 1:(nBit-modulo)
        msg = append(msg,'*');
    end
end

binVec = sourceCoding(msg); % Quellkodierung

% decodedMsg = sourceDecoding(binVec); % Test, ob Quellkodierung geklappt hat

binVec = channelCoding(binVec); % Kanalkodierung

errorsDet = 0;  % Anzahl an Fehlern die erkannt wurden

errorsCor = 0;  % Check ob ein Fehler korrigiert wurde

[binVec2, errorsDet, errorsCor] = channelDecoding(binVec)
