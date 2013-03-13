% numberLikert
% ------------
% general 5 point numerical Likert scale
% usage: number = fivePtLikert(c,qnText,legend)
%
% arguments:
%  c      -- see exptSetup
%  qnText     -- question text
%  legend -- legend text
%
% output:
% number -- the number they pressed
%
% author: Grace (tsmgrace@gmail.com) 2012



function number = fivePtLikert(c,qnText,legend)

c.linestart=c.scrsz(3)/8;
c.lineend=(c.scrsz(3)*7)/8;
c.linelength=(c.lineend-c.linestart);



numberRater(c,qnText,legend);
Screen('Flip',c.Window);

number=[];
while true
    
    key = GetKey({'1!' '2@' '3#' '4$' '5%' 'g'},[],[],-3);
    
    
    if strcmp(key, '1!') || strcmp(key, '2@')|| strcmp(key, '3#') || strcmp(key, '4$') || strcmp(key, '5%')
        
        number=str2double(key(1));
        numberRater(c,qnText,legend);
        Screen('TextSize',c.Window,34);
        DrawFormattedText(c.Window, key(1),(c.linestart+(c.linelength)*(str2num(key(1))-1)/4),'center',[0 255 0]); %highlighting.. last variable is the color
        Screen('TextSize',c.Window,24);
        Screen('Flip',c.Window);
        
    elseif isempty(number) && strcmp(key,'g') %if they try to confirm before giving an actual answer...
        numberRater(c,qnText,legend);
        DrawFormattedText(c.Window, 'Please select a number from 1-5', 'center', (c.scrsz(4)/2+70),[255 0 0]);
        Screen('Flip',c.Window);
    elseif ~isempty(number) && strcmp(key, 'g') %they've given an answer and hit confirm - move to next trial
        break;
    end
    
end


end


function numberRater(c,qnText,legend) % draws and updates the screen elements
scaleNumber = 5; % 5 point scale

Screen('TextSize',c.Window,34);
DrawFormattedText(c.Window, qnText,'center',c.scrsz(4)/3,c.textColor);

%draw the scale
for x=1:scaleNumber
    DrawFormattedText(c.Window, num2str(x),(c.linestart+(c.linelength)*(x-1)/(scaleNumber-1)),'center',c.textColor);
end

% draw legend

Screen('TextSize',c.Window,24);
for y=1:length(legend)
    DrawFormattedText(c.Window, legend{y}, (c.linestart+(c.linelength)*(y-1)/(length(legend)-1))-150, (c.scrsz(4)/2+30),c.textColor);
end
%draw instruction
Screen('TextSize',c.Window,28);
DrawFormattedText(c.Window, 'Using the keyboard, select a number, then press ''g'' to confirm', 'center', (c.scrsz(4)/2+250),c.textColor);

end