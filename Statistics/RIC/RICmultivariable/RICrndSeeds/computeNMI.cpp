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
double NMI(int **T, int n_stateXd, int n_stateYd);

#define MIN(a,b) ((a) < (b) ? a : b)
#define MAX(a,b) ((a) < (b) ? b : a)

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
  double NMI_ = NMI(T, n_state, n_stateC);
  
  for(int i=0;i<n_state;i++)
      free(T[i]);
  free(T);

  B_OUT = mxCreateDoubleScalar(NMI_);
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

double NMI(int **T, int n_stateXd, int n_stateYd){
    double NI=0;
    double rSum; // row sum
    double cSum; // column sum
    double n = 0; // total records
    double rH = 0; // row entropy
    double cH = 0; // column entropy
    double H = 0; // joint entropy

    // Compute the joint entropy and row entropy
    for(int i=0;i<n_stateXd;i++){
        rSum=0;
        for(int j=0;j<n_stateYd;j++){
        	rSum+=T[i][j];
            if(T[i][j]>0) H += T[i][j]*log((double)T[i][j]);
        }
        if (rSum > 0) rH += rSum*log(rSum);
        n += rSum;
    }

    // Compute the column entropy
	for(int i=0;i<n_stateYd;i++){
		cSum=0;
		for(int j=0;j<n_stateXd;j++)
			cSum+=T[j][i];
		if (cSum > 0) cH += cSum*log(cSum);
	}

	// This is just the mutual information
    NI = (H - rH -cH)/n + log(n);

    // Normalize the mutual information
    if ( NI > 0)
    	return NI/MAX( -rH/n + log(n), -cH/n + log(n));
	else
	return 0;
}
