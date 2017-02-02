function stimStruct = create_stim_structure(subID,varargin)
% USE:
%   STIMSTRUCT = CREATE_STIM_STRUCTURE(subID,varargin)
%
% DESCRIPTION:
%   CREATE_STIM_STRUCTURE creates an array structure variable with fields and
%   values supplied by the user. The input is in a property-value format
%   (e.g., CREATE_STIM_STRUCTURE('itemType',{'old' 'new' 'old' 'old'}).
%   This is to be used with Cogent or Psycophysics toolbox. Some default
%   fields are created, and include: subject id (sub_id), date the
%   structure was created (date_created), date of the experiment session
%   (session_date), start (session_start) and end (session_end) time, and 
%   the trial number (trial_num). 
%
% INPUT:
%   subID - A string or numeric ID for the subject. 
%
%   After subID, inputs will be comprise a property (i.e., string) value, 
%   which will be stored as a field name in the structure, and a vector 
%   that is cell array of strings or a numeric vector that has the values 
%   for each trial.
%
% Created by Joshua D. Koen
% Created on 12/02/2014

% Check for inputs (must have at least one property-value pair)
if nargin < 2
    error('Must input at least one property-value pair argument.')
end

% Initialize the structure
stimStruct = struct('sub_id',[],'date_created',[], ...
    'session_date',[],'session_start',[],'session_end',[], ...
    'trial_num',[]);

% Get current date and time for date created
curDate = datestr(now);

% Add user supplied field names
for i = 1:2:length(varargin)
    curField = varargin{i};
    stimStruct.(curField) = [];
end

% Get the number of trials from the first value vector
nTrials = length(varargin{2});

% Return error if first property-value pair has an empty matrix for the
% values.
if nTrials == 0
    error('The value vector for the first property-value pair cannot be empty.');
end

% Loop through and add sub_id and date created values
for i = 1:nTrials
    stimStruct(i,1).sub_id = subID;
    stimStruct(i,1).date_created = curDate;
    stimStruct(i,1).trial_num = i;
end

% Loop through the inputs to log the values
for i = 1:2:length(varargin)
    
    % Initialize the current field name
    curField = varargin{i};
    
    % Get the values for the current fields and convert to a cell array
    emptyFlag = false;
    curVals = varargin{i+1};
    if isnumeric(curVals)
        curVals = num2cell(curVals);
    elseif isempty(curVals)
        emptyFlag = true;
    elseif ~iscell(curVals) || ~isvector(curVals)
        error('All value inputs must be a cell array or numeric vector.')
    end
    
    % Loop through curVals and add values to the current field
    if ~emptyFlag
        for j = 1:length(curVals)
            
            stimStruct(j).(curField) = curVals{j};
            
        end
    end
end

end