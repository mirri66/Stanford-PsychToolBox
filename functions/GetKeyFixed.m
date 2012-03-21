function [key,latency] = GetKeyFixed(keyStrings, deadline, startTime, deviceNum)
% %GetKey.m  Waits for any of a group of keys to be pressed.
% %Usage [key,latency] = GetKey({'a','z'},5.000,GetSecs,[])
%
% %keyStrings = a single key name ('a') or a cell array of key names ({'a','b'}) 
% %GetKey will only respond to keys in keyStrings, or any key if keystrings is empty.
% %use KbName to find names of keys.
%
% %deadline is the max amount of time GetKey will wait for a response.
% %(relative to startTime.)
% %GetKey will wait forever if deadine is empty.
% %if deadline is reached, key and latency are set to NaN
%
% %startTime can be used to specify a more accurate stimulus onset time.
% %if it is not given or empty, RT is calculated from the beginning of calling GetKey
%
% %deviceNum can be used if there are multple keyboards/buttonboxes attached on OSX
%
% %Examples:
% [key rt] = GetKey('space') %waits forever for spacebar press
% [key rt] = GetKey([],.5) %waits half a second for any key
% [key rt] = GetKey({'a','b'},2,GetSecs) %gives 2 seconds to hit 'a' or 'b' 
% %Returns the key pressed, and the time between "startTime" and when the 
% %key was pressed. Cuts off when deadline is reached.
%
% %Useful for measuring reaction times
% %Also only permits one key to be registered at a time.

% 2007/11/14 ADN rewrote it.
% 2009/01/31 added deviceNum. might be necessary with button boxes on OSX.
%
% 2012      Modified by Kiefer Katovich -- it doesn't freeze the slide
%           when people hold down a button prior to when GetKey is called.
%           This is usually not a problem but can really screw up
%           time-sensitive experiments.
%           Use the same as you would normally use GetKey original.

funstart = GetSecs();

if nargin<4 || isempty(deviceNum)
    deviceNum=[];
end

[keyIsDown,press_time,keyArr] = KbCheck(deviceNum);
keyListCoded = zeros(size(keyArr));

if keyIsDown
    while KbCheck(deviceNum) && ((GetSecs()-funstart) < deadline)
        WaitSecs(.001); 
    end
end

if nargin<1 || isempty(keyStrings)
    keyListCoded = 1-keyListCoded;
else
    keyListCoded(KbName(keyStrings)) = 1;
end

if nargin<2 || isempty(deadline)
    deadline = [];
end

if nargin<3 || isempty(startTime)
    startTime = press_time;
end



% Check for keypress.
keepChecking = 1;

%while (keepChecking && (isempty(deadline) || press_time<(startTime+deadline)))
while (keepChecking && (isempty(deadline) || (GetSecs()-funstart) < deadline))
    %poll the keyboard.
    [keyIsDown,press_time,keyArr] = KbCheck(deviceNum);
    %check if exactly one of the right keys is down.
    keepChecking = 1-(keyIsDown && (sum(keyListCoded.*double(keyArr))==1));
    %don't flood the system
    WaitSecs(.001);
end

%Done. Process results.

if keepChecking
    key = NaN;
    latency = NaN;
else
    key = KbName(find(keyArr));
    latency = press_time - startTime;
end



