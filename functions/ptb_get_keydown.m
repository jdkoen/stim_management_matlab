function [keysdown, timesdown, n] = ptb_get_keydown(devidx,goodkeys,logfid)
% USE:
%   [keysdown, timesdown] = ptb_get_keydown_at_t(endtime,goodkeys,logfid)
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
% 
% Created by: Joshua D. Koen
% Created on: 12/8/2017

%% FOR STARTERS (FIX LATER FOR ADDITIONAL FUNCTIONALITY)
goodkeys = [];
if isempty(logfid)
    logfid = [];
end

%% Report all events
% Initialize outputs
keysdown = [];
timesdown = [];

% Get all events in the queue
while KbEventAvail(devidx)
    
    % Get the event, and filter out ones where evt.Pressed == 0
    evt = KbEventGet(devidx);
    evt = evt([evt.Pressed] == 1);
    keysdown = horzcat(keysdown,evt.Keycode);
    timesdown = horzcat(timesdown,evt.Time);
    
end

% Compute number of events
n = length(keysdown);

% Log events
for i = 1:n
    logger(logfid,'%4.3f:\tKEY %s\tCODE %d\n', ...
        timesdown(i),keysdown(i),KbName(keysdown(i)));
end

end

