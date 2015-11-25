#include <iostream>
#include <random>
#include <chrono>

#include <chrono>
#include <functional>

#include "computeRICrndFerns.h"

/* C main to test RICrndFerns on a linear relationship. */

int main(){
    int n = 100; // number of records
	double **x;
	double **y;
	int i,j;


	int p = 2;
	int q = 2;

	x = new double*[p];
	y = new double*[q];

	for(j=0;j<p;j++)
		x[j] = new double[n]();
	for(j=0;j<q;j++)
		y[j] = new double[n]();


	// RICrndFerns parameters
	int Kr = 20;
	int Dmax = 3;

	// A random seed needs to be selected
	//unsigned seed = 17;
	// This generates a random seed according to the internal CPU clock
	unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();

	std::default_random_engine generator(seed);
	std::uniform_real_distribution<double> distribution(0.0,1.0);
	auto rndUnif = std::bind ( distribution, generator );

	// Generate n points
	for(j=0;j<p;j++){
		for (i=0; i<n; i++){
			x[j][i] = rndUnif();//(double)i/n;
		}
	}

	// Define function linear
	for(j=0;j<p;j++){
		for (i=0; i<n; i++){
			y[j][i] = x[j][i];
			//y[j][i] = rndUnif();
		}
	}


	/* compute RICrndFerns */
	printf("Compute RICrndFerns for a Linear relationship between X and Y:\n");
	double res = RICrndFerns(x,y,n,p,q,Kr,Dmax);

	printf("\nRICrndFerns is equal to %f",res);

}
