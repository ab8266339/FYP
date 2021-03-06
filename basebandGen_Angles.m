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
phase=[0:45:360];
for r=1:length(phase);
    for r=phase(r);
        yd=P2B(t,r);
        ydam=ammod(yd,fcam,fs);
        yfinal=yofm+ydam;%yfinal is the final product after sinal mixing
        yfinalamdemod=amdemod(yfinal,fcam,fs);
        yfinalfmdemod=fmdemod(yfinal,fcfm,fs,D);
        yfinalamdemodfilter=filter30hz(yfinalamdemod);
        yfinalfmdemodfilter=filter30hz(yfinalfmdemod);
%         figure()
%         plot(t,yd,t,y)
%         title(['y and ydirectional of ',num2str(r)]);
%         legend(['directional phase ',num2str(r)],'ref');
        figure()
        plot(t,yd,t,y,t,yfinalamdemodfilter,t,yfinalfmdemodfilter)
        title(['yd y compare yamdemodfilter yfmdemodfilter with ' num2str(r) 'Phase Difference']);
        legend(['yd of ',num2str(r)],'y','yamf','yfmf');
        xlabel('Time(s)')
        ylabel('Amplitude')
        axis([0.1936 0.4 -1 1])

        
        end
end
% figure(1)
%         plot(t,yfinalamdemod,t,yfinalfmdemod);
%         title('fmdemod and amdemod');
%         legend('amdemod','fmdemod');
% 
% 
% for r=1:18
%     figure(r);
%     xlabel('Time(s)')
%     ylabel('Amplitude')
%     axis([0.2 0.5 -1 1])
%     findpeaks()
%     r=r+1;
% end 
