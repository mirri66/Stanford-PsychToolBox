% this function is called by circleLikert... see help for that instead

function circleRater(c,bottomtext,scaletext,colors,Window,scanner) % k= which dimension you are measuring, e.g. valence = 1
% draw question
Screen('TextSize',Window,34);
DrawFormattedText(Window, bottomtext,'center',c.qnHeight,c.textColor);

rects=[];


%determine position of circles
for x=1:c.numEls
    centerX = c.linestart+c.circleSep*(x-1);
    rects(1,x) = centerX-c.radius;
    rects(2,x) = c.height-c.radius;
    rects(3,x) = centerX+c.radius;
    rects(4,x)= c.height+c.radius;
    
end

% draw circles
Screen('FillOval', Window, colors, rects);

% draw slider
c.slideposX = (c.slidepos-1)*c.circleSep + c.linestart;
Screen('FillOval', Window, [0 0 0], [c.slideposX-c.slideRadius, c.height-c.slideRadius, c.slideposX+c.slideRadius, c.height+c.slideRadius]);


% draw legend
scalekey=scaletext;  % extra spaces so they spread out evenly
for y=1:3
    DrawFormattedText(Window, scalekey{y}, (c.linestart+(c.linelength)*(y-1)/2)-180, c.scaleHeight,c.textColor);
end
%draw instruction
Screen('TextSize',Window,28);
if scanner==1
DrawFormattedText(Window, 'Move the indicator with ''1'' and ''2'', then press ''3'' to confirm', 'center', c.instrHeight,c.textColor);
else
DrawFormattedText(Window, 'Move the indicator with the arrow keys, then press ''g'' to confirm', 'center', c.instrHeight,c.textColor);
end
Screen('Flip',Window);
end

