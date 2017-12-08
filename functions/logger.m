function logger(fid,patspec,varargin)
% USE:
%   logger(fid,patspec,input1,input2,...)
%
% DESCRIPTION:
%   This function is a wrapper for fprintf and is useful for logging
%   information to a file and the command window. In fact, that is what
%   this function does, it writes information to a log file first (provided
%   by fid, and assuming it ~= 0) and then writes the same information to
%   the command window (fid == 0).
%
%   Only the latter is done if fid is empty or equal to 0.
%
% INPUTS:
%   fid - File ID of an open text file to write to.
%   patspec = A string input with the specifications for the call to
%       FPRINTF()
%   input1, input2, ... - Values (in varargin) to pass to the format spec.
%       Length must equal the number of % in pat spec.
%
% Created by: Joshua D. Koen
% Created on: 12/5/2017

%% Error check patspec and varargin
if length(strfind(patspec,'%')) ~= length(varargin)
    warning('Different amount of variables in pattern specifiers in call to fprintf. Skipping logging')
    return;
end

%% Determine if return needs to be entered
needReturn = true;
if contains(patspec,'\n')
    needReturn = false;
end    

%% If fid is specified and not equal to 0, log to a file
fidError = false; % Flag to denote if error is present with FID
try % Try to write to file and screen
    
    if ~isempty(fid) && fid ~= 0
        fprintf(fid,patspec,varargin{:});
    end
    fprintf(patspec,varargin{:});
    
catch % If error, report it as warning
    
    warnString = '\nfprintf failed. likely due to error with patspec or value inputs.\n';
    fprintf(warnString);
    try
        fprintf(fid,warnString);
    catch
        fidError = true;
    end
    
    % If another error with writing to fid, likely file not open
    if fidError
        fprintf('\nfprintf failed due to error with file identifier for log file. No output logged.\n');
    end
    
end

%% Add return if needed
if needReturn
    
    if ~fidError
        fprintf(fid,'\n'); % to FID only if no FID error
    end
    fprintf('\n'); % to Command Window
    
end

end
        
    
    