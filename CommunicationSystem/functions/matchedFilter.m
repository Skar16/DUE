%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 14.05.25
%
% matchedFilter(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = matchedFilter(inputVec,h,binVec,Nsam)


binVec = upsample(binVec,Nsam);

filterOutput2_r = conv(real(inputVec),h(2,:),'same');
filterOutput2_i = conv(imag(inputVec),h(2,:),'same');

filterOutput2 = filterOutput2_r + 1i * filterOutput2_i;

figure(3);


x = 1:length(filterOutput2);
subplot(2,1,2);
plot(x,filterOutput2_r,LineWidth=1);
x2 = 1:length(real(binVec));
hold on;
stem(x2,real(binVec));
hold off;
grid on;


% figure(15);
% cache = reshape(filterOutput2_r,2*Nsam, []);
% plot(cache);


symbols_r = 1;
symbols_i = 1;

for k = 1:Nsam:length(filterOutput2_r)
    if k == 1
        symbols_r = filterOutput2_r(k);
    else
        symbols_r(end+1) = filterOutput2_r(k);
    end

end
for k = 1:Nsam:length(filterOutput2_i)
    if k == 1
        symbols_i = filterOutput2_i(k);
    else
        symbols_i(end+1) = filterOutput2_i(k);
    end

end

symbols_r = upsample(symbols_r,Nsam);
symbols_i = upsample(symbols_i,Nsam);
symbols = symbols_r + symbols_i * 1i;

symbols_rounded = round(symbols);



figure(5);
plot(filterOutput2_r);
hold on;
stem(symbols_r);
stem(real(symbols_rounded));
grid on;
legend('filterOutput','symbols','rounded symbols');
hold off;

symbols_rounded = downsample(symbols_rounded,Nsam); % upsampled for plot



output = symbols_rounded;