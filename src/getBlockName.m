function blockName = getBlockName(blockPath)
%   GETBLOCKNAME        Gets the selected block name from a block path
% 
%   Inputs:
%       blockPath       Path of a block
%
%   Outputs:
%       blockName       Name of the block at the block path
%
%   Example:
%       getBlockName('model_name/subsystem1')
%
%                       blockName = 'subsystem1'
%
% Author: Stephen Scott

    %% Input Validation
    % Check block path exists
    try
        type = get_param(blockPath, 'Type');
        assert(strcmp(type, 'block_diagram') || strcmp(type, 'block'));
    catch
        msgbox(['No blocks at: ', blockPath]);
    end
    %% Get Block Name
    % Split the path by '/'
    splitBlockName = split(blockPath, '/');
    % Block name is the last cell index
    blockName = splitBlockName{end};
end