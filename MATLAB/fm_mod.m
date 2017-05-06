function y = fm_mod(x,Fc,Fs,freqdev)
%FMMOD Frequency modulation.
%   Y = FMMOD(X,Fc,Fs,FREQDEV) uses the message signal X to modulate the
%   carrier frequency Fc (Hz) and sample frequency Fs (Hz),  where Fs >
%   2*Fc. FREQDEV (Hz) is the frequency deviation of the modulated signal.
%
%   Y = FMMOD(X,Fc,Fs,FREQDEV,INI_PHASE) specifies the initial phase of
%   the modulation.
%
%   See also FMDEMOD, PMMOD, PMDEMOD.

%    Copyright 1996-2014 The MathWorks, Inc.

% check that Fs must be greater than 2*Fc


% --- Assure that X, if one dimensional, has the correct orientation --- %

t = (0:1/Fs:((size(x,1)-1)/Fs))';
t = t(:,ones(1,size(x,2)));
int_x = cumsum(x)/Fs;
y = cos(2*pi*(Fc+freqdev*int_x))*t; %subcarrier contain ref sig

y = cos(2*pi*Fc*t + 2*pi*freqdev*int_x );   


    
% EOF