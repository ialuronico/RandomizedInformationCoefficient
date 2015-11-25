clc;

disp('Compilation via MEX of NMI source code written in C++');
disp('Compiling..');
mex computeNMI.cpp 
disp('Done.');
