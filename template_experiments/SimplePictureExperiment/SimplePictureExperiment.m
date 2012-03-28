%%      SimplePictureExperiment
%
%   This is a simple picture displaying experiment. Data for onset times of
%   pictures and ITIS are recorded, then saved into the data folder in a
%   .mat format.
%
%   This is the format of the experiment:
%       Lead in
%       10 Trials:
%           A picture is displayed on a random point on the screen
%           A variable ITI is displayed
%       Lead out
%       Data saved
%
%   Changes to the experiment can be made in the beginning. All variables
%   of interest are saved in a data object. The user is prompted for a
%   subject ID at the matlab console before PTB takes over the screen. This
%   subject ID is used later in the saved data name.
%
%   Everything is commented to the extreme.
%   Enjoy!
%
%   03.27.2012      Kiefer Katovich




function SimplePictureExperiment()

    


    %%  INITIALIZE DATA OBJECT:
    %
    %   The data object is responsible for storing all of the users variables
    %   as well as the data acquired during the experiment runs.
    %
    
    %   In this experiment, data collection during the actual experiment is
    %   extremely simple. There is no response from the user, so the only
    %   thing that is kept track of are onset times for the pictures and
    %   itis. The lengths of the random itis are also recorded.
    data.picture_onsets = [];
    data.iti_onsets = [];
    data.iti_lengths = [];
    
    %   These timing variables are set by the user. You can specify length
    %   in seconds of the lead-in iti, lead-out iti, picture display
    %   duration, and the minimum time the iti is displayed.
    data.lead_in = 4.0;
    data.lead_out = 4.0;
    data.picture_display_duration = 3.0;
    data.iti_display_duration_base = 1.0;
    
    %   Some things like images and data are stored in subdirectories.
    %   These variables store the subdirectory names specified by the user.
    data.images_path_name = './images';
    data.data_path_name = './data';
    
    %   You may also want to set Psychtoolbox variables like font size,
    %   font, font color, and background color. 
    data.font_size = 100;
    data.font = 'Times New Roman';
    data.font_color = 225;
    data.background_color = 0;
    %   (Note: color values from 0-255 are black to white. Non-grayscale
    %   colors must be specified using rgb values such as [129 129 30])
    
    
    %   These are the names of our images stored in the images folder. We
    %   will need to preload the images into memory later.
    data.image_names = {'1.bmp','2.bmp','3.bmp','4.bmp','5.bmp','6.bmp', ...
        '7.bmp','8.bmp','9.bmp','10.bmp'};
     
    
    
    
    
    
    %%  SUBJECT CONSOLE PROMPT:
    %   This will prompt the experimenter before the experiment begins to
    %   supply a subject ID. This will be used later to name the data file
    %   for this subject.
    data.subjectID = input('Please enter your subject ID number: ','s');


    
    
    
    

    %%  SCREEN SETUP:
    %   Most of this you don't really have to worry about, and this code
    %   can be carried over between experiments. Its use is primarily to
    %   determine the resolution of the screen being used to display the
    %   experiment. Once you have the resolution, you can get the length in
    %   pixels of the horizontal and vertical dimensions without the
    %   experimenter having to know it.
    %
    
    %   Find out if there is more than one screen:
    if max(Screen('Screens')) > 0
        %   If so, get the primary screen's resolution
        dual=get(0,'MonitorPositions');
        resolution = [0,0,dual(1,3),dual(1,4)];
        
    elseif max(Screen('Screens'))==0
        %   If not, get the normal screen's resolution
        resolution = get(0,'ScreenSize') ;
    end
    
    %   Assign the maximum x length and y length to X and Y data variables.
    %
    %   Note: Psychtoolbox uses "rectangles" to draw, most of the time.
    %   These boxes are specified by coordinates on the screen. The
    %   resolution variable here is a rectangle that covers the entire
    %   screen.
    %
    %   Oddly, the origin is in the top left corner. As you move right
    %   across the screen, X increases. As you move down across the screen,
    %   Y increases.
    %
    %   "Rects" are specified like so: ['top left x' 'top left y' 'bottom
    %   right x' 'bottom right y']
    %
    %   For example: [0 0 1920 1200] would be a rect that is the resolution
    %   of a computer screen with 1920x1200 resolution. [500 500 600 600]
    %   could be a 100x100 pixel box on that screen.
    data.screenX = resolution(3);
    data.screenY = resolution(4);

    
    
    
    
    
    
    %%  INITIALIZE WINDOW:
    %   PTB uses something called the "window" to draw the experiment on
    %   to. The commmand to open a new window and begin the experiment is
    %   Screen('OpenWindow',[screen number],[default background color],
    %   [etc])
    %   
    %   Most of the parameters in the command are optional. The
    %   documentation goes into (much) more detail on this.
    %
    %   Nearly all PTB's critical commands are carried out by a
    %   master-function called 'Screen'. Screen, in essence, is an API that
    %   allows you to hook safely (for the most part) into the lower-level
    %   functionality that PTB supplies.
    %
    %   The first parameter to Screen is always a string specifying the
    %   delegate functionality that you would like to access. The second
    %   parameter (aside from when calling OpenWindow) is almost always the
    %   Window that you would like to preform this delegate function onto.
    %
    
    %   Determine the screen number:
    screenNumber = max(Screen('Screens'));
    
    %   Open a new window called 'Window' (Rect here is the size of window,
    %   which we don't really use in this experiment). We set the Window to
    %   the user-specified default background color.
    [Window,Rect] = Screen('OpenWindow',screenNumber,data.background_color);
    
    %   Set the default text size and text font of our Window using
    %   Screen's delegate functions 'TextSize' and 'TextFont'. We set them
    %   to the user specified size and font determined at the beginning of
    %   the script.
    Screen('TextSize',Window,data.font_size);
    Screen('TextFont',Window,data.font);
       
    
    
    
    
    
    
    
    %%  PRE-LOAD IMAGES:
    %   In experiments where exact timing is a concern (which is a concern
    %   in many or most fMRI experiments), we don't want there to be
    %   computationally-generated "lag" to occur that the computer has
    %   difficulty accounting for. Graphical processing (especially videos,
    %   but also pictures) is a prime example of where this lag can occur.
    %
    %   Luckily, Psychtoolbox provides some helper functions that can
    %   'preload' the images or videos so that this processing doesn't
    %   happen on the fly. This is achieved by forcing the pictures or
    %   videos into RAM (as far as I know) and optimizing them for display
    %   on a psychtoolbox window.
    
    %   We have some images defined above, so we should preload them before
    %   the actual experiment begins.
    %
    %   The first thing we will have to do is change directory into the
    %   pictures directory:
    cd(data.images_path_name)
    
    %   Now we're in the images folder. When PTB preloads images, it gives
    %   you back a pointer to the pictures location in memory. These
    %   pointers are what PTB calls 'textures'. First we will preallocate a
    %   cell array that will store these pictures in the same order they
    %   were named above:
    image_textures = {};
    
    %   Next, we will iterate through the length of our data.image_names
    %   cell array. For each named picture, we will use the matlab 'imread'
    %   command to load the image into a matrix, then use the
    %   Screen('MakeTexture') command to preallocate the picture into
    %   memory:
    for i = 1:length(data.image_names)
        
        %   Load the image into a matlab matrix:
        img = imread(data.image_names{i});
        
        %   Create the pointer to the image in memory for display on Window
        tex = Screen('MakeTexture',Window,img);
        
        %   add the pointer to our image_textures cell array:
        image_textures{i} = tex;
    end
    
    % now we'll exit back into the main directory:
    cd('..')
    
    
    
    
    
    
    %%  GET READY INSTRUCTIONS
    %   Put up a "Get Ready" screen until the experimenter presses a button.
    %   This will allow the experimenter or the subject to start the
    %   experiment any time they are ready.

    %   DrawFormattedText, you will notice, is not a Screen command, but it
    %   uses the same stuff under the hood that Screen does to draw text to
    %   the screen. It is a function that is designed to make drawing text
    %   to the screen as easy as possible when nothing fancy is required.
    
    %   Here we tell DrawFormattedText to put 'Press A Key!' on the Window,
    %   and to use 'center' and 'center' for the X and Y positions
    %   respectively. We also provide a font color. Note that 'center' is
    %   not generally an option; though some other PTB functions allow it,
    %   don't count on it working unless you know.
    DrawFormattedText(Window,'Press A Key!','center','center',data.font_color);
    
    %   Now we will 'Flip' the Window. The way that PTB works is that you
    %   prepare a slide, then 'flip' the slide over so that the subject can
    %   see it. At the point a slide is flipped, you are now working with a
    %   new blank canvas for the next slide.
    
    %   Imagine having two displays, and when you move one to the front,
    %   the other is erased and you can work on the erased one while the
    %   other one is displayed.
    
    %   The benefit is obviously that you can prepare the rest of your
    %   experiment while other parts of it are running:
    Screen('Flip',Window);
    
    %   Now we will wait a little bit, then wait for the user to press a
    %   key using KbWait:
    WaitSecs(0.4);
    KbWait();

    
    %   Once the user presses the key, get the start time using the
    %   function GetSecs():
    %
    %   Note: GetSecs() is in computer time, so if you want to get some
    %   kind of human-readable time interval you will have to do GetSecs()
    %   minus start time (as we will, later).
    data.start_time = GetSecs();
    
    
    
    
    
    %%  Display the initial lead-in ITI:
    %   Now we're ready to begin the experiment. Let's display an initial
    %   inter-stimulus interval for the duration specified at the
    %   beginning:
    
    %   Start off by drawing a plus sign to the working side of the Window
    %   using DrawFormattedText.
    DrawFormattedText(Window,'+','center','center',data.font_color);
    
    %   Now flip that side of the window to be the displayed side.
    Screen('Flip',Window);

    %   Wait for the lead-in duration before doing anything else:
    WaitSecs(data.lead_in);
    

    
    
    
    %%  MAIN EXPERIMENT LOOP
    %   Now we're ready to get to the experiment (finally?!?). The structure
    %   of the experiment is to go through all the pictures, display them
    %   at a semi-random part of the screen, then display an ITI.
    %   Thrilling.
    %
    
    %   Start by setting up the for-loop that will iterate through our
    %   image textures:
    for i = 1:length(image_textures)
        
        %   Determine a place to put the picture in X and Y coordinates,
        %   and fix the size of each picture to be 300x300:
        
        %   Find the max and min X and Y starting points for the picture,
        %   given that the picture is 300x300. That's easy, its just the
        %   X and Y resolution of the screen minus 300. Take the remainder
        %   and randomize it for a random position on the screen:
        
        picture_x = (data.screenX-300)*rand;
        picture_y = (data.screenY-300)*rand;
        
        %   Create the 'destination rect' of the picture (the rectangle in
        %   screen coordinates that the picture will fit in to:
        
        dest_rect = [picture_x picture_y picture_x+300 picture_y+300];
        

        %   Draw the picture to the screen using the Screen('DrawTexture')
        %   command. You may wonder why there is an empty array after
        %   image_textures{i}. This is because that argument would have
        %   supplied a "source rect" to specify what subsection of the
        %   picture to crop to. Since we just want to take the whole
        %   picture and warp it to fit our 300x300 box, we just enter a
        %   default empty array:
        Screen('DrawTexture',Window,image_textures{i},[],dest_rect);
        
        %   Flip the window to display the picture:
        Screen('Flip',Window);
        
        %   Record the onset of the picture at the index "i" of our onsets
        %   array. This is in absolute time from when the experiment began,
        %   so we can get it by taking the current time and subtracting the
        %   start time:
        data.picture_onsets(i) = GetSecs()-data.start_time;
        
        %   Now wait the specified amount of time for a picture to be
        %   displayed on screen:
        WaitSecs(data.picture_display_duration);

        
        %   Next, display the trial ITI. This is done exactly the same way
        %   as the lead-in ITI:
        DrawFormattedText(Window,'+','center','center',225);
        Screen('Flip',Window);
        
        %   Record the onset of the ITI in the same way that the picture
        %   onset was recorded:
        data.iti_onsets(i) = GetSecs()-data.start_time;
        
        %   Choose a random amount of time to wait for this ITI. Take the
        %   minimum wait time and then add anywhere from 0-2 seconds. At
        %   the same time, record this in our iti_lengths array so we can
        %   see how long each ITI was later:
        data.iti_lengths(i) = data.iti_display_duration_base + 2.0*rand;
        
        %   Funnel this iti into WaitSecs to actually preform the waiting:
        WaitSecs(data.iti_lengths(i));

    end 
    
    % Display the lead-out ITI. This is done the same as the other ITIs as
    % well:
    DrawFormattedText(Window,'+','center','center',225);
    Screen('Flip',Window);
    WaitSecs(data.lead_out);

    
    %%  SAVE THE DATA:
    %   Now the experiment is done and we want to record the data
    %   somewhwere. The easiest way to do this is to save a .mat file that
    %   stores the 'data' object we've been using this whole time in a
    %   file.
    
    %   First off, lets cd into our data directory:
    cd(data.data_path_name)
    
    %   Now lets create a subject-specific filename for this session so we
    %   don't end up overwriting the same file running the experiment
    %   multiple times. This will concatenate the subjectID and a general
    %   suffix '_data.mat' (that contains the file extension!):
    filename = [data.subjectID '_data.mat'];
    
    %   Now save the 'data' variable into this filename:
    %   Note: data must be specified by the string that references it, not
    %   the variable itself.
    save(filename, 'data')
    
    %   cd back into the main directory:
    cd('..')
    
    %   That's it! Close the Psychtoolbox Window and we're done.
    Screen('CloseAll');
        

end



