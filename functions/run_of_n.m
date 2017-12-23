function flag = run_of_n(x,n)
% USE:
%   flag = run_of_n(x,n);
%
% DESCRIPTION:
%   Determine is there is a run of identical values in X greater than
%   value in N.
%
% INPUTS:
%   X - A column/row vector. Can be numeric, character, or cell array
%       of strings.
%   
%   N - Scalar numeric input indicating the maximum number of
%       identical value repeats in X.
%
% OUTPUT:
%   FLAG - Logical scalar. If TRUE, indicates a run in X greater than
%       N.

%% Error Check Inputs
% Check x
if ~isvector(x)
    error('X input must be a column or row x.')
elseif ~isscalar(n) || ~isnumeric(n)
    error('N must be a scalar numeric value.')
end

%% Check if run of N is in x
% Make x a column vector
if isrow(x), x = x'; end

% Initialize FLAG to false
flag = false; % Will remain false if no runs > N

% Search for a repeat
for i = 1:length(x) - (n - 1) % Iterate over all trials to length(x) - (n-1)
    
    % Get the starting value
    startVal = x(i);
    
    % Run the test. If run > N, break for speed of processing
    if isequal(x(i:i+n-1),repmat(startVal,n,1))
        flag = true;
        break;
    end
    
end

end