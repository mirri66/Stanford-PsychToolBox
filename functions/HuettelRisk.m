% HuettelRisk
% -----------
% risky vs certain vs ambiguous choices
% usage: data = HuettelRisk(c)
%
% arguments:
%   c -- see exptSetup
%
% output:
%   b,a - beta, alpha
%   datamat - details individual trials
%
% reference: Huettel et al. (2006), Neural Signatures of Economic
%   Preferences for Risk and Ambiguity. Neuron 49, 765-775
%
% author: Grace (tsmgrace@gmail.com) 2013

function [b,a,datamat] = HuettelRisk(c)

scanner = 0;
xx.debugFlag=0; % 1 for debug mode - gets rid of a lot of waiting

% Print a loading screen
DrawFormattedText(c.Window, 'Loading -- the experiment will begin shortly','center','center',250);
Screen('Flip',c.Window);

% some constants for storing data

xx.option1typeCol = 1;
xx.option1val1Col = 2;
xx.option1val2Col = 3;
xx.option1probCol = 4;
xx.option2typeCol = 5;
xx.option2val1Col = 6;
xx.option2val2Col = 7;
xx.option2probCol = 8;
xx.keyCol=9;
xx.RTCol=10;
xx.choseCol = 11;
xx.outcomeCol = 12;
xx.nonChosenOutcomeCol = 13;
xx.choiceOnsetCol = 14;
xx.choseOptionTimeCol = 15;
xx.outcomeShownCol = 16;

% additional graphics stuff
c.hPosR = 4*c.scrsz(3)/6;
c.hPosL = c.scrsz(3)/6;
c.hPosition = c.scrsz(3);
c.vPosition = c.scrsz(4);
c.instr_X = 2*c.scrsz(3)/7;
c.radius = c.scrsz(3)/7;
c.outerradius = 0.1; % factor by which radius should be expanded for outer ring

c.blackText = [0 0 0];
c.borderColor = [250 250 150];
c.rouletteRadius = c.outerradius*c.radius/2;

%c.frameRate = frameRate;
c.TR=2;


% trials
% option 1 type, option 1 val 1, option 1 val 2, option 1 prob of val 1
% option 2 type, option 2 val 1, option 2 val 2, option 2 prob of val 1
% option types: 1 = certain, 2 = risky, 3 = ambig

trialMat = [
    2 20 8 0.5 1 12 0 1 % certain vs risky
    2 20 4 0.75 2 50 10 0.25 % risky vs risky
    3 35 0 0.25 1 12 0 1 % ambig vs certain
    3 35 0 0.25 2 20 12 0.25 % ambig vs risky
    ];


ListenChar(2) %Ctrl-c to enable Matlab keyboard interaction.
HideCursor; % Remember to type ShowCursor or sca later


%% the study::

hSide1 = c.hPosition/2-c.radius;
hSide2 = c.hPosition/2-c.radius;
wrap = 80;
instrCircleVdisplace = c.vPosition/11;
% Instructions
DrawFormattedText(c.Window, ['In each trial of this task, you will be asked to indicate your preference between two options. '...
    'Some options will lead to a fixed amount of money. For example, when you see a circle like this:'],c.hPosition/6,c.vPosition/9,250,wrap, [],[],1);
Screen('FillOval', c.Window, c.borderColor, [hSide1-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius+instrCircleVdisplace,hSide1+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius+instrCircleVdisplace])
Screen('FillArc', c.Window, [250 0 0], [hSide1, c.vPosition/2-c.radius+instrCircleVdisplace,hSide1+c.radius*2, c.vPosition/2+c.radius+instrCircleVdisplace], 0, 360)
Screen('DrawText', c.Window, ['$' num2str(50,'%#4.2f')], hSide1+c.radius*0.8, c.vPosition/2+instrCircleVdisplace, c.blackText);

DrawFormattedText(c.Window, ['This means you will get $50 for sure if you choose it.'],c.hPosition/6,18*c.vPosition/20,250,wrap, [],[],1);
DrawFormattedText(c.Window, ['Press ''g'' to continue.'],c.hPosition/6,19*c.vPosition/20,250,wrap, [],[],1);
Screen('Flip',c.Window);
GetKey('g',[],[],-3);


