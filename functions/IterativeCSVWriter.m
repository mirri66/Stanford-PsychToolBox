% IterativeCSVWriter
%
% Takes in the data at intervals and writes it to the file using another 
% function PartialDataWriter that is an overhauled cell2csv
%
% ARGUMENTS:
%
%   data_filepath   = the path in which the data is to be stored
%   filename        = the name of the csv file to be written/appended to
%   rows            = a cellarray that contains the rows to be written
%
% 2012 -- Kiefer Katovich


function IterativeCSVWriter(data_filepath, filename, rows)

    % prepare the cellarray of data for csv writing:
    cellout = {};
    
    rows_size = size(rows);
    
    for i = 1:rows_size(1)
        for j = 1:rows_size(2)
            cellout{i,j} = num2str(rows{i,j});
        end
    end


    % Use PartialDataWriter to write the file to a new or already existing
    % file:
    PartialDataWriter(filename,cellout,filepath,',');
    

end





function PartialDataWriter(datName,cellArray,datapath,seperator)
%
% Overhauled/Cannibalized code from cell2csv to make a partial data writer
% that is useful for saving data after each trial rather than just at the
% end of the experiment.
%
% This way at least some data is preserved even if the experiment crashes
% or is cancelled.
%
% Arguments:
%
% datName: The string name of the new or currently used csv.
%
% cellArray: the partial data "row" that will be written for this call to
% the function. Input the csv header when you first call the function.
%
% datapath: the path to where the subject data should be stored
%
% seperator: defaults to a comma ','. You don't need to input this variable
% if you just want it to be a comma.
%
% 
% Kiefer Katovich 08.18.11

    if nargin > 4 || nargin < 2
        error('PartialDataWriter takes 2 to 4 input arguments; you should probably read the code');
    end

    if nargin < 4
        seperator = ',';
    end

    if nargin < 3
        datapath = pwd;
    end

    if ~ischar(datName) || ~iscell(cellArray) || ~ischar(datapath) || ~ischar(seperator)
        error(['Incorrect argument data type for an argument. Should be: char,cellarray,char,char\n\n' ...
            'Or, more explicitly: Name of csv, data row to write, file path to write data, seperator character']);
    end

    currentdir = pwd;
    cd(datapath);

    datei = fopen(datName,'a');

    for z=1:size(cellArray,1)
        for s=1:size(cellArray,2)

            var = eval(['cellArray{z,s}']);

            if size(var,1) == 0
                var = '';
            end

            if isnumeric(var) == 1
                var = num2str(var);
            end

            if islogical(var) == 1
                if var == 1
                    var = 'TRUE';
                else
                    var = 'FALSE';
                end
            end

            fprintf(datei,var);

            if s ~= size(cellArray,2)
                fprintf(datei,seperator);
            end
        end
        fprintf(datei,'\n');
    end

    fclose(datei);

    cd(currentdir);
    
end



