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

binVec = channelCoding(binVec); % Channel coding

% for i = 1:numRows
%    chunk = binVec2(i,:);
%    decodedMsg(i) = binVecToDec(chunk);
% end

alphabet = [-3 ;-1; 1; 3]; % aplhabet for mapping

binVec = symbolMapping(binVec,alphabet);

Nsam = 8;

% now pulseformFilter
% Nsym = 6;
% Nsam = 8;
% 
% alpha = [0.1 0.5 0.9];
% 
% for k = 1:length(alpha)
% 
% h(k,:) = rcosdesign(alpha(k),Nsym,Nsam,'sqrt');
% 
% h(k,:) = h(k,:)./sum(h(k,:));
% 
% end
% x1 = 1:length(h);
% figure(1);
% subplot(2,1,1);
% plot(x1,h(1,:),x1,h(2,:),x1,h(3,:));
% grid on;
% 
% H = zeros(1,128);
% 
% x2 = 1:length(H);
% 
% H(1,:) = fftshift(fft(h(1,:),128));
% H(2,:) = fftshift(fft(h(2,:),128));
% H(3,:) = fftshift(fft(h(3,:),128));
% 
% 
% subplot(2,1,2);
% plot(x2,abs(H(1,:)),x2,abs(H(2,:)),x2,abs(H(3,:)));
% grid on;
% 
% binVec = upsample(binVec,Nsam);
% 
% filterOutput = conv(binVec,h(2,:),'same') .*8;
% x3 = 1:length(filterOutput);
% 
% figure(2);
% subplot(2,1,1);
% plot(filterOutput,LineWidth=1);
% hold on;
% stem(binVec);
% hold off;
% grid on;
% 
% %noise = randn(1,length(filterOutput));
% 
% %filterOutput = filterOutput + noise;

[filterOutput,h] = pulseformFilter(binVec,Nsam);

% now matchedFilter
symbols_rounded = matchedFilter(filterOutput,h,binVec,Nsam);

% 
% filterOutput2 = conv(filterOutput,h(2,:),'same');
% subplot(2,1,2);
% plot(filterOutput2,LineWidth=1);
% hold on;
% stem(binVec);
% hold off;
% grid on;
% 
% figure(3);
% cache = reshape(filterOutput2,2*Nsam, []);
% plot(cache);
% 
% 
% symbols = 1;
% 
% for k = 1:Nsam:length(filterOutput2)
%     if k == 1
%         symbols = filterOutput2(k);
%     else
%         symbols(end+1) = filterOutput2(k);
%     end
% 
% end
% 
% figure(4);
% stem(symbols);
% hold on;
% 
% 
% symbols_rounded = round(symbols);
% stem(symbols_rounded)
% grid on;
% hold off;
% symbols_rounded(1) = 3; % Wert manuell gändert, da Filter noch nicht eingeschwungen


%%
binVec = symbolDemapping(symbols_rounded,alphabet);

errorsDet = 0;  % Number of errors that were detected

errorsCor = 0;  % Check whether an error was corrected

[binVec2, errorsDet, errorsCor] = channelDecoding(binVec);
numRows = size(binVec2, 1); %number of rows

decodedMsg = sourceDecoding(binVec2); % Test whether source coding worked


