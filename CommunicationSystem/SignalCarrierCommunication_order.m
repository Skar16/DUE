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

% that should be transmitted:
msg = 'Erst hiernach wird es wirklich wichtig. Hallo hier ist eine wichtige Nachricht!';
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

binVec = channelCoding(binVec); % Channel coding

% 16-QAM Alphabet (Gray sortiert erwartet)
re = [-3 -1 1 3];
im = [-3; -1; 1; 3];
alphabet = reshape(re + 1i * im, [], 1);  % Zeilenweise sortiert (Gray-kodiert vorausgesetzt)

binVec = symbolMapping(binVec,alphabet);

Nsam = 8;
windup = [1 -1 1 -1 1 -1];
windup = windup + 1i*windup;
barkerCode = [1 1 1 1 1 -1 -1 1 1 -1 1 -1 1];
barkerCode = barkerCode +1i*barkerCode;
binVec = cat(2,barkerCode,binVec);
binVec = cat(2,windup,binVec);

% pulseformfilter
[filterOutput,h] = pulseformFilter(binVec,Nsam);

f_sa = 48000; % sample frequency 48kHz
f_c = 10000;   % carrier frequency 10kHz

spektrum = abs(fftshift(fft(filterOutput)));
f = (-length(filterOutput)/2:length(filterOutput)/2-1)/length(filterOutput) * f_sa;

figure(20);
subplot(3,1,1);
plot(f,spektrum);
title("Betragsspektrum des komplexen Signals nach dem Pulsformfilter");
grid on;

s_TX = modulation(filterOutput,f_c,f_sa);
s_TX_ampd = 2 .* s_TX;  % need the doubled amplitude so that it can matched in the match filter

s_TX_spek = abs(fftshift(fft(s_TX_ampd)));


subplot(3,1,2);
plot(f,s_TX_spek);
title("Betragsspektrum des Sendesignals nach der Modulation");
grid on;

%% Empfangsseite

% Prepare audio devices
dac = audioDeviceWriter(f_sa,"Device",'Speakers (6- USB Audio CODEC )');
microphoneID = audiodevinfo(1,'Microphone (5- USB Audio CODEC )'); 
adc = audiorecorder(f_sa,16,1,microphoneID);

adc.record();
disp('Start')
pause(2)

dac.play([zeros(10000,1); s_TX_ampd'./3; zeros(10000,1)]);

pause(2)
disp('Stop')
adc.stop();
s_RX = adc.getaudiodata()';

figure(10);
plot(s_RX');

% TODO Dynamic implementation
%s_RX = s_RX(:,152525:154188);
cache = [];
for n = 1:length(s_RX)
    if abs(s_RX(n))>=0.02
        cache =[cache s_RX(n)];
    end
end
s_RX = cache;

plus = mod(length(s_RX),16);
s_RX = [s_RX zeros(1,16-plus)];

figure(11);
plot(s_RX');

s_p = demodulation(s_RX*3,f_c,f_sa); %with audiochannel
%s_p = demodulation(s_TX_ampd,f_c,f_sa);  %without channel

s_p_spek = abs(fftshift(fft(s_p)));

f2 = (-length(s_p)/2:length(s_p)/2-1)/length(s_p) * f_sa;

figure(4);
subplot(3,1,3);
plot(f2,s_p_spek);
title("Betragspektrum des Basisbandsignals");
grid on;


% now matchedFilter 
%symbols_rounded = matchedFilter(s_p,h,binVec,Nsam);

% matchedfilter not rounded
symbols = matchedFilter(s_p,h,binVec,Nsam);


abs_symbols = abs(symbols);


% figure(6);
% scatter(real(symbols_rounded), imag(symbols_rounded), 'filled');
% grid on;
% axis equal;
% xlabel('Re-Achse');
% ylabel('Im-Achse');
% title('Konstellationsdiagramm nach dem Kanal');

figure(6);
subplot(2,1,1);
scatter(real(symbols), imag(symbols), 'filled');
grid on;
axis equal;
xlabel('Re-Achse');
ylabel('Im-Achse');
title('Konstellationsdiagramm nach dem Kanal');

f_bp = f_sa *1/Nsam;
N_bp = 16;
n = 0:(N_bp-1);
h_bp = cos(2*pi*1/Nsam*n);

% hier faltung mit bandpass
symbols_bp = conv(abs_symbols,h_bp);

% hier pll
alpha = 0.99;
k = 10;
symbols_pll = pll(symbols_bp,Nsam,alpha,k);
symbols_pll_sign = sign(symbols_pll);

figure(722);
subplot(2,1,1);
plot(symbols_pll_sign);
hold on;
plot(real(symbols));
legend('Symboltakt','Matched Filter Ausgang Realteil');
grid on;
subplot(2,1,2);
plot(symbols_pll_sign);
hold on;
plot(imag(symbols));
legend('Symboltakt','Matched Filter Ausgang Imaginärteil');
grid on;


symbols_sampled = [];
for n = 1:length(symbols)-1
    if (symbols_pll_sign(n)==1) && (symbols_pll_sign(n+1)==-1)
        symbols_sampled = [symbols_sampled, symbols(n)];
    end
end

figure(723);
plot(real(symbols_sampled));
hold on;
plot(imag(symbols_sampled));


x_korr_r = conv(real(sign(symbols_sampled)),fliplr(real(barkerCode)));  % verwendung der faltungsfunktion für die Kreuzkorrrelation (siehe DV)
x_korr_i = conv(imag(sign(symbols_sampled)),fliplr(imag(barkerCode)));
%x_korr_r = xcorr(real(sign(symbols_sampled)),real(barkerCode));
%x_korr_i = xcorr(imag(sign(symbols_sampled)),imag(barkerCode));

figure(724);
plot(x_korr_r);
hold on;
plot(x_korr_i);

[x,maxIndex_r] = max(abs(x_korr_r));    
[x,maxIndex_i] = max(abs(x_korr_i));    

barkerCode_after_r = real(symbols_sampled(maxIndex_r:(maxIndex_r+length(barkerCode)-1)));
barkerCode_after_i = imag(symbols_sampled(maxIndex_i:(maxIndex_i+length(barkerCode)-1)));

faktor_r = real(barkerCode)/barkerCode_after_r;
faktor_i = imag(barkerCode)/barkerCode_after_i;
faktor = faktor_r +1i*faktor_i;
faktor_mid = mean(f);

symbols_sampled_eq = zeros(1,length(symbols_sampled));
symbols_sampled_eq = faktor.*symbols_sampled;


figure(6);
subplot(2,1,2);
scatter(real(symbols_sampled_eq), imag(symbols_sampled_eq), 'filled');
grid on;
axis equal;
xlabel('Re-Achse');
ylabel('Im-Achse');
title('Konstellationsdiagramm nach dem Kanal und entzerrt');


%
binVec = symbolDemapping(symbols_rounded,alphabet);

errorsDet = 0;  % Number of errors that were detected

errorsCor = 0;  % Check whether an error was corrected

[binVec2, errorsDet, errorsCor] = channelDecoding(binVec);
numRows = size(binVec2, 1); %number of rows

decodedMsg = sourceDecoding(binVec2); % Test whether source coding worked


function [output] = pll(input,Nsam,alpha,k)

    N = length(input);
    output = zeros(N,1);
    phaseError = 0;
    phaseError_mean = 0;
    for n=1:N
        output(n) = cos(2*pi*n/Nsam + phaseError_mean * k);
        phaseError = output(n) * input(n);
        phaseError_mean = alpha * phaseError_mean + (1-alpha) * phaseError;
    end
end


