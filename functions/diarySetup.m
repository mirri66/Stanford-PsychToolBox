% diarySetup
%
%   Starts a diary. If diary by the same name already exists, appends a
%   version number to the end of the filename so previous diary is not
%   overwritten.
%
%   ARGUMENTS:
%
%   path_to_diaries = Where you want your diary files stored
%   diary_file_name = desired name of diary file
%
%   2012 -- Grace Tang, tsmgrace@gmail.com


function diarySetup(path_to_diaries, diary_file_name)

orig_path = pwd;
% diary
cd(path_to_diaries);
nD=0;
while exist(diary_file_name)
    nD = nD+1;
    diary_file_name = [diary_file_name '_' num2str(nD)];
end
diary(diary_file_name);

cd(orig_path)
end