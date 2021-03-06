%Baseband Generator
fcfm=1e4;%secondary carrier used for fm
fcam=1e4;%secondary carrier used for am
fs = 5e4;%sampling rate
t = 0:1/fs:2;%signal length
D = 480;%Deviation for the first carrier
Dc = 5e3; %Deviation for the second carrier
fc2=1e6;%Primary carrier frequency 1MHz (Not in use)
bin = fs/length(t);
xaxis = 0:bin:bin*(length(t)-1);
%%%%%%%%%IQ baseband%%%%%%%%
yc = [];
ys = [];
idata = [];
qdata = [];
IQData=[]; 
for r = 1:length(t)

    % loop
    y(r) = sin(2*pi*30*t(r));
    ys(r) = cos(2*pi*(fcfm+D*y(r)))*t(r); %subcarrier contain ref sig
    %yc(r) = cos(2*pi*(fc2+Dc*ys(r))*t(r)); %carrier 
    idata(r)=sin(2*pi*fcfm*t(r))*ys(r);
    qdata(r)=cos(2*pi*fcfm*t(r))*ys(r);
    IQData(r)=idata(r)+j.*qdata(r);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The signal generator using MATLAB function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yofm = fmmod(y,fcfm,fs,D);% yo is omnidirectional
yofmdemod=fmdemod(yofm,fcfm,fs,D);%fmdemod is the demodulator
yd=sin(2*pi*30*t+degtorad(90));%yd is directional
ydam=ammod(yd,fcam,fs);%am modulator
yfinal=yofm+ydam;%yfinal is the final product after sinal mixing
yfinalamdemod=amdemod(yfinal,fcam,fs);%am demodulator
yfinalfmdemod=fmdemod(yfinal,fcfm,fs,480);%fm demodulator
yfinalamdemodfilter=filter30hz(yfinalamdemod);%30 Hz Low-pass Filter
yfinalfmdemodfilter=filter30hz(yfinalfmdemod);%30 Hz Low-pass Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%
%Figure ploting
%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(211)
plot(t,yfinalamdemod,t,yfinalfmdemod);
title('fmdemod and amdemod in Time Domain');
legend('amdemod','fmdemod')
subplot(212)
plot(xaxis,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalfmdemod)));
title('fmdemod and amdemod in Frequency Domain');
legend('amdemod','fmdemod')
figure(2)
plot(t,yd,t,y)
title('y and ydirectional');
legend('directional','ref');
figure(3)
plot(t,yfinalamdemod,t,yfinalamdemodfilter);
figure(4)
plot(xaxis,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalamdemodfilter)))
title('fft of yamdemod and yamdemod with filter');
figure(5)
plot(t,yfinalamdemod,t,yfinalamdemodfilter);
title('yamdemod compare yamdemodfilter');
legend('amdemod','amdemodfliter')
figure(6)
plot(t,yd,t,y,t,yfinalamdemod,t,yfinalfmdemod)
title('yd y compare yamdemod yfmdemod');
legend('yd','y','yam','yfm');
figure(7)
plot(t,yd,t,y,t,yfinalamdemodfilter,t,yfinalfmdemodfilter)
title('yd y compare yamdemodfilter yfmdemodfilter');
legend('yd','y','yamf','yfmf');
figure(8)
plot(xaxis,abs(fft(yfinal)))
title('Spectrum of Baseband signal');
figure(9)
plot(t,yfinal)
title('Waveform of Baseband signal');
figure(10)
subplot(221)
plot(t,ydam);
title('ydam in Time Domain');
subplot(222)
plot(t,yofm);
title('yofm in Time Domain');
subplot(223)
plot(xaxis,abs(fft(ydam)))
title('ydam in Frequency Domain');
subplot(224)
plot(xaxis,abs(fft(yofm)))
title('yofm in Frequency Domain');
figure(11)
subplot(211)
plot(t,yfinalamdemodfilter,t,yfinalfmdemodfilter);
title('amdemodfiltered and fmdemodfiltered in Time Domain');
legend('amdemodfilter','fmdemodfilter')
subplot(212)
plot(xaxis,abs(fft(yfinalamdemodfilter)),xaxis,abs(fft(yfinalfmdemodfilter)));
title('amdemodfiltered and fmdemodfiltered in Frequency Domain');
legend('amdemodfilter','fmdemodfilter')
