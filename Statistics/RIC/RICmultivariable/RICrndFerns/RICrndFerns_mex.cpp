#include "mex.h" /* Always include this */
#include "computeRICrndFerns.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

#define B_OUT plhs[0]

#define X_IN prhs[0]
#define Y_IN prhs[1]
#define Kmax_IN prhs[2]
#define D_IN prhs[3]

int N,p,q;
int i,j;

//mexPrintf("n par %d\n",nrhs);

N = mxGetN(X_IN);
p = mxGetM(X_IN);
q = mxGetM(Y_IN);

double *x_single = mxGetPr(X_IN);
double *y_single = mxGetPr(Y_IN);

// compute the x and y to send in input
double** x = new double*[p];
double** y = new double*[q];

for(j=0;j<p;j++){
	x[j] = new double[N];
	for(i=0;i<N;i++)
		x[j][i] = x_single[j + p*i];
}
for(j=0;j<q;j++){
	y[j] = new double[N];
	for(i=0;i<N;i++)
		y[j][i] = y_single[j + q*i];
}

int Kmax = mxGetScalar(Kmax_IN);
int D = mxGetScalar(D_IN);

/*
mexPrintf("N %d\n",N);
mexPrintf("X[0] %f\n",*X);
mexPrintf("Y[0] %f\n",*Y);

mexPrintf("Kmax %d\n",Kmax);

mexPrintf("D %d",D);

*/

double res = RICrndFerns(x,y,N,p,q,Kmax,D);

B_OUT = mxCreateDoubleScalar(res);

for(j=0;j<p;j++)
	delete[] x[j];
delete[] x;
for(j=0;j<q;j++)
	delete[] y[j];
delete[] y;

return;

}
