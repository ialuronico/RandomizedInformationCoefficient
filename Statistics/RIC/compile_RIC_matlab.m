clc;

disp('Compilation via MEX of RIC source code written in C++');
disp('It requires C++11 standards');
disp('Compiling..');
mex RIC_mex.cpp computeRIC.cpp
disp('Done.');
