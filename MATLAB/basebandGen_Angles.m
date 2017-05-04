%Baseband Generator
fcfm=1e4;%secondary carrier used for fm
fcam=1e4;
fs = 5e4;%sampling rate
t = 0:1/fs:0.5;%signal length
D = 480;%Deviation for the first carrier
Dc = 5e3; %Deviation for the second carrier
fc2=1e6;%Primary carrier frequency 1MHz (Not in use)
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
yfinal=yofm+ydam;%yfinal is the final product after sinal mixing
yfinalamdemod=amdemod(yfinal,fcam,fs);
yfinalfmdemod=fmdemod(yfinal,fcfm,fs,D);
yfinalamdemodfilter=filter30hz(yfinalamdemod);
yfinalfmdemodfilter=filter30hz(yfinalfmdemod);

figure(1)
plot(t,yfinalamdemod,t,yfinalfmdemod);
title('fmdemod and amdemod');
legend('amdemod','fmdemod');
figure(2)
plot(t,yd,t,y)
title('y and ydirectional');
legend('directional','ref');
% figure(3)
% plot(t,yfinalamdemod,t,yfinalamdemodfilter);
figure(5)
plot(t,yfinalamdemod,t,yfinalamdemodfilter);
title('yamdemod compare yamdemodfilter');
legend('amdemod','amdemodfliter')
figure(7)
plot(t,yd,t,y,t,yfinalamdemodfilter,t,yfinalfmdemodfilter)
title('yd y compare yamdemodfilter yfmdemodfilter');
legend('yd','y','yamf','yfmf');

