%Baseband Generator
fc1=1e4;%secondary carrier
fs = 5e4;%sampling rate
t = 0:1/fs:1;%signal length

ys = [];
D = 480;%Deviation for the first carrier
Dc = 5e3; %Deviation for the second carrier
yc = [];

fc2=1e6;%Primary carrier frequency 1MHz
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
    ys(r) = cos(2*pi*(fc1+D*y(r)))*t(r); %subcarrier contain ref sig
    %yc(r) = cos(2*pi*(fc2+Dc*ys(r))*t(r)); %carrier 
    idata(r)=sin(2*pi*fc1*t(r))*ys(r);
    qdata(r)=cos(2*pi*fc1*t(r))*ys(r);
    IQData(r)=idata(r)+j.*qdata(r);

    %IQDatac(r)=sin(2*pi*yc(r))+j.*cos(2*pi*yc(r));
end
%%ys1 = y1.*ys;%frequency mixer 30Hz ref with 180 degree phase shift and ys
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ys_normalized=ys/sqrt(sum(abs(ys.^2))/fs); 
% IQdataLowpass=doFilter2(IQData);
yofm = fmmod(y,fc1,fs,D);
yofmd=fmdemod(yofm,fc1,fs,D);
yd=sin(2*pi*30*t+degtorad(90));
ydam=ammod(yd,fcam,fs);
ydamd=amdemod(ydam,fcam,fs);
yfinal=yofm+ydam;
yfinal=doFilter9000hz(yfinal);
yfinalamdemod=amdemod(yfinal,fcam,fs);
yfinalfmdemod=fmdemod(yfinal,fc1,fs,480);
yfinalamdemodfilter=filter30hz(yfinalamdemod);
yfinalfmdemodfilter=filter30hz(yfinalfmdemod);

figure(1)
plot(t,yfinalamdemod,t,yfinalfmdemod)
legend('amdemod','fmdemod')
figure(2)
plot(t,yd,t,y)
legend('directional','ref');
figure(6)
plot(t,yd,t,y,t,yfinalamdemod,t,yfinalfmdemod)
legend('yd','y','yam','yfm');
figure(7)
plot(t,yd,t,y,t,yfinalamdemodfilter,t,yfinalfmdemodfilter)
legend('yd','y','yamf','yfmf');
% figure(3)
% plot(t,yfinalamdemod,t,yfinalamdemodfilter);
figure(5)
plot(t,yfinalamdemod,t,yfinalamdemodfilter);
legend('amdemod','amdemodfliter')
figure(4)
plot(xaxis,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalamdemodfilter)))
