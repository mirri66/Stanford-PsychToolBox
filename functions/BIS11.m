% BIS11 - Barratt Impulsivity Scale
% ---------------------------------
% presents the Barratt Impulsivity Scale, collects answers
% usage: [score, attn, motor, nonplan, rating] = BIS11(c)
%
% arguments:
%   c -- see exptSetup
%
% output:
%   score   -- total score
%   attn    -- subscore for attention
%   motor   -- subscore for motor
%   nonplan -- subscore for non planning
%   rating -- raw ratings (the numbers they chose for each)
%
% reference: Factor structure of the Barratt impulsiveness scale. Patton JH, Stanford MS, and Barratt ES (1995)
% Journal of Clinical Psychology, 51, 768-774.
% http://www.impulsivity.org/measurement/bis11
%
% author: Grace (tsmgrace@gmail.com) 2012


function [score, attn, motor, nonplan, rating] = BIS11(c)

fprintf('\n\nBIS11: \n\n')

Screen('TextSize',c.Window,24);

instr=['DIRECTIONS: People differ in the ways they act and think in different situations. '...
    'This is a test to measure some of the ways in which you act and think. '...
    'Read each statement and select the appropriate answer. '...
    'Do not spend too much time on any statement. Answer quickly and honestly.\n\n'...
    'Press ''g'' to continue.'];

qnArr = {
    'I plan tasks carefully.',
    'I do things without thinking.',
    'I make up my mind quickly.',
    'I am happy-go-lucky.',
    'I don''t "pay attention".',
    'I have "racing" thoughts.',
    'I plan trips well ahead of time.',
    'I am self controlled.',
    'I concentrate easily.',
    'I save regularly.',
    'I "squirm" at plays or lectures.',
    'I am a careful thinker.',
    'I plan for job security.',
    'I say things without thinking.',
    'I like to think about complex problems.',
    'I change jobs.',
    'I act "on impulse".',
    'I get easily bored when solving thought problems.',
    'I act on the spur of the moment.',
    'I am a steady thinker.',
    'I change residences.',
    'I buy things on impulse.',
    'I can only think about one thing at a time.',
    'I change hobbies.',
    'I spend or charge more than I earn.',
    'I often have extraneous thoughts when thinking.',
    'I am more interested in the present than the future.',
    'I am restless at the theater or lectures.',
    'I like puzzles.',
    'I am future oriented.'
    };

legend={'    Rarely/Never','     Occasionally','              Often','Almost Always/Always'};

% show instructions
DrawFormattedText(c.Window, instr,'center','center',255,100,[],[],2);
Screen('Flip',c.Window);
GetKey('g',[],[],-3);


% get responses
rating=[]; % initialize
for qn = 1:length(qnArr)
    
    rating(qn) = fourPtLikert(c,qnArr{qn},legend);
    fprintf('Qn %g rating: %g \n', qn, rating(qn))
end

% compute score

reverseArr = [1 7 8 9 10 12 13 15 20 29 30];
attnArr = [5 6 9 11 20 24 26 28];
motorArr = [2 3 4 16 17 19 21 22 23 25 30];
nonplanArr = [1 7 8 10 12 13 14 15 18 27 29];

score = 0; % initialize
attn = 0; % attention subscore
motor = 0;
nonplan = 0;

for i = 1:30
    if ismember(i, reverseArr)
        score = score + (5-rating(i));
        if ismember(i, attnArr)
            attn = attn + (5-rating(i));
        elseif ismember(i, motorArr)
            motor = motor + (5-rating(i));
        elseif ismember(i, nonplanArr)
            nonplan = nonplan + (5-rating(i));
        end
    else
        score = score + rating(i);
        if ismember(i, attnArr)
            attn = attn + rating(i);
        elseif ismember(i, motorArr)
            motor = motor + rating(i);
        elseif ismember(i, nonplanArr)
            nonplan = nonplan + rating(i);
        end
    end
end



savename = [c.exptname num2str(c.subjNo)'_BIS11.mat'];
save(savename,'score', 'attn', 'motor', 'nonplan', 'rating');

end