DrawFormattedText(c.Window, ['Others options will have more than one sum of money. If you see a circle like this: '],c.hPosition/6,c.vPosition/8,250,wrap, [],[],1);
Screen('FillOval', c.Window, c.borderColor, [hSide1-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius+instrCircleVdisplace,hSide1+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius+instrCircleVdisplace])

Screen('FillArc', c.Window, [250 0 0], [hSide1, c.vPosition/2-c.radius+instrCircleVdisplace,hSide1+c.radius*2, c.vPosition/2+c.radius+instrCircleVdisplace], 0, 0.25*360)
Screen('FillArc', c.Window, [0 250 0], [hSide1, c.vPosition/2-c.radius+instrCircleVdisplace,hSide1+c.radius*2, c.vPosition/2+c.radius+instrCircleVdisplace], 0.25*360, 0.75*360)
Screen('DrawText', c.Window, ['$' num2str(12,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((0.25-0.5)/0.25)+instrCircleVdisplace, c.blackText);
Screen('DrawText', c.Window, ['$' num2str(20,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((0.25-0.5)/0.25)+instrCircleVdisplace, c.blackText);

DrawFormattedText(c.Window, ['If you choose this, you will have a 25% chance of winning $20, or a 75% chance of winning $12.'],c.hPosition/6,17*c.vPosition/20,250,wrap, [],[],1);
DrawFormattedText(c.Window, ['Press ''g'' to continue.'],c.hPosition/6,19*c.vPosition/20,250,wrap, [],[],1);
Screen('Flip',c.Window);
GetKey('g',[],[],-3);

DrawFormattedText(c.Window, ['Sometimes you will not know the probability of winning each sum. When you see a circle like this:'],c.hPosition/6,c.vPosition/8,250,wrap, [],[],1);
Screen('FillOval', c.Window, c.borderColor, [hSide1-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius+instrCircleVdisplace,hSide1+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius+instrCircleVdisplace])

Screen('FillOval', c.Window, [100 100 100], [hSide1, c.vPosition/2-c.radius+instrCircleVdisplace,hSide1+c.radius*2, c.vPosition/2+c.radius+instrCircleVdisplace])
Screen('DrawText', c.Window, '?', hSide1+c.radius, c.vPosition/2+instrCircleVdisplace, c.blackText);
Screen('DrawText', c.Window, ['$' num2str(35,'%#4.2f')], hSide1-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius*2+instrCircleVdisplace, c.textColor);
Screen('DrawText', c.Window, ['$' num2str(0,'%#4.2f')], hSide1+2*c.radius+c.radius*c.outerradius, c.vPosition/2+c.radius-c.radius*c.outerradius*2+instrCircleVdisplace, c.textColor);

DrawFormattedText(c.Window, ['If you choose this, you will have an unknown chance of winning $35 or $0.'],c.hPosition/6,18*c.vPosition/20,250,wrap, [],[],1);
DrawFormattedText(c.Window, ['Press ''g'' to continue.'],c.hPosition/6,19*c.vPosition/20,250,wrap, [],[],1);
Screen('Flip',c.Window);
GetKey('g',[],[],-3);

DrawFormattedText(c.Window, ['Out of the choices you make on this task, one will be chosen at random to count for real. \n\n'...
    'Please treat each choice as if it counts for real. Bear in mind that only ONE choice will be selected to count for real, '...
    'therefore treat each choice as if it were the only one being presented to you. \n\n'...
    'Please respond as quickly as possible, and try to go with your gut feeling. \n\n'...
    'Press ''g'' to begin.'],'center','center',250,wrap, [],[],2);
Screen('Flip',c.Window);
GetKey('g',[],[],-3);

fprintf('\n\nHuettel Risk/Ambiguity: \n\n')

datamat=[]; %where stuff is actually recorded

%% TASK PROPER

if scanner == 1
    % scanner trigger %%%
    while 1
        % AG1getKey('3#',-3); % deviceNumber -3 means query all
        [status, xx.startTime] = AG1startScan; % startTime corresponds to getSecs in startScan
        fprintf('Status = %d\n',status);
        if status == 0  % successful trigger otherwise try again
            break
        else
            %  Screen(Window,'DrawTexture',blank);
            message = 'Trigger failed, "3" to retry';
            DrawFormattedText(Window,message,'center','center',255);
            Screen(Window,'Flip');
        end
    end
    
elseif scanner == 0
    xx.startTime = GetSecs;
end

for n = 1:size(trialMat,1)
    opt1type = trialMat(n,xx.option1typeCol);
    opt1val1 = trialMat(n,xx.option1val1Col);
    opt1val2 = trialMat(n,xx.option1val2Col);
    opt1prob = trialMat(n,xx.option1probCol);
    opt2type = trialMat(n,xx.option2typeCol);
    opt2val1 = trialMat(n,xx.option2val1Col);
    opt2val2 = trialMat(n,xx.option2val2Col);
    opt2prob = trialMat(n,xx.option2probCol);
    data = HuettelTrial(c,xx,opt1type, opt1val1,opt1val2,opt1prob,opt2type, opt2val1,opt2val2,opt2prob);
    
    datamat = [datamat; data];
end

% calculate b and a
b = 1;
a = 1;


end

function data = HuettelTrial(c,xx,opt1type, opt1val1,opt1val2,opt1prob,opt2type, opt2val1,opt2val2,opt2prob)
data=[];

%randomize which side they see option 1 vs 2

sidePres = randi(2);
if sidePres==1
    hSide1=c.hPosL;
    hSide2=c.hPosR;
else
    hSide1=c.hPosR;
    hSide2=c.hPosL;
end
fprintf('\nopt1type: %g, opt1val1: %g, opt1val2: %g, opt1prob: %g\n', opt1type, opt1val1, opt1val2, opt1prob);
fprintf('opt2type: %g, opt2val1: %g, opt2val2: %g, opt2prob: %g\n', opt2type, opt2val1, opt2val2, opt2prob);

% %%%% draw choices %%%% %
% outer circles
Screen('FillOval', c.Window, c.borderColor, [c.hPosR-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosR+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])
Screen('FillOval', c.Window, c.borderColor, [c.hPosL-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosL+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])

% arcs for option 1
color1 = round(rand);
if opt1type == 1 % certain
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*0.8, c.vPosition/2, c.blackText);
elseif opt1type == 2 % risky
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt1prob*360, (1-opt1prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
elseif opt1type == 3 % ambig
    Screen('FillOval', c.Window, [100 100 100], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius])
    Screen('DrawText', c.Window, '?', hSide1+c.radius, c.vPosition/2, c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius*2, c.textColor);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+2*c.radius+c.radius*c.outerradius, c.vPosition/2+c.radius-c.radius*c.outerradius*2, c.textColor);
end

% arcs for option 2
color2 = round(rand);
if opt2type == 1 % certain
    Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*0.8, c.vPosition/2, c.blackText);
elseif opt2type == 2 % risky
    Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('FillArc', c.Window, [250*(1-color2) 250*color2 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], opt2prob*360, (1-opt2prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt2val2,'%#4.2f')], hSide2+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
elseif opt2type == 3 % ambig
    Screen('FillOval', c.Window, [100 100 100], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius])
    Screen('DrawText', c.Window, '?', hSide2+c.radius, c.vPosition/2, c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt2val2,'%#4.2f')], hSide2-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius*2, c.textColor);
    Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+2*c.radius+c.radius*c.outerradius, c.vPosition/2+c.radius-c.radius*c.outerradius*2, c.textColor);
