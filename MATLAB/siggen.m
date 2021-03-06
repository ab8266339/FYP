% Reference Signal
fs = 1e6;
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
ys1= [];
D = 480;%Deviation for the first carrier
idata = [];
qdata = [];
IQData=[]; 
Dc = 5e3; %Deviation for the second carrier
yc = [];
fc2=1e6;%carrier frequency 1MHz
idatac = [];
qdatac = [];
IQDatac=[]; 
for r = 1:length(t)

    % loop
    y(r) = sin(2*pi*30*t(r));
    ys(r) = cos(2*pi*(fc1+D*sin(2*pi*30*t(r)))*t(r)); %subcarrier contain 180 phase-shifed ref sig
    ys2(r) = cos(2*pi*fc1*t(r)+((D/fc1)*sin(2*pi*30*t(r))));
    ys1(r) = sin(2*pi*30*(t(r)))*ys(r);%frequency mixer 30Hz ref with 180 degree phase shift and ys
    yc(r) = cos(2*pi*(fc2+Dc*ys1(r))*t(r)); %carrier 
    idatac(r)=sin(2*pi*fc2*t(r))*yc(r);
    qdatac(r)=cos(2*pi*fc2*t(r))*yc(r);
    IQDatac(r)=idatac(r)+j.*qdatac(r);
    idatasc(r)=sin(2*pi*fc2*t(r))*ys(r);
    qdatasc(r)=cos(2*pi*fc2*t(r))*ys(r);
    IQDatasc(r)=idatasc(r)+j.*qdatasc(r);
    %IQDatac(r)=sin(2*pi*yc(r))+j.*cos(2*pi*yc(r));
end
bin = fs/length(t);
xaxis = 0:bin:bin*(length(t)-1);
IQdatacLowpass=doFilter(IQDatac);
figure(2)
plot(xaxis,abs(fft(ys)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM-FFT subcarrier Spectrum')
figure(3)
 plot(t,real(IQDatac))
xlabel('Time (sec)')
ylabel('Amplitude')
title('FM carrier IQ wavefrom')
figure(4)
plot(xaxis,abs(fft(IQDatac)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM carrier(IQ)-FFT Spectrum')
figure(5)
plot(xaxis,abs(fft(yc)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM-FFT carrier Spectrum')
%wave = [real(IQDatas);imag(IQDatas)];
% wave = wave(:)';    % transpose the waveform
figure(6)
plot(xaxis,abs(fft(IQdatacLowpass)))
xlabel('Frequency')
ylabel('Amplitude')
title('FM-FFT IQdataLowpass Spectrum')
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

% csvwrite('IQdata.dat',IQdataLowpass) %for subcarrier at 996

