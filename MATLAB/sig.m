% Reference Signal
fs = 99600;
t = 0:1/fs:0.1;

x1 = sin(2*pi*30*t);

y1=cos(x1+9960);

x2 = sin(2*pi*30*t+30*pi/180);

% plot(t,x1)
figure(1)
axis([0 0.1 -1 1])

xlabel('Time (sec)')

ylabel('Amplitude')

title('Sine Periodic Wave')

% y1=modulate(x1,9960,2e5,'fm',480)
plot(t,y1)
xlabel('Time (sec)')

ylabel('Amplitude')

title('FM sine Wave')
% % % % % % % % % % % % 
% Subcarrier


fs=9960;
ys = [];
D = 480;
idata = [];
qdata = [];
IQData=[]; 
Dc = 5e3;
yc = [];
fsc = 108e7;
fc=108e6;
idatac = [];
qdatac = [];
IQDatac=[]; 
for r = 1:length(t)

    % loop

    ys(r) = cos(2*pi*(fs+D*cos(2*pi*30*t(r)))*t(r)); %subcarrier
    yc(r) = cos(2*pi*(fsc+Dc*ys(r))*t(r)); %carrier
    idata(r)=sin(ys(r));
    qdata(r)=cos(ys(r));
    IQDatas(r)=idata(r)+j.*qdata(r);
    IQDatac(r)=sin(yc(r))+j.*cos(yc(r));
end

figure(2)
plot(t,abs(fft(ys)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM-FFT subcarrier Spectrum')
figure(3)
 plot(t,IQDatas)
xlabel('Time (sec)')
ylabel('Amplitude')
title('FM subcarrier sine Wave IQ from')
figure(4)
plot(t,abs(fft(IQDatas)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM subcarrier(IQ)-FFT Spectrum')
wave = [real(IQDatas);imag(IQDatas)];
% wave = wave(:)';    % transpose the waveform


% % % % % % % % % 
% Carrier
figure(5)
plot(t,abs(fft(yc)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM-FFT carrier Spectrum')
figure(3)
 plot(t,IQDatac)
xlabel('Time (sec)')
ylabel('Amplitude')
title('FM carrier sine Wave IQ from')
figure(4)
plot(t,abs(fft(IQDatac)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM carrier(IQ)-FFT Spectrum')
wave = [real(IQDatac);imag(IQDatac)];