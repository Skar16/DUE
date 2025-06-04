%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 04.06.25
%
% modulation(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = modulation(inputVec,f_c,f_sa)

t = (0:length(inputVec)-1)/f_sa;

cosine = cos(2*pi * f_c * t);

sine = -sin(2*pi *f_c * t);


s_TX_r = real(inputVec) .* cosine;

s_TX_i = imag(inputVec) .* sine;

s_TX = s_TX_r + s_TX_i;


output = s_TX;


