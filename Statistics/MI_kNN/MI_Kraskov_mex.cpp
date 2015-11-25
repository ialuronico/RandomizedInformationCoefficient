#include "mex.h" /* Always include this */
#include "miutils.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

#define MI_OUT plhs[0]

#define X_IN prhs[0]
#define Y_IN prhs[1]
#define K_IN prhs[2]

int n;


n = mxGetN(X_IN);

double *X = mxGetPr(X_IN);
double *Y = mxGetPr(Y_IN);

/* Number of nearest neighbours */
int K = mxGetScalar(K_IN);

double res = mi_kraskov(X,Y,n,K);

MI_OUT = mxCreateDoubleScalar(res);


return;

}
