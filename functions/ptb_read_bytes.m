function [values, times, n] = ptb_read_bytes(port)
% USE:
%   [values, times, n] = ptb_read_bytes(port)
%
% DESCRIPTION:
%   PTB_READ_BYTES reads the all unlogged bytes from the serial resposne
%   box defined by PORT and returns the byte value and time stramp (from
%   GetSecs in PTB3).
%
% INPUTS:
%   port - open port to read from (e.g., 'COM3')
%
% OUTPUTS:
%   values - values read from serial port
%   times - time stamps of serial port byte(s)
%   n - number of bytes
%
% Created by: Joshua D. Koen
% Created on: 12/5/2017

% Get Number of Bytes
n = IOPort('BytesAvailable',port);

% Initialie values and times
values = zeros(n,1);
times = zeros(n,1);

% Get the values
for i = 1:n
    [values(i), times(i)] = IOPort('Read',port,0,1);
end

end