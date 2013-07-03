% helper function for temporalDiscounting.m
% data = one column of subjects's answers

function g = TD_baseline_parse(data)

% new delay matrix, with delay capped at 200 and LL capped at 20
delayMatrix=[19	20	200
10	11	189
18  20  197
11	12	147
9	10	145
14	15	83
6	7	163
5	6	180
11	12	55
6	8	169
4	5	124 
4	6	200
10	12	81
5	6	73
4	5	77
9	12	76
4	5	48
8	11	56
6	12	136
7	10	27
10	15	27
4	7	26
6	14	36
8	15	18
5	10	19
2	5	17
5	12	13
3	7	12
3	6	6
6	14	6
2	8	13
4	10	6];

block1=[];


    subjData = cat(2,data,delayMatrix(:,1:2));
    % MLE_estimation stuff:
    
    cd ..

    [g] = MLE_estimation_Kval(subjData,delayMatrix(:,3));

 
    clear subjData;


end
