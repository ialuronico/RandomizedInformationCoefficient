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

// The following require -std=c+11 on the compiler
#include <random>
#include <chrono>
#include <functional>


#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "computeRICrndFerns.h"

#define MIN(a,b) ((a) < (b) ? a : b)
#define MAX(a,b) ((a) < (b) ? b : a)

/* This is the code to compute RIC as proposed in
 * Algorithm 1 in the paper. This version computes the
 * dependency between sets of variables. It uses random ferns.
 */

double RICrndFerns(double** x, double** y, int n, int p, int q, int Kr, int Dmax) {

	double ric_ = 0;
	double cutoff; 
	int attX, attY;
	int D;
	int** BinLabelX;
	int** BinLabelY;
	// Number of bins
	int* n_stateX;
	int * n_stateY;
	int n_state = 1<<Dmax;  // Max number of bins possible
	// For contingency tables to compute NMI
	double ni_G;
	int** T;

	// Random seed used to generated random grids G
	unsigned seed = 17;
	//unsigned seed = std::chrono::system_clock::now().time_since_epoch().count(); // this also makes it slower

	// Function to generate a uniform distribution in [0,n-1]
	std::default_random_engine generator(seed);
	std::uniform_int_distribution<int> distributionPoint(0,n-1);
	auto rndPoint = std::bind ( distributionPoint, generator );

	// Function to generate a uniform distribution in [1,Dmax]
	std::uniform_int_distribution<int> distributionD(1,Dmax);
	auto rndD = std::bind ( distributionD, generator );

	// Function to generate a uniform distribution in [0,p-1]
	std::uniform_int_distribution<int> distributionRndAttX(0,p-1);
	auto rndAttX = std::bind ( distributionRndAttX, generator );

	// Function to generate a uniform distribution in [0,q-1]
	std::uniform_int_distribution<int> distributionRndAttY(0,q-1);
	auto rndAttY = std::bind ( distributionRndAttY, generator );

	// Initialize arrays
	BinLabelX = new int*[Kr];
	BinLabelY = new int*[Kr];
	for(int k=0; k<Kr;k++){
		BinLabelX[k]=new int[n](); // initialize to 0
		BinLabelY[k]=new int[n]();
	}
	n_stateX = new int[Kr];
	n_stateY = new int[Kr];
	T = new int*[n_state];
	for(int i=0;i<n_state;i++) T[i]=new int[n_state];

	// RandomDiscr in Algortihm 3 of the paper to Generate Random discretizations
	for(int k = 0; k < Kr; k++){
		// Generate a random discretization for X
		//D = rndD();
		D = Dmax; // Fix it to the maximum number
		n_stateX[k] = 1<<D;
		for(int d=0; d < D; d++){
			attX = rndAttX();
			cutoff = x[attX][rndPoint()];
			for(int i = 0; i < n; i++){
				BinLabelX[k][i] += (1<<d)*(x[attX][i]<cutoff);
				}
		}
/*
		printf("Discretization for X\n");
		for(int i = 0; i < n; i++)
			printf(" %d",BinLabelX[k][i]);
		printf("\n");
*/

		// Generate a random discretization for Y
		//D = rndD();
		D = Dmax;
		n_stateY[k] = 1<<D;
		for(int d=0; d < D; d++){
			attY = rndAttY();
			cutoff = y[attY][rndPoint()];
			for(int i = 0; i < n; i++){
				BinLabelY[k][i] += (1<<d)*(y[attY][i]<cutoff);
			}
		}
/*
		printf("\nDiscretization for Y\n");
		for(int i = 0; i < n; i++)
			printf(" %d",BinLabelY[k][i]);
		printf("\n");
*/
	}

	// Average across grids of NI

	for(int kX = 0; kX < Kr; kX++){
		for(int kY = 0; kY < Kr; kY++){
			Contingency(T, BinLabelX[kX], BinLabelY[kY], n_stateX[kX], n_stateY[kY], n);

			// Just for debugging
/*
			printf("\n\n Print contingency table:\n\n");
			for(int i=0;i<n_stateX[kX];i++){
				for(int j=0;j<n_stateY[kY];j++){
				  printf("%d\t",T[i][j]);
				}
				printf("\n");
			}
*/
			ni_G = NMI(T, n_stateX[kX], n_stateY[kY]);
//			printf("\n NI( (X,Y)|G) = %2.4f ",ni_G);
			ric_ += ni_G;
			//if (ric_ < ni_G) ric_ = ni_G;
		}
	}

	// Free memory
	for(int i=0;i<n_state;i++) delete[] T[i];
	delete[] T;
	for(int k=0; k<Kr;k++){
		delete[] BinLabelX[k];
		delete[] BinLabelY[k];
	}
	delete[] BinLabelX;
	delete[] BinLabelY;
	delete[] n_stateX;
	delete[] n_stateY;

	return ric_/Kr/Kr;

}

/* Generates a contingency table for the two categorical variables Xd and Yd */
void Contingency(int** T, int* Xd, int* Yd, int n_stateXd, int n_stateYd, int n){
	for(int i=0; i<n_stateXd;i++)
		for(int j=0;j<n_stateYd;j++)
			T[i][j]=0;

    for(int i =0;i<n;i++)
    	T[Xd[i]][Yd[i]]++;
}

/* Computes the normalized mutual information for the contingency
 * table T obtained according to a grid
 */
double NMI(int **T, int n_stateXd,int n_stateYd){
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
