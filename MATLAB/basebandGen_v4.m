%Baseband Generator
fcfm=1e4;%secondary carrier used for fm
fs = 5e4;%sampling rate
t = 0:1/fs:2;%signal length

ys = [];
D = 480;%Deviation for the first carrier
Dc = 5e3; %Deviation for the second carrier
yc = [];

fc2=1e6;%Primary carrier frequency 1MHz (Not in use)
fcam=1e4;
%%%%%%%%%IQ baseband%%%%%%%%
idata = [];
qdata = [];
IQData=[]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bin = fs/length(t);
xaxis = 0:bin:bin*(length(t)-1);
for r = 1:length(t)

    % loop
    y(r) = sin(2*pi*30*t(r));
    ys(r) = cos(2*pi*(fcfm+D*y(r)))*t(r); %subcarrier contain ref sig
    %yc(r) = cos(2*pi*(fc2+Dc*ys(r))*t(r)); %carrier 
    idata(r)=sin(2*pi*fcfm*t(r))*ys(r);
    qdata(r)=cos(2*pi*fcfm*t(r))*ys(r);
    IQData(r)=idata(r)+j.*qdata(r);

    %IQDatac(r)=sin(2*pi*yc(r))+j.*cos(2*pi*yc(r));
end
%%ys1 = y1.*ys;%frequency mixer 30Hz ref with 180 degree phase shift and ys
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ys_normalized=ys/sqrt(sum(abs(ys.^2))/fs); 
% IQdataLowpass=doFilter2(IQData);
yofm = fmmod(y,fcfm,fs,D);% y is omnidirectional
yofmdemod=fmdemod(yofm,fcfm,fs,D);
yd=sin(2*pi*30*t+degtorad(90));
ydam=ammod(yd,fcam,fs);
ydamdemod=amdemod(ydam,fcam,fs);
yfinal=yofm+ydam;%yfinal is the final product after sinal mixing
yfinalamdemod=amdemod(yfinal,fcam,fs);
yfinalfmdemod=fmdemod(yfinal,fcfm,fs,480);
yfinalamdemodfilter=filter30hz(yfinalamdemod);
yfinalfmdemodfilter=filter30hz(yfinalfmdemod);

figure(1)
subplot(211)
plot(t,yfinalamdemod,t,yfinalfmdemod);
title('fmdemod and amdemod in Time Domain');
legend('amdemod','fmdemod')
xlabel('Time(s)');
ylabel('Amplitude');
subplot(212)
plot(xaxis,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalfmdemod)));
title('fmdemod and amdemod in Frequency Domain');
legend('amdemod','fmdemod')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
figure(2)
plot(t,yd,t,y)
title('y and ydirectional');
legend('ref','directional');
xlabel('Time(s)')
ylabel('Amplitude')
figure(3)
plot(t,yfinalamdemod,t,yfinalamdemodfilter);
figure(4)
plot(xaxis,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalamdemodfilter)))
title('fft of yamdemod and yamdemod with filter');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
figure(5)
plot(t,yfinalamdemod,t,yfinalamdemodfilter);
title('yamdemod compare yamdemodfilter');
legend('amdemod','amdemodfliter')
xlabel('Time(s)');
ylabel('Amplitude');
figure(6)
plot(t,yd,t,y,t,yfinalamdemod,t,yfinalfmdemod)
title('yd y compare yamdemod yfmdemod');
legend('yd','y','yam','yfm');
xlabel('Time(s)');
ylabel('Amplitude');
figure(7)
plot(t,yd,t,y,t,yfinalamdemodfilter,t,yfinalfmdemodfilter)
title('yd y compare yamdemodfilter yfmdemodfilter');
legend('yd','y','yamf','yfmf');
xlabel('Time(s)');
ylabel('Amplitude');
figure(8)
plot(xaxis,abs(fft(yfinal)))
title('Spectrum of Baseband signal');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
figure(9)
plot(t,yfinal)
title('Waveform of Baseband signal');
xlabel('Time(s)');
ylabel('Amplitude');
figure(10)
subplot(221)
plot(t,ydam);
title('ydam in Time Domain');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(222)
plot(t,yofm);
title('yofm in Time Domain');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(223)
plot(xaxis,abs(fft(ydam)))
title('ydam in Frequency Domain');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
subplot(224)
plot(xaxis,abs(fft(yofm)))
title('yofm in Frequency Domain');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
figure(11)
subplot(211)
plot(t,yfinalamdemodfilter,t,yfinalfmdemodfilter);
title('amdemodfiltered and fmdemodfiltered in Time Domain');
legend('amdemodfilter','fmdemodfilter')
xlabel('Time(s)');
ylabel('Amplitude');
subplot(212)
plot(xaxis,abs(fft(yfinalamdemodfilter)),xaxis,abs(fft(yfinalfmdemodfilter)));
title('amdemodfiltered and fmdemodfiltered in Frequency Domain');
legend('amdemodfilter','fmdemodfilter')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
figure(12)
subplot(211)
plot(xaxis,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalfmdemod)));
title('amdemod and fmdemod in Frequency Domain');
legend('amdemod','fmdemod')
axis([0 360 0 6e4]);
xlabel('Frequency(Hz)');
ylabel('Amplitude');
subplot(212)
plot(xaxis,abs(fft(yfinalamdemodfilter)),xaxis,abs(fft(yfinalfmdemodfilter)));
title('amdemodfiltered and fmdemodfiltered in Frequency Domain');
legend('amdemodfilter','fmdemodfilter')
axis([0 360 0 7e3]);
xlabel('Frequency(Hz)');
ylabel('Amplitude');

