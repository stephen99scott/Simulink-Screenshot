function screenshotSystem(model, fileExt)
%   SCREENSHOTSYSTEM    Recursively screenshot the root block diagram of all
%                       subsystems and model references in a model, and store
%                       to files in the present working directory
%
%   Inputs:
%       model           Name of a Simulink model
%       fileExt         File extension for exported screenshots
%                       (jpeg, png, tiff, pdf)
%
%   Outputs:
%       N/A
%
%   Example:
%       screenshotSystem('model_name', 'pdf')
%
% Author: Stephen Scott

    %% Input Validation
    % Check for loaded system
    try
        load_system(model);
    catch
        msgbox(['Could not load system: ', model]);
    end
    % Check for valid file extension
    try
        assert(strcmp(fileExt, 'jpeg') || ...
               strcmp(fileExt, 'png') || ...
               strcmp(fileExt, 'tiff') || ...
               strcmp(fileExt, 'pdf'));
    catch
        msgbox('Invalid File Extension.', newline, ...
               'Use ''jpeg'', ''png'', ''tiff'', or ''pdf''');
    end
    
    %% Screenshot Model
    % Store the system blocks
    blocks = find_system(model);
    % Loop through each block in the system
    for block = 1:length(blocks)
        blockPath = blocks{block};
        blockName = getBlockName(blockPath);
        % Create a new directory for each model reference
        if block == 1
            dirName = genvarname(blockName);
            mkdir(dirName);
            cd(dirName);
            takeScreenshot(blockPath, blockName, fileExt);
        else
            blockType = get_param(blockPath,'BlockType');
            % Take screenshot of subsystem or recurse with model reference
            if strcmp(blockType, 'SubSystem')
                takeScreenshot(blockPath, blockName, fileExt);
            elseif strcmp(blockType, 'ModelReference')
                modelName = get_param(blockPath, 'ModelName');
                screenshotSystem(modelName, fileExt);
                cd('..');
            end
        end
    end
    %% Clean
    try
        close_system(model);
    catch
        msgbox(['Could not close system: ', model]);
    end
end