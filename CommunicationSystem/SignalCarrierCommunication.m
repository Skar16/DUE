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
%% Define a message 
% that should be transmitted:
msg = 'Hallo hier ist eine wichtige Nachricht!';
% This message represents the source for our communication.

nBit = 7;       % Number of bits

len = length(msg);  % Number of characters in the message
modulo = mod(len,nBit); % Multiple of the number of bits

% Padding the message with '*', to make it a multiple of the number of bits
if modulo > 0
    for i = 1:(nBit-modulo)
        msg = append(msg,'*');
    end
end

binVec = sourceCoding(msg); % Source coding

% decodedMsg = sourceDecoding(binVec); % Test whether source coding worked

binVec = channelCoding(binVec); % Channel coding

errorsDet = 0;  % Number of errors that were detected

errorsCor = 0;  % Check whether an error was corrected

[binVec2, errorsDet, errorsCor] = channelDecoding(binVec);
