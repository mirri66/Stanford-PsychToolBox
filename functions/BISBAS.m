% BISBAS - Behavioral Inhibition System /  Behavioral Approach System
% ---------------------------------
% presents the BIS/BAS scales, collects answers
% usage: [BASDrive, BASFS, BASRewRes, BIS, rating] = BISBAS(c)
%
% arguments:
%   c -- see exptSetup
%
% output:
%
%   BASDrive   -- subscore for drive
%   BASFS   -- subscore for fun seeking
%   BASRewRes -- subscore for reward responsiveness
%   rating -- raw ratings (the numbers they chose for each)
%
% reference: Carver, C. S., & White, T. L. (1994). Behavioral inhibition,
% behavioral activation, and affective responses to impending reward and punishment:
% The BIS/BAS scales. Journal of Personality and Social Psychology, 67, 319-333
% http://www.psy.miami.edu/faculty/ccarver/sclBISBAS.html
%
% author: Grace (tsmgrace@gmail.com) 2013


function [BASDrive, BASFS, BASRewRes, BIS, rating] = BISBAS(c)
Screen('TextSize',c.Window,24);

instr=['Each item of this questionnaire is a statement that a person may either agree with or disagree with. ' ...
    'For each item, indicate how much you agree or disagree with what the item says. \n' ...
    'Please respond to all the items; do not leave any blank.  Choose only one response to each statement. ' ...
    'Please be as accurate and honest as you can be.  Respond to each item as if it were the only item.  \n' ...
    'That is, don''t worry about being "consistent" in your responses.  Choose from the following four response options: \n\n' ...
    '1 = very true for me\n' ...
    '2 = somewhat true for me\n' ...
    '3 = somewhat false for me\n' ...
    '4 = very false for me\n' ...
    'Press ''g'' to continue.'];

qnArr = {
    'A person''s family is the most important thing in life.',
    'Even if something bad is about to happen to me, I rarely experience fear or nervousness.',
    'I go out of my way to get things I want.',
    'When I''m doing well at something I love to keep at it. ',
    'I''m always willing to try something new if I think it will be fun.',
    'How I dress is important to me. ',
    'When I get something I want, I feel excited and energized. ',
    'Criticism or scolding hurts me quite a bit.'
    'When I want something I usually go all-out to get it. ',
    'I will often do things for no other reason than that they might be fun.',
    'It''s hard for me to find the time to do things such as get a haircut. ',
    'If I see a chance to get something I want I move on it right away. ',
    'I feel pretty worried or upset when I think or know somebody is angry at me. ',
    'When I see an opportunity for something I like I get excited right away. ',
    'I often act on the spur of the moment. ',
    'If I think something unpleasant is going to happen I usually get pretty "worked up." ',
    'I often wonder why people act the way they do. ',
    'When good things happen to me, it affects me strongly. ',
    'I feel worried when I think I have done poorly at something important. ',
    'I crave excitement and new sensations.',
    'When I go after something I use a "no holds barred" approach. ',
    'I have very few fears compared to my friends. ',
    'It would excite me to win a contest. ',
    'I worry about making mistakes. ',
    };

legend={'           Very true for me','       Somewhat true for me','       Somewhat false for me','           Very false for me'};

% show instructions
DrawFormattedText(c.Window, instr,'center','center',255,100,[],[],2);
Screen('Flip',c.Window);
GetKey('g',[],[],-3);

fprintf('\n\nBISBAS: \n\n')

% get responses
rating=[]; % initialize
for qn = 1:length(qnArr)
    
    rating(qn) = fourPtLikert(c,qnArr{qn},legend);
    fprintf('Qn %g rating: %g \n', qn, rating(qn))
end

fprintf('\n')
% compute score

reverseArr = [1 3:21 23:24];
BASDriveArr = [3 9 12 21];
BASFSArr = [5 10 15 20];
BASRewResArr = [4 7 14 18 23];
BISArr = [2 8 13 16 19 22 24];

BASDrive = 0; %  subscore
BASFS = 0;
BASRewRes = 0;
BIS = 0;

for i = 1:length(qnArr)
    if ismember(i, reverseArr)
        
        if ismember(i, BASDriveArr)
            BASDrive = BASDrive + (5-rating(i));
        elseif ismember(i, BASFSArr)
            BASFS = BASFS + (5-rating(i));
        elseif ismember(i, BASRewResArr)
            BASRewRes = BASRewRes + (5-rating(i));
        elseif ismember(i, BISArr)
            BIS = BIS + (5-rating(i));
        end
    else
        
        if ismember(i, BASDriveArr)
            BASDrive = BASDrive + rating(i);
        elseif ismember(i, BASFSArr)
            BASFS = BASFS + rating(i);
        elseif ismember(i, BASRewResArr)
            BASRewRes = BASRewRes + rating(i);
        elseif ismember(i, BISArr)
            BIS = BIS + rating(i);
        end
    end
end

fprintf('BASDrive: %g\n', BASDrive)
fprintf('BASFS: %g\n', BASFS)
fprintf('BASRewRes: %g\n', BASRewRes)
fprintf('BIS: %g\n', BIS)

end