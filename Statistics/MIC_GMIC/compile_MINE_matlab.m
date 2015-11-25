clc;

disp('Compilation via MEX of MINE source code written in C for MIC and GMIC');
disp('Compiling..');
mex mine_mex.c ./libmine/mine.c
disp('Done.');
