% circleLikert
% -----------
% usage:  rating=circleLikert(c,[bottomtext],[scaletext],[colors],[slideposinit],[scanner])
% Nine-point likert scale
%
% inputs:
% - c:           see exptSetup.m ... contains graphics (Window and screen) variables
% optional:
% - bottomtext:    question text.. default blank
% - scaletext: a array of three strings, one for beginning, middle and end
% of scale. Default = blank
% - colors:  a vector of color values - default = rainbow
% - slideposinit: where should the cursor start? default = 5 (the middle)
% - scanner: if set to 1, keys are 1,2 and 3 instead of arrow keys and g
% outputs
% - rating: integer value representing position on scale that was selected
%
% Author: Grace Tang, tsmgrace@gmail.com, 2013


function rating=circleLikert(c,varargin)

if nargin>=2
    bottomtext = varargin{1};
    if nargin>=3
        scaletext = varargin{2};
        if nargin>=4
            colors = varargin{3};
            if nargin>=5
                slideposinit = varargin{4};
                if nargin>=6
                    scanner = varargin{5};
                else
                    scanner = 0;
                end
            else
                slideposinit = 5;
            end
        else
            colors = [[255 75 25];[255 100 50];[255 150 50];[245 165 79];[245 245 220];[150 150 255];[100 100 255];[50 50 255];[0 0 255]]';
            slideposinit = 5;
        end
        
    else
        scaletext = {'','',''};
        colors = [[255 75 25];[255 100 50];[255 150 50];[245 165 79];[245 245 220];[150 150 255];[100 100 255];[50 50 255];[0 0 255]]';
        slideposinit = 5;
    end
else
    bottomtext = '';
    scaletext = {'','',''};
    colors = [[255 75 25];[255 100 50];[255 150 50];[245 165 79];[245 245 220];[150 150 255];[100 100 255];[50 50 255];[0 0 255]]';
    slideposinit = 5;
end

c.slidepos =slideposinit;

%slider bar stuff
c.linestart=c.scrsz(3)/8;
c.lineend=(c.scrsz(3)*7)/8;
c.linelength=(c.lineend-c.linestart);

% circle rater stuff
c.numEls = 9; % number of elements on the scale... e.g. for a 1-7 scale, enter 7
c.radius = c.scrsz(4)/20;
c.side = c.scrsz(4)/20;
c.height = 3*c.scrsz(4)/6;
c.circleSep = (c.linelength)/(c.numEls-1);

% circle slider
c.slideRadius = 2*c.radius/3;
c.slidePosInit(1) = round(c.numEls/2); % choose starting point depending on condition
c.slidePosInit(2) = 9;

% text heights
c.qnHeight = 2*c.scrsz(4)/6;
c.scaleHeight = 4*c.scrsz(4)/6;
c.instrHeight = 5*c.scrsz(4)/6;

circleRater(c,bottomtext,scaletext,colors,c.Window,scanner);


while true
    if scanner==1
        key = GetKey({'1!' '2@' '3#'},[],[],-3);
        if sum(strcmp(key, '2@'))>0 && c.slidepos < c.numEls
            c.slidepos = c.slidepos + 1;
            circleRater(c,bottomtext,scaletext,colors,c.Window,scanner);
            
        elseif sum(strcmp(key, '1!'))>0 && c.slidepos > 1
            c.slidepos = c.slidepos - 1;
            circleRater(c,bottomtext,scaletext,colors,c.Window,scanner);
            
        elseif sum(strcmp(key, '3#'))>0
            
            rating=c.slidepos;
            break;
        end
    else
        key = GetKey({'RightArrow' 'LeftArrow' 'g'},[],[],-3);
        if sum(strcmp(key, 'RightArrow'))>0 && c.slidepos < c.numEls
            c.slidepos = c.slidepos + 1;
            circleRater(c,bottomtext,scaletext,colors,c.Window,scanner);
            
        elseif sum(strcmp(key, 'LeftArrow'))>0 && c.slidepos > 1
            c.slidepos = c.slidepos - 1;
            circleRater(c,bottomtext,scaletext,colors,c.Window,scanner);
            
        elseif sum(strcmp(key, 'g'))>0
            
            rating=c.slidepos;
            break;
        end
    end
    
end
end