clc;

disp('Compilation via MEX of Kraskov kNN MI source code written in C++');
disp('Compiling..');
mex MI_Kraskov_mex.cpp miutils.cpp
disp('Done.');
