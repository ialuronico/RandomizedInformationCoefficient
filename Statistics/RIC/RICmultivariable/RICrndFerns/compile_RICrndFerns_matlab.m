clc;

disp('Compilation via MEX of RICrndFerns source code written in C++');
disp('It requires C++11 standards');
disp('Compiling..');
mex RICrndFerns_mex.cpp computeRICrndFerns.cpp
disp('Done.');
