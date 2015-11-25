#include <iostream>
#include <random>
#include <chrono>

#include "computeRIC.h"

/* C main to test RIC on a Quadratic relationship. */

int main(){
    int n = 100; // number of records
	double *x;
	double *y;
	int i;

	// RIC parameters
	int Kr = 20;
	int Dmax = 5;

	// A random seed needs to be selected
	unsigned seed = 17;
	// This generates a random seed according to the internal CPU clock
	//unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();

	std::default_random_engine generator(seed);
	std::uniform_real_distribution<double> distribution(0.0,1.0);

	x = (double *) malloc (n * sizeof (double));
	y = (double *) malloc (n * sizeof (double));
	// Generate n points according to a quadratic equation
	for (i=0; i<n; i++){
		x[i] = distribution(generator);
		y[i] = (x[i] - 0.5)*(x[i] - 0.5);
	}

	/* compute RIC */
	printf("Compute RIC for a quadratic relationship between X and Y:\n");
	double res = RIC(x,y,n,Kr,Dmax);

	printf("\nRIC is equal to %f",res);

}
