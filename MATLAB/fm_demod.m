function z = fm_demod(y,Fc,Fs,freqdev)
%FMDEMOD Frequency demodulation.
%   Z = FMDEMOD(Y,Fc,Fs,FREQDEV) demodulates the FM modulated signal Y at
%   the carrier frequency Fc (Hz). Y and Fc have sample frequency Fs (Hz).
%   FREQDEV is the frequency deviation (Hz) of the modulated signal.
%
%   Z = FMDEMOD(Y,Fc,Fs,FREQDEV,INI_PHASE) specifies the initial phase of
%   the modulated signal.
%
%   See also FMMOD, PMMOD, PMDEMOD.





t = (0:1/Fs:((size(y,1)-1)/Fs))';
t = t(:,ones(1,size(y,2)));

yq = hilbert(y).*exp(-j*2*pi*Fc*t);
z = (1/(2*pi*freqdev))*[zeros(1,size(yq,2)); diff(unwrap(angle(yq)))*Fs];

end




   