end


Screen('DrawText', c.Window, 'Press ''f'' for the option on the left, ''j'' for the option on the right.', c.instr_X ,4*c.vPosition/5, c.textColor);

% record time after render but just before screen flip
ons_start = GetSecs;
nChoiceOnset = ons_start - xx.startTime;
fprintf('choice onset: %g \n', nChoiceOnset);


Screen('Flip',c.Window);
% Now collect a keypress from the user.
[testTrials.key testTrials.RT] = GetKey({'f','j'},[],[],-3);


fprintf('RT: %g, key: %s\n', testTrials.RT, testTrials.key);

if strcmp(testTrials.key,'f')
    hChosenSide = c.hPosL;
    hNotChosenSide = c.hPosR;
    if sidePres == 1
        chosenOption = 1;
    elseif sidePres == 2
        chosenOption = 2;
    end
elseif strcmp(testTrials.key,'j')
    hChosenSide = c.hPosR;
    hNotChosenSide = c.hPosL;
    if sidePres == 1
        chosenOption = 2;
    elseif sidePres == 2
        chosenOption = 1;
    end
end

fprintf('chose option: %g\n', chosenOption);
ons_start = GetSecs;
nChoiceMadeOnset = ons_start - xx.startTime;
fprintf('choice made: %g\n',nChoiceMadeOnset);

