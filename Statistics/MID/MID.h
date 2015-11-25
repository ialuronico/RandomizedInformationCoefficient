/*
 * MID.h
 *
 *  Created on: 16 Oct 2014
 *      Author: simone
 */

#ifndef MID_H_
#define MID_H_

// Min-max normalization to [0, 1] for each axis
void normalize(double *x, long int n);
// Discretization
void discretize(double *x, int *codes, long int n, int k);
// Calculate entropy
double entropyEach(long int *B, long int n, int m);
// Calculate joint entropy
double entropyCov(long int **B, long int n, int m);
// Simple linear regression
void linearRegression(int n, double *x, double *y, double *a, double *b, double *rsq);
// Estimation of information dimension
double estimate(int xnum, double *yall, int width, _Bool cov, double minent);
// Estimation of information dimension for two variables
double estimateCov(int xnum, double *yall, int width, _Bool cov, double minent);
// Calculate information dimension for x, y, and xy
void idim(double *x, double *y, long int n, int level_max, int level_max_cov, double *idim_x, double *idim_y, double *idim_xy);
// calculate mid
double mid(double* x, double*y, long int n);

#endif /* MID_H_ */
