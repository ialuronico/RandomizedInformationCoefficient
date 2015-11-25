#include "mex.h" /* Always include this */
#include "MID.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

#define MID_OUT plhs[0]

#define X_IN prhs[0]
#define Y_IN prhs[1]

int n;

n = mxGetN(X_IN);

double *X = mxGetPr(X_IN);
double *Y = mxGetPr(Y_IN);

double res = mid(X,Y,n);

MID_OUT = mxCreateDoubleScalar(res);

return;

}
