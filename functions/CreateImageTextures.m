% CreateImageTextures 
%
% does exactly what it sounds like. It goes into the images folder, looks 
% for images by name in the cellarray image_names, and then converts those 
% images to preloaded Psychtoolbox textures for speedy presentation later.
%
% ARGUMENTS:
%
%   Window          = the ptb window variable
%   image_names     = a cell-array of image names that you want to load as
%                     textures.
%   filepath (opt.) = if necessary, the directory the images are in. The
%                     function will return to the original dir at the end.
%
%   Returns a cell array of PTB Textures.
%
%   2012 -- Kiefer Katovich
%

function textures = CreateImageTextures(Window, image_names, filepath)

    % Go into the images folder:
    if nargin > 2
        current_directory = pwd;
        cd(filepath)
    end
    
    % Initialize the textures cellarray that will be returned:
    textures = {};
    
    % Iterate through the names and convert the images to textures; load
    % them into the return cellarray:
    for i = 1:length(image_names)
        name = image_names{i};
        img = imread(name);
        tex = Screen('MakeTexture',Window,img);
        textures{i} = tex;
    end
    
    % Go back into the scripts folder:
    if nargin > 2
        cd(current_directory)
    end

end