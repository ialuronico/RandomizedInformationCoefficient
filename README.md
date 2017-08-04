# Randomized Information Coefficient

The Randomized Information Coefficient: Assessing Dependencies In Noisy Data

Please refer to this website:

https://sites.google.com/site/randinfocoeff/

Each experiments is available in its own folder: e.g. experiments about noisy relationships between variables are available in the folder `./sec51`.

RIC source code as well as other statistic code can also be found under the folder `./Statistics`. With regards to RIC:

* `./Statistics/RIC` contains RIC between variables;
* `./Statistics/RIC/RICmultivariable/RICrndFerns` contains RIC between sets of variables with **random fern discretization**;
* `./Statistics/RIC/RICmultivariable/RICrndSeeds` contains RIC between sets of variables with **random seeds discretization**.

The code is supposed to run in **Matlab** and it was tested on a 64bit Linux system. Some statistics are implemented either in C or C++, thus their code might be re-compiled if another system is used. We provide the script `compile_X_matlab.m` to compile measures implemented in C or C++. Those are:

* The Randomized Information Coefficient (RIC) - `compile_RIC_matlab.m`;
* RIC with **random fern discretization* - `compile_RICrndFerns_matlab.m`;
* RIC with **random seeds discretization* requires to compile the procedure `computeNMI` - `compile_computeNMI_matlab.m`;
* The Maximal Information Coefficient (MIC) - `compile_MINE_matlab.m`;
* The Maximal Information Coefficient (e) (MICe) - `compile_MINE_e_matlab.m`;
* The Generalized Mean Information Coefficient (GMIC) - `compile_MINE_matlab.m`;
* The Total Information Coefficient (e) (TICe) - `compile_MINE_e_matlab.m`;
* The Mutual Information Dimension (MID) - `compile_MID_matlab.m`;
* The kNN Kraskov's Mutual Information Estimator - `compile_MI_Kraskov_matlab.m`.

To plot the results of any experiment use `plotX.m`, where `X` is a particular experiment present in a specific folder. You might want to run experiments on your own, some might be time demanding: e.g. the power experiment in Section 5.1 takes around 30 minutes on a server Xeon E5-2666 v3 with 36 cores . If you want to speed up results try to: decrease the number of simulations, bootstrap repetitions, folds for cross-validation or number of records `n` in the simulations. 