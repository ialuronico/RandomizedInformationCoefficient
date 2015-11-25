clc;

disp('Compilation via MEX of MI source code written in C++');
disp('Compiling..');
mex computeMI.cpp 
disp('Done.');
