function [value, time] = ptb_wait_bytes(port,timeout,n_bytes)
% USE:
%   [values, times] = ptb_wait_bytes(port,timeout,n_bytes)
%
% DESCRIPTION:
%   PTB_WAIT_BYTES listens for a specified number of bytes to be availble
%   from the serial port or for a particular timeout. The number of bytes
%   to listen for is defined by N_BYTES and the max time to wait for is
%   TIMEOUT. 
%
%   Note that TIMEOUT is based on the expected end time from the current
%   time. Thus, if the curent time from GetSecs is e.g., 1.57, and you want
%   to wait for 5 seconds maximum, the timeout input should be 6.57 (i.e.,
%   GetSecs + time_to_wait)
%
% INPUTS:
%   port - open port to read from (e.g., 'COM3')
%   timeout - time stamp to break out of function (see DESCRIPTION for
%             details)
%   n_bytes - number of available bytes in the buffer to wait for before
%             breaking out of funciton
%
% OUTPUTS:
%   values - values read from serial port
%   times - time stamps of serial port byte(s)
%
% Created by: Joshua D. Koen
% Created on: 12/5/2017

% Listen for bytes
value = [];
time = [];
while true
    
    % Get number of bytes
    n = IOPort('BytesAvailable',port);
    
    % If a single byte is availble, break
    if n == n_bytes
        [value,time] = ptb_read_bytes(port);
        break;
    end
    
    % Break if there is a timeout
    if GetSecs > timeout
        break;
    end
    
end

end