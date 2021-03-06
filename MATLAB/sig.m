% Reference Signal
fs = 108e7;
t = 0:1/fs:0.1;
% 
% x1 = sin(2*pi*30*t);
% 
% y1=cos(x1+9960);
% 
% x2 = sin(2*pi*30*t+30*pi/180);

% plot(t,x1)
% figure(1)
% axis([0 0.1 -1 1])
% 
% xlabel('Time (sec)')
% 
% ylabel('Amplitude')
% 
% title('Sine Periodic Wave')

% y1=modulate(x1,9960,2e5,'fm',480)
% plot(t,y1)
% xlabel('Time (sec)')
% 
% ylabel('Amplitude')
% 
% title('FM sine Wave')
% % % % % % % % % % % % 
% Subcarrier


fc1=9960;
ys = [];
D = 480;%Deviation for the first carrier
idata = [];
qdata = [];
IQData=[]; 
Dc = 5e3; %Deviation for the second carrier
yc = [];
fc2=108e6;
idatac = [];
qdatac = [];
IQDatac=[]; 
for r = 1:length(t)

    % loop

    ys(r) = cos(2*pi*(fc1+D*cos(2*pi*30*t(r)))*t(r)); %subcarrier
    yc(r) = cos(2*pi*(fc2+Dc*ys(r))*t(r)); %carrier
    idata(r)=sin(2*pi*fc2*t(r))*yc(r);
    qdata(r)=cos(2*pi*fc2*t(r))*yc(r);
    IQData(r)=idata(r)+j.*qdata(r);
    %IQDatac(r)=sin(2*pi*yc(r))+j.*cos(2*pi*yc(r));
end

figure(2)
plot(t,abs(fft(ys)))
xlabel('Frequency bins')
ylabel('Amplitude')
title('FM-FFT subcarrier Spectrum')
figure(3)
 plot(t,real(IQData))
xlabel('Time (sec)')
ylabel('Amplitude')
title('FM carrier sine Wave IQ from')
figure(4)
plot(t,abs(fft(IQData)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM carrier(IQ)-FFT Spectrum')
figure(5)
plot(t,abs(fft(yc)))
xlabel('Frequency bins')
ylabel('Amplitude')
title('FM-FFT carrier Spectrum')
%wave = [real(IQDatas);imag(IQDatas)];
% wave = wave(:)';    % transpose the waveform


% % % % % % % % % 
% Carrier
% figure(5)
% plot(t,abs(fft(yc)))
% xlabel('Frequency')
% ylabel('Amplitude')
% title('FM-FFT carrier Spectrum')
% figure(3)
%  plot(t,IQDatac)
% xlabel('Time (sec)')
% ylabel('Amplitude')
% title('FM carrier sine Wave IQ from')
% figure(4)
% plot(t,abs(fft(IQDatac)))
% xlabel('Frequency')
% ylabel('Amplitude')
% title('FM carrier(IQ)-FFT Spectrum')
% wave = [real(IQDatac);imag(IQDatac)];