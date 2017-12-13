function [keysdown, timesdown, n, all_keysdown, all_timesdown, all_n] = ptb_get_keydown(devidx,goodkeys,logfid,suppresslog)
% USE:
%   [keysdown, timesdown, n, all_keysdown, all_timesdown, all_n] =  ...
%               ptb_get_keydown(devidx,goodkeys,logfid)
%
% DESCRIPTION:
%   PTB_GET_KEYDOWN returns a vector of Keycodes and Timestamps for key
%   presses between the time of the function call and the ENDTIME input.
%   This uses the KBQUEUE* commands from PTB3.
%
%   This function can be used to control stimulus timing. After a call to
%   Screen('Flip',w), you can call this function to hold the stimulus
%   static
%
% INPUTS:
%   devidx - device index. On windows, usually just empty ([]).
%
%   goodkeys - vector of valid keycodes. Keycodes not in goodkeys will be
%              returned. If left empty, all keys pressed will be returned. 
%
%   logfid - File ID of the log file to pass to the LOGGER function. If
%            empty, logging is only output to the screen
%   suppresslog - Logical input that, if true, information will not be
%                 logged to command window nor logfid
% 
% OUTPUTS:
%   keysdown - vector of valid keycodes returned by KBEVENTGET
%   timesdown - vector of valid timestamps returned by KBEVENTGET
%   n - scalar value of the number of valid key presses
%   all_keysdown - vector of all keycodes returned by KBEVENTGET
%   all_timesdown - vector of all timestamps returned by KBEVENTGET
%   all_n - scalar value of the number of total (with invalid) key presses
%
% Created by: Joshua D. Koen
% Created on: 12/8/2017
% Updated on: 12/13/2017 - added outputs for all valid and invalid key
%                          presses

% Deal with logfid
if isempty(logfid)
    logfid = [];
end

%% Report all events
% Initialize outputs
all_keysdown = [];
all_timesdown = [];

% Get all events in the queue
while KbEventAvail(devidx)
    
    % Get the event, and filter out ones where evt.Pressed == 0
    evt = KbEventGet(devidx);
    evt = evt([evt.Pressed] == 1);
    all_keysdown = horzcat(all_keysdown,evt.Keycode);
    all_timesdown = horzcat(all_timesdown,evt.Time);
    
end

% Remove invalid keys and times
all_keysdown = all_keysdown;
all_timesdown = all_timesdown;
bad_presses = ~ismember(all_keysdown,goodkeys);
keysdown = all_keysdown(~bad_presses);
timesdown = all_timesdown(~bad_presses);

% Compute number of events
all_n = length(all_keysdown);
n = length(keysdown);

% Log all key presses
if ~suppresslog
    for i = 1:all_n
        
        logger(logfid,'%4.4f:\tKEY-%s CODE-%d\n',all_timesdown(i), ...
            upper(all_keysdown(i)),all_keysdown(i));
        
    end
end

end

