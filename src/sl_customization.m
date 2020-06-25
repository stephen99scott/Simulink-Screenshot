%% Registering custom menu function
function sl_customization(cm)
    cm.addCustomMenuFcn('Simulink:PreContextMenu', @getSystemScreenshot);
end

%% Define custom menu function
function schemaFcns = getSystemScreenshot(callbackInfo)
    schemaFcns = {@ScreenshotSystem};
end

%% Define schema function
function schema = ScreenshotSystem(callbackInfo)
    schema = sl_container_schema;
    schema.label = 'Screenshot System';
    schema.ChildrenFcns = {@toJPEG, @toPNG, @toTIFF, @toPDF};
end

%% Define children schema functions
function schema = toJPEG(callbackInfo)
    schema = sl_action_schema;
    schema.label = 'To .JPEG';
    schema.callback = @toJPEGCallback;
end

function toJPEGCallback(callbackInfo)
    screenshotSystem(gcs, 'jpeg');
end

function schema = toPNG(callbackInfo)
    schema = sl_action_schema;
    schema.label = 'To .PNG';
    schema.callback = @toPNGCallback;
end

function toPNGCallback(callbackInfo)
    screenshotSystem(gcs, 'png');
end

function schema = toTIFF(callbackInfo)
    schema = sl_action_schema;
    schema.label = 'To .TIFF';
    schema.callback = @toTIFFCallback;
end

function toTIFFCallback(callbackInfo)
    screenshotSystem(gcs, 'tiff');
end

function schema = toPDF(callbackInfo)
    schema = sl_action_schema;
    schema.label = 'To .PDF';
    schema.callback = @toPDFCallback;
end

function toPDFCallback(callbackInfo)
    screenshotSystem(gcs, 'pdf');
end