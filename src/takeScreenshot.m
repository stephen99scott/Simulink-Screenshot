function fileName = takeScreenshot(blockPath, fileHdr, fileExt)
%   TAKESCREENSHOT      Stores screenshot of root block diagram into new file
% 
%   Inputs:
%       blockPath       Path of a subsytem or model
%       fileHdr         String to be added to extension to create file name
%       fileExt         File extension for exported screenshots
%                       (jpeg, png, tiff, pdf)
%
%   Outputs:
%       fileName        Name of the file where the screenshot was stored
%
%   Example:
%       takeScreenshot('model_name/subsystem1', 'subsystem1', 'jpeg')
%
%                       fileName = 'subsystem1.jpeg'
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
    
    try
        assert(ischar(fileHdr));
    catch
        msgbox(['Block name, ' fileHdr, ', is not a string']);
    end
    
    try
        assert(strcmp(fileExt, 'jpeg') || ...
               strcmp(fileExt, 'png') || ...
               strcmp(fileExt, 'tiff') || ...
               strcmp(fileExt, 'pdf'));
    catch
        msgbox('Invalid File Extension.', newline, ...
               'Use ''jpeg'', ''png'', ''tiff'', or ''pdf''');
    end
    %% Take Screenshot
    % Create the file name
    fileName = [genvarname(fileHdr), '.', fileExt];
    % Print screenshot to file
    print(['-s', blockPath], ['-d', fileExt], fileName);
end