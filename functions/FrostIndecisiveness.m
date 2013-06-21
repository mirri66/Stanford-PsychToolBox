% FrostIndecisiveness - Frost Indecisiveness Scale
% ---------------------------------
% presents the Frost Indecisiveness scale, collects answers
% usage: [score] = FrostIndecisiveness(c)
%
% arguments:
%   c -- see exptSetup
%
% output:
%   
% score -- total score
%
% reference: Frost, R. O., & Shows, D. L. (1993). The nature and
% measurement of compulsive indecisiveness. Behaviour Research and Therapy, 31(7), 683-692.
% http://www.sjdm.org/dmidi/Indecisiveness_Scale.html#Description 
%
% author: Grace (tsmgrace@gmail.com) 2013


function [score, rating] = FrostIndecisiveness(c)
Screen('TextSize',c.Window,24);

instr=['Each item of this questionnaire is a statement that a person may either agree with or disagree with.  \n' ...
    'For each item, indicate how much you agree or disagree with what the item says. \n' ...
    'Please respond to all the items; do not leave any blank.  Choose only one response to each statement. \n' ...
    'Please be as accurate and honest as you can be.  Respond to each item as if it were the only item.  \n' ...
    'That is, don''t worry about being "consistent" in your responses. \n\n' ...
    'Press ''g'' to continue.'];

qnArr = {
    'I try to put off making decisions.',
    'I always know exactly what I want.',
    'I find it easy to make decisions.',
    'I have a hard time planning my free time.',
    'I like to be in a position to make decisions.',
    'Once I make a decision, I feel fairly confident that it is a good one.',
    'When ordering from a menu, I usually find it difficult to decide what to get.',
    'I usually make decisions quickly.',
    'Once I make a decision, I stop worrying about it.',
    'I become anxious when making a decision.',
    'I often worry about making the wrong choice.',
    'After I have chosen or decided something, I often believe I''ve made the wrong choice or decision.',
    'I do not get assignments done on time because I cannot decide what to do first.',
    'I have trouble completing assignments because I can''t prioritize what is most important.',
    'It seems that deciding on the most trivial thing takes me a long time.',
    };

legend={'Strongly disagree',' ',' ',' ','Strongly agree'};

fprintf('\n\nFrost Indecisiveness Scale\n\n')

% show instructions
DrawFormattedText(c.Window, instr,'center','center',255,100,[],[],2);
Screen('Flip',c.Window);
GetKey('g',[],[],-3);


% get responses
rating=[]; % initialize
for qn = 1:length(qnArr)
    
    rating(qn) = fivePtLikert(c,qnArr{qn},legend);
     fprintf('Qn %g rating: %g \n', qn, rating(qn))
end

 fprintf('\n\n')
% compute score

reverseArr = [2 3 5 6 8 9];

score = 0;

for i = 1:length(qnArr)
    if ismember(i, reverseArr)
       score = score + (6-rating(i));
        
    else
        score = score + rating(i);

    end
end
fprintf('score: %g\n', score)

savename = [c.exptname num2str(c.subjNo) '_FrostIndecisiveness.mat'];
save(savename, 'score','rating');

end