% %%%% delay %%%% %
% outer circles
Screen('FillOval', c.Window, c.borderColor, [c.hPosR-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosR+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])
Screen('FillOval', c.Window, c.borderColor, [c.hPosL-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosL+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])

% original choice circles
if opt1type == 1 % certain
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*0.8, c.vPosition/2, c.blackText);
elseif opt1type == 2 % risky
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt1prob*360, (1-opt1prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
elseif opt1type == 3 % ambig -- reveal
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt1prob*360, (1-opt1prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
end


if opt2type == 1 % certain
    Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*0.8, c.vPosition/2, c.blackText);
elseif opt2type == 2 % risky
    Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('FillArc', c.Window, [250*(1-color2) 250*color2 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], opt2prob*360, (1-opt2prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt2val2,'%#4.2f')], hSide2+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
elseif opt2type == 3 % ambig -- reveal
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide2, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide2, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt2prob*360, (1-opt2prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide2+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide2+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
end

% square to indicate chosen side
Screen('FrameRect', c.Window, [0 0 255], [hChosenSide-c.radius*c.outerradius*2, c.vPosition/2-c.radius-c.radius*c.outerradius*2,hChosenSide+c.radius*2+c.radius*c.outerradius*2, c.vPosition/2+c.radius+c.radius*c.outerradius*2],2)
Screen('Flip',c.Window);

if xx.debugFlag == 1
    WaitSecs(0);
else
    WaitSecs(2);
end

% %%%% wheel spin %%%% %
if xx.debugFlag == 1
    spinTime=1;
else
    spinTime = randi(3,1)*c.TR;
end

spinSpeedL = (rand*5+5)/360*pi; % random speed (range 5-10 degrees per frame)
spinStartL = rand*2*pi; % random starting position
spinSpeedR = (rand*5+5)/360*pi; % random speed (range 5-10 degrees per frame)
spinStartR = rand*2*pi; % random starting position
% Convert movieDuration in seconds to duration in frames to draw:
movieDurationFrames=round(spinTime * c.frameRate);
for frame = 1:movieDurationFrames
    % outer circles
    Screen('FillOval', c.Window, c.borderColor, [c.hPosR-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosR+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])
    Screen('FillOval', c.Window, c.borderColor, [c.hPosL-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosL+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])
    
    % square to indicate chosen side
    Screen('FrameRect', c.Window, [0 0 255], [hChosenSide-c.radius*c.outerradius*2, c.vPosition/2-c.radius-c.radius*c.outerradius*2,hChosenSide+c.radius*2+c.radius*c.outerradius*2, c.vPosition/2+c.radius+c.radius*c.outerradius*2],2)
    
    
    % original choice circles
    if opt1type == 1 % certain
        Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
        Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*0.8, c.vPosition/2, c.blackText);
    elseif opt1type == 2 % risky
        Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
        Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt1prob*360, (1-opt1prob)*360)
        Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
        Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
    elseif opt1type == 3 % ambig -- reveal
        Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
        Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt1prob*360, (1-opt1prob)*360)
        Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
        Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
    end
    
    
    if opt2type == 1 % certain
        Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
        Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*0.8, c.vPosition/2, c.blackText);
    elseif opt2type == 2 % risky
        Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
        Screen('FillArc', c.Window, [250*(1-color2) 250*color2 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], opt2prob*360, (1-opt2prob)*360)
        Screen('DrawText', c.Window, ['$' num2str(opt2val2,'%#4.2f')], hSide2+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
        Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
    elseif opt2type == 3 % ambig -- reveal
        Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide2, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
        Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide2, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt2prob*360, (1-opt2prob)*360)
        Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide2+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
        Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide2+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
    end
    
    
    
    currentAngleL = (spinStartL + spinSpeedL*(frame)*((movieDurationFrames-frame)/movieDurationFrames+1));
    currentXPosL = (c.radius+c.rouletteRadius)*sin(currentAngleL)+c.hPosL+c.radius;
    currentYPosL= (c.radius+c.rouletteRadius)*cos(currentAngleL)+c.vPosition/2;
    
    currentAngleR = pi-(spinStartR + spinSpeedR*(frame)*((movieDurationFrames-frame)/movieDurationFrames+1));
    currentXPosR = (c.radius+c.rouletteRadius)*sin(currentAngleR)+c.hPosR+c.radius;
    currentYPosR = (c.radius+c.rouletteRadius)*cos(currentAngleR)+c.vPosition/2;
    
    Screen('FillOval', c.Window, [0 0 0], [currentXPosL-c.rouletteRadius, currentYPosL-c.rouletteRadius,currentXPosL+c.rouletteRadius, currentYPosL+c.rouletteRadius])
    Screen('FillOval', c.Window, [0 0 0], [currentXPosR-c.rouletteRadius, currentYPosR-c.rouletteRadius,currentXPosR+c.rouletteRadius, currentYPosR+c.rouletteRadius])
    
    Screen('Flip',c.Window);
