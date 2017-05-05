
fcfm=9960;%secondary carrier used for fm
fcam=108e6;
fs = 400e6;%sampling rate
t = 0:1/fs:0.1;%signal length
D = 480;%Deviation for the first carrier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bin = fs/length(t);
xaxis = 0:bin:bin*(length(t)-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_ref = sin(2*pi*30*t);
y_ref_fm = fmmod(y_ref,fcfm,fs,D);% y is omnidirectional
y_ref_fm_demod=fmdemod(y_ref_fm,fcfm,fs,D);
y_directional=sin(2*pi*30*t+degtorad(180));
y_d_am=ammod(y_directional,fcam,fs);
%y_d_am_demod=amdemod(y_d_am,fcam,fs);
yfinal=y_ref_fm+y_d_am;%yfinal is the final product after sinal mixing


figure(1)
plot(xaxis,abs(fft(yfinal)));
title('fft');

% figure(2)
% plot(xaxis,abs(fft(y_d_am)));
% title('fft');