% FM -> I/Q -> Save
% Dong Wang
% 13/02/2017

clear all
clc

ts=0.001;                           % 信号抽样时间间隔
t=0:ts:10-ts;                       % 时间向量
fs=1/ts;                            % 抽样频率
df=fs/length(t);                    % fft的频率分辨率
msg=randint(100,1,[-3,3],123);      % 生成消息序列,随机数种子为123
msg1=msg*ones(1,fs/10);             % 扩展成取样信号形式
msg2=reshape(msg1.',1,length(t));
Pm=fft(msg2)/fs;                    % 求消息信号的频谱
f=-fs/2:df:fs/2-df; 
subplot(4,1,1)
plot(t,fftshift(abs(Pm)))
title('消息信号频谱')
 
int_msg(1)=0;                       % 消息信号积分
for ii=1:length(t)-1
    int_msg(ii+1)=int_msg(ii)+msg2(ii)*ts;
end
 
kf=50;
fc=250;                             % 载波频率
Sfm=cos(2*pi*fc*t+2*pi*kf*int_msg); % 调频信号
Pfm=fft(Sfm)/fs;                    % FM信号频谱
subplot(4,1,2)
plot(f,fftshift(abs(Pfm)))          % 画出已调信号频谱
title('FM信号频谱')

% % Pc=sum(abs(Sfm).^2)/length(Sfm)     % 已调信号功率
% % Ps=sum(abs(msg2).^2)/length(msg2)   % 消息信号功率
% %  
% % fm=50;
% % betaf=kf*max(msg)/fm                % 调制指数
% % W=2*(betaf+1)*fm                    % 调制信号带宽


% I/Q=In-phase/Quadrature 同相正交

% 同相分量：乘以cos(2*pi*fc*t0), 在一个符号周期内积分，sample
% 疑问：此处“在一个符号周期内积分，sample”公式如何表达？未找到相关资料
for t0 = 0:ts:10-ts;
    Sfm_I = cos(2*pi*fc*t0+2*pi*kf*int_msg)*cos(2*pi*fc*t0);
end
Pfm_I=fft(Sfm_I)/fs;                  % FM信号同相分量频谱
subplot(4,1,3)
plot(f,fftshift(abs(Pfm_I)))          % 画出已调信号同相分量频谱
title('FM信号同相分量频谱')

% 正交分量：乘以sin(2*pi*fc*t0)
for t0 = 0:ts:10-ts;
    Sfm_Q = cos(2*pi*fc*t0+2*pi*kf*int_msg)*sin(2*pi*fc*t0);
end
Pfm_Q=fft(Sfm_Q)/fs;                  % FM信号正交分量频谱
subplot(4,1,4)
plot(f,fftshift(abs(Pfm_Q)))          % 画出已调信号正交分量频谱
title('FM信号正交分量频谱')


% 保存为mat格式数据

save('Sfm.mat','Sfm');
save('Sfm_I.mat','Sfm_I');
save('Sfm_Q.mat','Sfm_Q');