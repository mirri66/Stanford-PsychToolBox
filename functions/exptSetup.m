% exptSetup
% run experiment setup scripts here, like graphics etc

function [c] = exptSetup

% if you're using randomization, it's important to seed your random number
% generator!
RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock))); %seed rand


%graphics stuff
screenNumber = max(Screen('Screens')); % 0 = main display
% screen / coordinates
if max(Screen('Screens'))>0 %dual screen
    c.dual = get(0,'MonitorPositions');
   % c.scrsz = [0,0,(c.dual(2,3)-c.dual(2,1)),(c.dual(2,4)-c.dual(2,2))];
    c.scrsz = [0,0,(c.dual(1,3)-c.dual(1,1)),(c.dual(1,4)-c.dual(1,2))];

elseif max(Screen('Screens'))==0 % one screen
    c.scrsz = get(0,'ScreenSize') ;
end

[c.Window, Rect] = Screen('OpenWindow',screenNumber, 0);

% Set fonts
Screen('TextFont',c.Window,'Arial');
Screen('TextSize',c.Window,24);
Screen('FillRect', c.Window, 0);  % 0 = black background
c.textColor = 255;

% Print a loading screen
DrawFormattedText(c.Window, 'Loading -- the experiment will begin shortly','center','center',255);
Screen('Flip',c.Window);


ListenChar(2) %Ctrl-c to enable Matlab keyboard interaction.
HideCursor; % Remember to type ShowCursor or sca later



end