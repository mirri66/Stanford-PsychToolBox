Stanford-PsychToolBox
=====================

Functions for use with PsychToolBox experiments in Matlab
---------------------------------------------------------

To use these functions, download and add the functions folder to your search path with the 'addpath' function

It might be useful to add a line like this to your startup.m file if you don't want to have to add the path every time you run your experiment:
addpath('PATH/TO/Stanford-PsychToolBox/functions/');

All the functions can be called with the example wrapper script (wrapper.m).
Add and remove functions as needed from this wrapper script.
Results will be stored in a folder called 'data'. Console output will be saved in the 'diaries' folder. Make sure you have created these folders.

Software
--------
These functions run in Matlab, with Psychtoolbox.
PsychToolBox is available at psychtoolbox.org

Functions
---------

Basic:
Four/Five point likert
IterativeCSVWriter - saves each trial of experiments to a csv file
circle likert scale - a likert scale, but with circles vs just plain numbers
diarysetup - saves console output
GetKey - makes kbcheck easier to use for collecting responses
GTgetechostring (same as PTB's getechostring, but fixed some bugs)

Tasks:
Temporal discounting
Huettel risk/ambiguity task

Questionnaires:
BIS11
BISBAS
Frost Indecisiveness