end

% outcome - the angle determines the amount (take last currentAngle)
% outer circles
Screen('FillOval', c.Window, c.borderColor, [c.hPosR-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosR+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])
Screen('FillOval', c.Window, c.borderColor, [c.hPosL-c.radius*c.outerradius, c.vPosition/2-c.radius-c.radius*c.outerradius,c.hPosL+c.radius*2+c.radius*c.outerradius, c.vPosition/2+c.radius+c.radius*c.outerradius])

% original choice circles
if opt1type == 1 % certain
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*0.8, c.vPosition/2, c.blackText);
elseif opt1type == 2 % risky
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt1prob*360, (1-opt1prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
elseif opt1type == 3 % ambig -- reveal
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt1prob*360)
    Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide1, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt1prob*360, (1-opt1prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide1+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide1+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt1prob-0.5)/0.25), c.blackText);
end


if opt2type == 1 % certain
    Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*0.8, c.vPosition/2, c.blackText);
elseif opt2type == 2 % risky
    Screen('FillArc', c.Window, [250*color2 250*(1-color2) 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('FillArc', c.Window, [250*(1-color2) 250*color2 0], [hSide2, c.vPosition/2-c.radius,hSide2+c.radius*2, c.vPosition/2+c.radius], opt2prob*360, (1-opt2prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt2val2,'%#4.2f')], hSide2+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt2val1,'%#4.2f')], hSide2+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
