
fcfm=9960;%secondary carrier used for fm
fcam=1.54e9;
fs = 4e9;%sampling rate
t = 0:1/fs:0.01;%signal length
D = 480;%Deviation for the first carrier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bin = fs/length(t);
xaxis = 0:bin:bin*(length(t)-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = sin(2*pi*30*t);
yofm = fmmod(y,fcfm,fs,D);% y is omnidirectional
yofmdemod=fmdemod(yofm,fcfm,fs,D);
yd=sin(2*pi*30*t+degtorad(180));
ydam=ammod(yd,fcam,fs);
ydamdemod=amdemod(ydam,fcam,fs);
yfinal=yofm.*ydam;%yfinal is the final product after sinal mixing


figure(4)
plot(xaxis,abs(fft(yfinal)),xaxis,abs(fft(ydam)));
title('fft');

