%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 04.06.25
%
% demodulation(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = demodulation(inputVec,f_c,f_sa)

t = (0:length(inputVec)-1)/f_sa;

f = (-length(inputVec)/2:length(inputVec)/2-1)/length(inputVec) * f_sa;

cosine = cos(2*pi * f_c * t);

sine = -sin(2*pi *f_c * t);

s_p_r = inputVec .*cosine;

s_p_i = inputVec .* sine;

s_p = s_p_r + 1i .* s_p_i;


output = s_p;