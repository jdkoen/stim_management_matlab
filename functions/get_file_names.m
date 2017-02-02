function files = get_file_names(directory,filestem,fullpath)
% This function uses the DIR function to find files of a specific type in a
% directory, and extract teh file names from the returned structure from
% DIR. 
%
% The two required inputs are directory and filestem, which specify the
% directory to seatch and the file or file stem (e.g., *.txt for all text
% files) to search for. 
%
% By default, on the file names are returned. However

% Determine what to do with fullpath
if isempty(fullpath) || nargin < 3 || ...
        ~exist('fullpath','var') || ~islogical(fullpath)
    fullpath = false;
end

% Get the file names
files = dir(fullfile(directory,filestem));
files = {files.name}';

% If fullpath, add directory to string
if fullpath
    files = cellfun(@(x) fullfile(directory,x),files,'UniformOutput',false);
end

end