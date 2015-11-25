clc;

disp('Compilation via MEX of MID source code written in C');
disp('Compiling..');
mex MID_mex.c MID.c
disp('Done.');
