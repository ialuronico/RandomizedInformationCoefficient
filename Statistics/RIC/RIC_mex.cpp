#include "mex.h" /* Always include this */
#include "computeRIC.h"

/* Generate a mex file for RIC */
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

#define RIC_OUT plhs[0]

#define X_IN prhs[0]
#define Y_IN prhs[1]
#define Kr_IN prhs[2]
#define Dmax_IN prhs[3]

int n;

n = mxGetN(X_IN);

double *X = mxGetPr(X_IN);
double *Y = mxGetPr(Y_IN);

int Kr = mxGetScalar(Kr_IN);
int Dmax = mxGetScalar(Dmax_IN);

double res = RIC(X,Y,n,Kr,Dmax);

RIC_OUT = mxCreateDoubleScalar(res);

return;

}
