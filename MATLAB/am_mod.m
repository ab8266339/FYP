function y = am_mod(x, Fc, Fs)
%AMMOD Amplitude modulation.
%   Y = AMMOD(X, Fc, Fs) uses the message signal X to modulate the carrier
%   frequency Fc(Hz) using amplitude modulation. X and Fc have sample
%   frequency Fs (Hz). The modulated signal has zero initial phase. The
%   default carrier amplitude is zero, so the function implement suppressed
%   carrier modulation.
%
%
%   Fs must satisfy Fs >2*(Fc + BW), where BW is the bandwidth of the
%   modulating signal, X.


% Do the modulation
t = (0:1/Fs:((size(x, 1)-1)/Fs))';
t = t(:, ones(1, size(x, 2)));
y = x .* cos(2*pi*Fc*t);

    