elseif opt2type == 3 % ambig -- reveal
    Screen('FillArc', c.Window, [250*color1 250*(1-color1) 0], [hSide2, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], 0, opt2prob*360)
    Screen('FillArc', c.Window, [250*(1-color1) 250*color1 0], [hSide2, c.vPosition/2-c.radius,hSide1+c.radius*2, c.vPosition/2+c.radius], opt2prob*360, (1-opt2prob)*360)
    Screen('DrawText', c.Window, ['$' num2str(opt1val2,'%#4.2f')], hSide2+0.8*c.radius/2, c.vPosition/2-0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
    Screen('DrawText', c.Window, ['$' num2str(opt1val1,'%#4.2f')], hSide2+c.radius*1.5*0.8, c.vPosition/2+0.7*c.radius/2*((opt2prob-0.5)/0.25), c.blackText);
end

% square to indicate chosen side
Screen('FrameRect', c.Window, [0 0 255], [hChosenSide-c.radius*c.outerradius*2, c.vPosition/2-c.radius-c.radius*c.outerradius*2,hChosenSide+c.radius*2+c.radius*c.outerradius*2, c.vPosition/2+c.radius+c.radius*c.outerradius*2],2)


Screen('FillOval', c.Window, [0 0 0], [currentXPosL-c.rouletteRadius, currentYPosL-c.rouletteRadius,currentXPosL+c.rouletteRadius, currentYPosL+c.rouletteRadius])
Screen('FillOval', c.Window, [0 0 0], [currentXPosR-c.rouletteRadius, currentYPosR-c.rouletteRadius,currentXPosR+c.rouletteRadius, currentYPosR+c.rouletteRadius])

% calculate and display outcome
% find angle of option 1 and 2 respectively
if sidePres == 1
    finalAngle1 = pi-rem(currentAngleL,2*pi);
    finalAngle2 = pi-(2*pi+rem(currentAngleR,2*pi));
elseif sidePres == 2
    finalAngle1 = pi-(2*pi+rem(currentAngleR,2*pi));
    finalAngle2 = pi-rem(currentAngleL,2*pi);
end

while finalAngle1 < 0
    finalAngle1 = finalAngle1+2*pi;
end
while finalAngle2 < 0
    finalAngle2 = finalAngle2+2*pi;
end

% option 1 outcome
if finalAngle1 > opt1prob*2*pi
    outcome1 = opt1val2;
else
    outcome1 = opt1val1;
end

fprintf('opt 1 angle: %g, prob: %g, side: %g \n', finalAngle1, opt1prob*2*pi,sidePres)
fprintf('opt 2 angle: %g, prob: %g, side: %g\n', finalAngle2, opt2prob*2*pi,sidePres)
%option 2 outcome
if finalAngle2 > opt2prob*2*pi
    outcome2 = opt2val2;
else
    outcome2 = opt2val1;
end


if chosenOption == 1
    outcomeVal = outcome1;
    nonChosenOutcomeVal = outcome2;
elseif chosenOption == 2
    outcomeVal = outcome2;
    nonChosenOutcomeVal = outcome1;
end



Screen('DrawText', c.Window, ['You won $' num2str(outcomeVal,'%#4.2f')], hChosenSide, 5*c.vPosition/6, c.textColor);
Screen('DrawText', c.Window, ['You could have won $' num2str(nonChosenOutcomeVal,'%#4.2f')], hNotChosenSide, 5*c.vPosition/6, c.textColor);

% save ITI just before screen flip...
fprintf('outcome: %g, non-chosen outcome: %g\n',outcomeVal,nonChosenOutcomeVal);
ons_start = GetSecs;
nOutcomeShown = ons_start - xx.startTime;
fprintf('outcome revealed: %g\n',nOutcomeShown);

Screen('Flip',c.Window);
if xx.debugFlag == 1
    GetKey({'f','j'},[],[],-3);
else
    WaitSecs(2);
end

% fixation
DrawFormattedText(c.Window, '+','center','center',250,100);
Screen('Flip',c.Window);
if xx.debugFlag==1
    ITI=0; % debug mode
else
    ITI = randi(3,1)*c.TR;
end
WaitSecs(ITI);

% store stuff
data(xx.option1typeCol) = opt1type;
data(xx.option1val1Col) = opt1val1;
data(xx.option1val2Col) = opt1val2;
data(xx.option1probCol) = opt1prob;

data(xx.option2typeCol) = opt2type;
data(xx.option2val1Col) = opt2val1;
data(xx.option2val2Col) = opt2val2;
data(xx.option2probCol) = opt2prob;

data(xx.choseCol) = chosenOption;
data(xx.outcomeCol) = outcomeVal;
data(xx.nonChosenOutcomeCol) = nonChosenOutcomeVal;

data(xx.choiceOnsetCol) = nChoiceOnset;
data(xx.choseOptionTimeCol) = nChoiceMadeOnset;
data(xx.outcomeShownCol) = nOutcomeShown;

data(xx.RTCol) = testTrials.RT;
data(xx.keyCol) = testTrials.key;

end