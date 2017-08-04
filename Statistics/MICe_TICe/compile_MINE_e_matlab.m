clc;

disp('Compilation via MEX of MINE source code written in C for MIC_e and TIC_e');
disp('Compiling..');
mex mine_e_mex.c ./libmine/mine.c
disp('Done.');
