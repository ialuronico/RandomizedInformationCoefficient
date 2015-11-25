/*
 ============================================================================
 Name        : MI_Kraskov.c
 Author      : Simone Romano
 Version     :
 Copyright   : Your copyright notice
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include "miutils.h"

#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <random>
#include <chrono>


int main(void) {

	int i,n,K;

	K= 6;

	double*  x;
	double*  y;
	unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();

	std::default_random_engine generator(seed);
	std::uniform_real_distribution<double> distribution(0.0,1.0);

	n = 10;
	x = (double *) malloc (n * sizeof (double));
	y = (double *) malloc (n * sizeof (double));
	for (i=0; i<n; i++)
		{

		  x[i] = distribution(generator);
		  y[i] = x[i];
/*

			x[i] = distribution(generator);
			y[i] = distribution(generator);
*/
		}


	for (i=0; i<n; i++){
		printf("%f ", x[i]);
	}
	printf("\n");
	for (i=0; i<n; i++){
		printf("%f ", y[i]);
	}
	printf("\n");


	double res = mi_kraskov(x,y,n,K);
	printf("\nRes = %f",res);
}
