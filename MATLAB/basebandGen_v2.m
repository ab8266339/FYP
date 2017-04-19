%Baseband Generator
fs = 1e6;%sampling rate
t = 0:1/fs:0.1;%signal length

ys = [];
D = 480;%Deviation for the first carrier
Dc = 5e3; %Deviation for the second carrier
yc = [];
fc1=9000;%secondary carrier
fc2=1e6;%Primary carrier frequency 1MHz
fcam=9000;
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
    ys(r) = cos(2*pi*(fc1+D*y(r)))*t(r); %subcarrier contain ref sig
    %yc(r) = cos(2*pi*(fc2+Dc*ys(r))*t(r)); %carrier 
    idata(r)=sin(2*pi*fc1*t(r))*ys(r);
    qdata(r)=cos(2*pi*fc1*t(r))*ys(r);
    IQData(r)=idata(r)+j.*qdata(r);

    %IQDatac(r)=sin(2*pi*yc(r))+j.*cos(2*pi*yc(r));
end%for explanation
%%ys1 = y1.*ys;%frequency mixer 30Hz ref with 180 degree phase shift and ys
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ys_normalized=ys/sqrt(sum(abs(ys.^2))/fs); 
% IQdataLowpass=doFilter2(IQData);

%%%%Signal Generation%%%%%%%%%%%%
yofm = fmmod(y,fc1,fs,D);
yofmd=fmdemod(yofm,fc1,fs,D);
yd=sin(2*pi*30*t+degtorad(90));
ydam=ammod(yd,fcam,fs);
ydamd=amdemod(ydam,fcam,fs);
yfinal=yofm+ydam;
yfinal=doFilter9000hz(yfinal);%LowPass filtered 
yfinalamdemod=amdemod(yfinal,fcam,fs);
yfinalfmdemod=fmdemod(yfinal,fc1,fs,480);
yfinalamdemodfilter=filter30hz(yfinalamdemod);%LowPass filtered 
yfinalfmdemodfilter=filter30hz(yfinalfmdemod);%LowPass filtered 
%%%%%%%%%%%%Ploting%%%%%%%%%
figure(1)
plot(t,yfinalamdemod,t,yfinalfmdemod)
title('am demod and fm demod')
figure(2)
plot(t,yd,t,y)
figure(6)
plot(t,yd,t,y,t,yfinalamdemod,t,yfinalfmdemod)
legend('yd','y','yamdemod','yfmdemod');
% figure(3)
% plot(t,yfinalamdemod,t,yfinalamdemodfilter);
figure(5)
plot(t,yfinalamdemod,t,yfinalamdemodfilter);
figure(4)
plot(t,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalamdemodfilter)))
