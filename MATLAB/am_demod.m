function z = am_demod(y, Fc, Fs)
%AMDEMOD Amplitude demodulation.
%   Z = AMDEMOD(Y,Fc,Fs) demodulates the amplitude modulated signal Y from
%   the carrier frequency Fc (Hz). Y and Fc have sample frequency Fs (Hz).
%   The modulated signal Y has zero initial phase, and zero carrier
%   amplitude, for suppressed carrier modulation. A lowpass filter is used
%   in the demodulation.  The default filter is: [NUM,DEN] =
%   butter(5,Fc*2/Fs).
%   
%   Z = AMDEMOD(Y,Fc,Fs,INI_PHASE) specifies the initial phase (rad) of the
%   modulated signal.
%
%   Z = AMDEMOD(Y,Fc,Fs,INI_PHASE,CARRAMP) specifies the carrier amplitude
%   of the modulated signal for transmitted carrier modulation.
%
%   Z = AMDEMOD(Y,Fc,Fs,INI_PHASE,CARRAMP,NUM,DEN) specifies the filter to
%   be used in the demodulation. 
%
%   See also AMMOD, SSBDEMOD, FMDEMOD, PMDEMOD.

%    Copyright 1996-2011 The MathWorks, Inc.




t = (0 : 1/Fs :(size(y,1)-1)/Fs)';
t = t(:, ones(1, size(y, 2)));
z = y .* cos(2*pi * Fc * t);



% --- EOF --- %
