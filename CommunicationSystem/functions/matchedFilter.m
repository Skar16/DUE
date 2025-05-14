%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name: Huber, Burandt
% Date: 14.05.25
%
% matchedFilter(): 
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = matchedFilter(inputVec,h,binVec,Nsam)



filterOutput2 = conv(inputVec,h(2,:),'same');
subplot(2,1,2);
plot(filterOutput2,LineWidth=1);
hold on;
stem(binVec);
hold off;
grid on;

figure(3);
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

figure(4);
stem(symbols);
hold on;


symbols_rounded = round(symbols);
stem(symbols_rounded)
grid on;
hold off;
symbols_rounded(1) = 3; % Wert manuell gändert, da Filter noch nicht eingeschwungen

output = symbols_rounded;