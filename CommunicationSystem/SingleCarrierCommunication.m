%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Name: SingleCarrierCommunication
% Author: Torben Burandt. Luis Huber
% Datum: 22/04/2024
% Case: Provides the messages that shall be sent via the Communication
% Carrier
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
close all;
addpath("functions/")

% Message(Source of communication) that shall be sent
msg = "This is a test message!";

out1 = decToBinVec(100,7)

old_msg = binVecToDec(out1)
char(old_msg) % now we have a char
