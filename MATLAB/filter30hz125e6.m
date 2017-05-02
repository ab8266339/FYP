function y = doFilter(x)
%DOFILTER Filters input x and returns output y.

% MATLAB Code
% Generated by MATLAB(R) 9.0 and the DSP System Toolbox 9.2.
% Generated on: 24-Mar-2017 01:19:17

persistent Hd;

if isempty(Hd)
    
    Fpass = 25;    % Passband Frequency
    Fstop = 35;    % Stopband Frequency
    Apass = 1;     % Passband Ripple (dB)
    Astop = 60;    % Stopband Attenuation (dB)
    Fs    = 125e6;  % Sampling Frequency
    
    h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);
    
    Hd = design(h, 'equiripple', ...
        'MinOrder', 'any', ...
        'StopbandShape', 'flat');
    
    
    
    set(Hd,'PersistentMemory',true);
    
end

y = filter(Hd,x);

