%Baseband Generator
fs = 1e6;%sampling rate
t = 0:1/fs:0.1;%signal length
fc1=9960;%secondary carrier
ys = [];
D = 480;%Deviation for the first carrier
Dc = 5e3; %Deviation for the second carrier
yc = [];
fc2=1e6;%Primary carrier frequency 1MHz
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

ys2 = fmmod(y,fc1,fs,D);
ysdm1=fmdemod(ys2,fc1,fs,D);
% ys_normalized=ys/sqrt(sum(abs(ys.^2))/fs); 
% IQdataLowpass=doFilter2(IQData);
yd=sin(2*pi*30*t+degtorad(90));
ydmodam=ammod(yd,9960,fs);
yddemodam=amdemod(ydmodam,9960,fs);
yfinal=ys2+ydmodam;
yfinalamdemod=amdemod(yfinal,9960,fs);
% yfinalamdemodfilter=filter30hz(yfinalamdemod);
% yfinalfmdemodfilter=filter30hz(yfinalfmdemod);
yfinalfmdemod=fmdemod(yfinal,9960,fs,480);
figure(1)
plot(t,yfinalamdemod,t,yfinalfmdemod)
figure(2)
plot(t,yd,t,y)
% figure(3)
% plot(t,yfinalamdemod,t,yfinalamdemodfilter);
% figure(5)
% plot(t,yfinalamdemodfilter,t,yfinalfmdemodfilter);
% figure(4)
% plot(t,abs(fft(yfinalamdemod)),xaxis,abs(fft(yfinalamdemodfilter)))
