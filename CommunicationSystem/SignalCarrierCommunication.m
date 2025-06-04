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
% addpath('functions\');
% Define a message 
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

% for i = 1:numRows
%    chunk = binVec2(i,:);
%    decodedMsg(i) = binVecToDec(chunk);
% end

%alphabet = [-3 ;-1; 1; 3]; % aplhabet for mapping

% 16-QAM Alphabet (Gray sortiert erwartet)
re = [-3 -1 1 3];
im = [-3; -1; 1; 3];
alphabet = reshape(re + 1i * im, [], 1);  % Zeilenweise sortiert (Gray-kodiert vorausgesetzt)

binVec = symbolMapping(binVec,alphabet);

Nsam = 8;

[filterOutput,h] = pulseformFilter(binVec,Nsam);

f_sa = 48000; % sample frequency 48kHz
f_c = 10000;   % carrier frequency 10kHz

spektrum = abs(fftshift(fft(filterOutput)));
f = (-length(filterOutput)/2:length(filterOutput)/2-1)/length(filterOutput) * f_sa;

figure('Name',"Komplexes Signal nach dem Pulsformfilter");
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


%% backpath

% Prepare audio devices
dac = audioDeviceWriter(f_sa,"Device",'Speakers (USB Audio CODEC )');
microphoneID = audiodevinfo(1,'Microphone (USB Audio CODEC )'); 
adc = audiorecorder(f_sa,16,1,microphoneID);

adc.record();
disp('Start')
pause(2)

dac.play([zeros(10000,1); s_TX_ampd'; zeros(10000,1)]);

pause(2)
disp('Stop')
adc.stop();
s_RX = adc.getaudiodata()';

figure(10);
plot(s_RX');

s_RX = s_RX(:,151700:153800);

figure(11);
plot(s_RX');


s_p = demodulation(s_RX,f_c,f_sa);

% add noise:
% P_N = 1;
% s_RX = s_TX_ampd + P_N * randn(size(s_TX_ampd));
% s_p = demodulation(s_RX,f_c,f_sa);



s_p_spek = abs(fftshift(fft(s_p)));

f2 = (-length(s_p)/2:length(s_p)/2-1)/length(s_p) * f_sa;

figure(4);
subplot(3,1,3);
plot(f2,s_p_spek);
title("Betragspektrum des Basisbandsignals");
grid on;


% now matchedFilter
symbols_rounded = matchedFilter(s_p,h,binVec,Nsam);

figure(6);
scatter(real(output), imag(output), 'filled');
grid on;
axis equal;
xlabel('Re-Achse');
ylabel('Im-Achse');
title('Konstellationsdiagramm nach dem Kanal');

%
binVec = symbolDemapping(symbols_rounded,alphabet);

errorsDet = 0;  % Number of errors that were detected

errorsCor = 0;  % Check whether an error was corrected

[binVec2, errorsDet, errorsCor] = channelDecoding(binVec);
numRows = size(binVec2, 1); %number of rows

decodedMsg = sourceDecoding(binVec2); % Test whether source coding worked


