% DisplayITI
%
%   Basic function to display an iti for a given duration:
%
%   ARGUMENTS:
%
%   Window          = The ptb window
%   duration        = duration the iti is presented, in seconds
%   iti_object      = either a character string or psychtoolbox texture.
%                     if a texture, there is (currently) only basic drawing
%                     support.
%   xpos (opt.)     = the x position to draw the text (not texture!)
%   ypos (opt.)     = the y position to draw the text (not texture!)
%
%   2012 -- Kiefer Katovich


function timer = DisplayITI(Window, duration, iti_object, xpos, ypos)

    startT = GetSecs();
    
    if nargin < 5
        xpos = 'center';
    end

    if nargin < 4
        ypos = 'center';
    end
    
    if ischar(iti_object)
        DrawFormattedText(Window, iti_object, xpos, ypos);
    else
        Screen('DrawTexture', Window, iti_object)
    end
        
    Screen('Flip',Window);

    timer = GetSecs()-startT;
    while timer < duration
        timer = GetSecs()-startT;
    end


end