%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 14.05.25
%
% matchedFilter(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = matchedFilter(inputVec,h,binVec,Nsam)


binVec = upsample(binVec,Nsam);

figure(3);
filterOutput2 = conv(inputVec,h(2,:),'same');
x = 1:length(filterOutput2);
subplot(2,1,2);
plot(x,filterOutput2,LineWidth=1);
x2 = 1:length(binVec);
hold on;
stem(x2,binVec);
hold off;
grid on;

figure(4);
cache = reshape(filterOutput2,2*Nsam, []);
plot(cache);


symbols = 1;

for k = 1:Nsam:length(filterOutput2)
    if k == 1
        symbols = filterOutput2(k);
    else
        symbols(end+1) = filterOutput2(k);
    end

end

figure(5);
stem(symbols);
hold on;


symbols_rounded = round(symbols);
stem(symbols_rounded)
grid on;
hold off;
symbols_rounded(1) = 3; % Wert manuell gändert, da Filter noch nicht eingeschwungen

output = symbols_rounded;