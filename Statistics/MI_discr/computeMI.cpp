#include "mex.h" /* Always include this */

#include <iostream>
#include <iomanip>
#include <fstream>
#include <math.h>
#include <time.h>
#include <limits>
#include <vector>
#include <string>
#include <cstdlib>
#include <time.h>
#include <string.h>


#include <stdlib.h>
#include <string.h>
#include <stdio.h>


using namespace std;

int**  Contingency(double* A, double* B,int n_state,int n_stateC, int N);
double Mutu_Info(int **T, int n_state,int n_stateC);

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  
  #define B_OUT plhs[0]

  #define A_IN prhs[0]
  #define C_IN prhs[1]

  
  int N;
  
  N = mxGetN(A_IN);
  
  double *A = mxGetPr(A_IN);
  double *C = mxGetPr(C_IN);

  int n_state = 0;
  int n_stateC = 0;

  //get number of state of the feature
  for(int i=0;i<N;i++)
     if (n_state < A[i]) n_state = A[i];

  //get number of state of the class
  for(int i=0;i<N;i++)
    if (n_stateC < C[i]) n_stateC = C[i];

  int** T = Contingency(A, C, n_state, n_stateC, N);
  /*
  for(int i=0;i<n_state;i++){
    for(int j=0;j<n_stateC;j++){
      printf("%d ",T[i][j]);
    }
    printf("\n");
  }
  */
  double MI = Mutu_Info(T, n_state, n_stateC);
  
  for(int i=0;i<n_state;i++)
      free(T[i]);
  free(T);

  B_OUT = mxCreateDoubleScalar(MI);
}


int** Contingency(double* A, double* C,int n_state,int n_stateC, int N){

  int** T = (int**)malloc(n_state*sizeof(int*));

  for(int i=0;i<n_state;i++) T[i]=new int[n_stateC];

  for(int i=0;i<n_state;i++)
    for(int j=0;j<n_stateC;j++)
       T[i][j]=0;

    for(int i =0;i<N;i++){
       T[(int)A[i]-1][(int)C[i]-1]++;
    }
   return T;
}

double Mutu_Info(int **T, int n_state,int n_stateC){  //get the mutual information from a contingency table
    //n_state: #rows n_stateC:#cols
    double MI=0;
    
    int *a = (int*)malloc(n_state*sizeof(int));
    int *b = (int*)malloc(n_stateC*sizeof(int));
    int N = 0;

    for(int i=0;i<n_state;i++){ //row sum
        a[i]=0;
        for(int j=0;j<n_stateC;j++)
        {a[i]+=T[i][j];}
    }

    for(int i=0;i<n_stateC;i++){ //col sum
        b[i]=0;
        for(int j=0;j<n_state;j++)
        {b[i]+=T[j][i];}
    }

    for(int i=0;i<n_state;i++) {N+=a[i];}

    for(int i=0;i<n_state;i++){
        for(int j=0;j<n_stateC;j++){
            if(T[i][j]>0){
                MI+= T[i][j]*log((double)T[i][j]*N/a[i]/b[j]);
            }
        }
    }

    free(a);
    free(b);
    
    if(N>0) return MI/N/log(2.0);
    else return 0;
}
