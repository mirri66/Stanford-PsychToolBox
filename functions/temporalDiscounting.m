% temporalDiscounting
% ---------------------------------
% presents a number of choices with various k values
% usage: k = temporalDiscounting(c)
%
% arguments:
%   c -- see exptSetup
%
% output:
%   g -  k value etc
%   datamat -  details of individual choices
%
% author: Grace (tsmgrace@gmail.com) 2013


function [g, datamat] = temporalDiscounting(c)

csvfile = [c.exptname num2str(c.subjNo) '_TD.csv'];

% override exptSetup here
Screen('TextSize',c.Window,round(c.scrsz(3)/50));


% some constants for storing data
xx.choseLateCol = 1;
xx.lateCol = 2;
xx.soonCol = 3;
xx.delayCol = 4;
xx.keyCol=5;
xx.RTCol=6;
xx.idxCol=7;

% additional graphics stuff
c.hPosR = 3*c.scrsz(3)/5;
c.hPosL = c.scrsz(3)/5;
c.hPosition = c.scrsz(3);
c.vPosition = c.scrsz(4);
c.instr_X = c.scrsz(3)/3.5;


% choices


delayMatrix=[19	20	200
    10	11	189
    18  20  197
    11	12	147
    9	10	145
    14	15	83
    6	7	163
    5	6	180
    11	12	55
    6	8	169
    4	5	124
    4	6	200
    10	12	81
    5	6	73
    4	5	77
    9	12	76
    4	5	48
    8	11	56
    6	12	136
    7	10	27
    10	15	27
    4	7	26
    6	14	36
    8	15	18
    5	10	19
    2	5	17
    5	12	13
    3	7	12
    3	6	6
    6	14	6
    2	8	13
    4	10	6];

choiceArr = 1:size(delayMatrix,1);
orderedChoiceArr = Shuffle(choiceArr);


ListenChar(2) %Ctrl-c to enable Matlab keyboard interaction.
HideCursor; % Remember to type ShowCursor or sca later


%% the study::

% Instructions
DrawFormattedText(c.Window, ['In this task, you will be asked to indicate your preference between two sums of money available at various delays. Out of the choices you make on this task, ' ...
    'one will be chosen at random to count for real. You will be given a check for the resulting sum, post-dated appropriately (If there is a delay, you will only be able to cash your check after the delay has passed). \n\n'...
    'Please treat each choice as if it counts for real. Bear in mind that only ONE choice will be selected to count for real, therefore treat each choice as if it were the only one being presented to you. \n\n'...
    'Please respond as quickly as possible, and try to go with your gut feeling. \n\n'...
    'Press ''3'' to begin.'],'center','center',255,100, [],[],2);
Screen('Flip',c.Window);
GetKey('3#',[],[],-3);

fprintf('\n\nTemporal Discounting: \n\n')
fprintf('Start time: %s\n\n', datestr(clock))

datamat=[]; %where stuff is actually recorded


%% TASK PROPER

for m = 1:size(delayMatrix,1)
    idx = orderedChoiceArr(m);
%     %black screen - ITI
%     ITI=0;
%     DrawFormattedText(c.Window, 'X','center','center',255,100);
%     Screen('Flip',c.Window);
%     WaitSecs(ITI);
    
    % present delay choice
    nSoon = delayMatrix(idx,1);
    nLate = delayMatrix(idx,2);
    delay = delayMatrix(idx,3);
    [data, testTrials]=temporalTrials(c, nSoon, nLate, delay, xx);
    
    
    % record info for trial
    datamat(m,xx.choseLateCol)=data(xx.choseLateCol);
    datamat(m,xx.lateCol)=data(xx.lateCol);
    datamat(m,xx.soonCol)=data(xx.soonCol);
    datamat(m,xx.delayCol)=data(xx.delayCol);
    datamat(m,xx.keyCol)=testTrials.key;
    datamat(m,xx.RTCol)=testTrials.RT;
    datamat(m,xx.idxCol)=idx;
    
    % save per trial
    fprintf('%g %g %g %g %g %g %g\n',datamat(m,:));
       csvrow= {data(1), data(2),data(3), data(4), data(5), data(6), data(7) };
      IterativeCSVWriter(c.path.data, csvfile, csvrow);

end

cd(c.path.data)
savename = [c.exptname num2str(c.subjNo) '_TD.mat'];
save(savename, 'datamat','g');
cd(c.path.main)

% unshuffle choices
choices = repmat(2,length(orderedChoiceArr),1);
for i = 1:length(orderedChoiceArr)
   choices(orderedChoiceArr(i)) =  datamat(i,xx.choseLateCol);
end

fprintf('choices: ')
fprintf('%g ', choices)


DrawFormattedText(c.Window, ['Take a short break!'],'center','center',255,100, [],[],2);
Screen('Flip',c.Window);
% calculate k
g =  TD_baseline_parse(choices);

end


%DEBUG
function [data, testTrials] = temporalTrials(c, nSoon, nLate, delay, xx)

data = []; % temp placeholder for this subfunction, will be transferred to datamat

%randomize which side they see the late vs soon rewards - CHECK!!

sidePres = randi(2);

if sidePres==1
    hSideS=c.hPosL;
    hSideL=c.hPosR;
else
    hSideS=c.hPosR;
    hSideL=c.hPosL;
end

% record delay + values

data(xx.lateCol)=nLate;
data(xx.soonCol)=nSoon;
data(xx.delayCol)=delay;

fprintf('\n Soon: $%g \nLate: $%g \nDelay: $%g \n', nSoon, nLate, delay)


% draw
fprintf('$%g in %g days vs %g now\n',nLate, delay, nSoon)
Screen('DrawText', c.Window, ['$' num2str(nLate,'%#4.2f') ' in ' num2str(delay) ' days'], hSideL, c.vPosition/2, c.textColor);
Screen('DrawText', c.Window, ['$' num2str(nSoon,'%#4.2f') ' now'], hSideS, c.vPosition/2, c.textColor);
Screen('DrawText', c.Window, 'Press ''1'' for the option on the left, ''4'' for the option on the right.', c.instr_X ,2*c.vPosition/3, c.textColor);
Screen('Flip',c.Window);
% Now collect a keypress from the user.
[testTrials.key testTrials.RT] = GetKey({'1!','4$'},[],[],-3);


fprintf('RT: testTrials.RT\n')


DrawFormattedText(c.Window, '+','center','center',255,100);
Screen('Flip',c.Window);


% record choice -- AND UPDATE K range HERE!!
if testTrials.key=='1!'&& sidePres==2  || testTrials.key=='4$'&& sidePres==1 
    data(xx.choseLateCol)=1;
    fprintf('chose later option\n\n')
    
elseif testTrials.key=='1!' && sidePres==1 || testTrials.key=='4$' && sidePres==2
    data(xx.choseLateCol)=0;
    fprintf('chose immediate option\n\n')
end
end
