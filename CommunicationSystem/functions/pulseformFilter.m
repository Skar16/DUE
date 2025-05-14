%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 14.05.25
%
% pulseformFilter(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = pulseformFilter(inputVec)

Nsym = 6;
Nsam = 8;

alpha = 0.5;

h = rcosdesign(alpha,Nsym,Nsam,'sqrt');

