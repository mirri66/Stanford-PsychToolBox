% wrapper for Stanford PTB tasks

function wrapper()
clear;
clc;

PsychJavaTrouble
pwd
path.main = pwd;


exptname = 'stanfordPTB';

[pathstr,curr_dir,ext] = fileparts(pwd);
if ~strcmp(curr_dir,'Stanford-PsychToolBox')
    error('You must start the experiment from the Stanford-PsychToolBox directory. Go there and try again.\n');
end
javaaddpath('.');

% define and add standard paths 
path.data = fullfile(path.main, 'data');
path.diaries = fullfile(path.main, 'diaries');
path.stim = fullfile(path.main, 'functions/stim');
addpath(path.stim)
addpath(path.data)
addpath(path.diaries)

% 
% % specify experiment paths here
% path.SSRT = fullfile(path.main, 'stopsig_behav');
% path.expexp = fullfile(path.main, 'expexp');
% 
% % Add relevant paths for this experiment
% addpath(path.SSRT)
% addpath(path.expexp)

% start the experiment!
fprintf('Welcome!\n');
subjNo = input('What is the subject number? (0-99): ');

% extra inputs needed?
order = input('SSRT order? (1-4): ');

% check for existing file for that subject
cd(path.data);
    savename = [exptname num2str(subjNo) '.mat'];
if (exist(savename,'file'))>0
   cd(path.main)
   
   sca
   
end

% set up diary
diarySetup(path.diaries, [exptname num2str(subjNo)])

% %%%% run main tasks %%%% %
data = [];
c = exptSetup;
c.path = path;
% add session specific data
c.subjNo = subjNo;
c.exptname = exptname;

% % SSRT 
% cd(path.SSRT)
% stopbehavOSX_2stairs_GT(path, subjNo, order)
% 
% % expexp -tested
% cd(path.expexp)
% expexp(path,subjNo)

% % temporal discounting - unsorting is working
% [g, TDdata] = temporalDiscounting(c);

% BISBAS -- stanford PTB toolbox should be in path
%[BASDrive, BASFS, BASRewRes, BIS, rating] = BISBAS(c);

% Frost indecisiveness
%[frostScore, frostRating] = FrostIndecisiveness(c);


% Eriksen Flanker Task
% [EriksenData] = EriksenFT(c);
% data.EriksenFT = EriksenData;

% Go Nogo task
%[gonogoData] = gonogo(c);
%data.gonogo = gonogoData;
% 





% save data
%  data.g = g;
%  data.TDdata = TDdata;

% data.BASDrive = BASDrive;
% data.BASFS = BASFS;
% data.BASRewRes = BASRewRes;
% data.BIS = BIS;
% data.rating = rating;
% 
% data.frostScore = frostScore;
% data.frostRating = frostRating;




cd(path.data)
savename = [exptname num2str(subjNo) '_order' num2str(order) '.mat'];
save(savename, 'data');

ListenChar(0)
sca

end