%Sig Gen by using FM
fs = 5e6;
t = 0:1/fs:0.1;
D1=480;
D2=5000;
fc1=9960;
fc2=1e6;
t = 0:1/fs:0.1;
y=sin(2*pi*30*t);
ysm=fmmod(y,fc1,fs,D1);
ysdm1=fmdemod(ysm,fc1,fs,D1);
ycm=fmmod(ysm,fc2,fs,D2);
ycdm=fmdemod(ycm,fc2,fs,D2);
ysdm2=fmdemod(ycdm,fc1,fs,D1,pi);
% plot(t,y,'r',t,ysm,'b--');
figure(1)

plot(t,y,'r',t,ysdm1,'b--');
title('comparsion of y and y modulation')
figure(2)
plot(t,ysm,'r',t,ycdm,'b--');
title('comparsion of ys modulation and yc demodulation')
%Diagram shows a bit detered signal after secondary modulation
figure(3)
plot(t,ysdm2,'r',t,ysdm1,'b--')
title('comparsion of ys modulation demodulation and yc demodulation')