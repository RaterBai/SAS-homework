*********************************************
*TITLE: HOMEOWRK #10
*
*DESCRIPTION: IML and Simulation
*
*--------------------------------------------
*PROGRAM NAME: Homework10.SAS
*LANGUAGE: SAS, VERSION 9.4
*
*NAME: CHEN BAI
*DATE: 11/29/2019
*--------------------------------------------
*
*********************************************;

*Question 1;
libname data "M:\Desktop\SAS\Homework6";
proc iml;
	reset print;
	A = {5 6 7, 3 9 2, 2 6 9};
	B = {2 9, 6 3, 8 5};

	*sum of all values in A;
	totalSum = sum(A);
	print(totalSum);

	*sum of each column in B;
	colSum = B[+,];
	print(colSum);

	*product AB;
	prod = A * B;
	print(prod);

	*Define C as the first 2 columns of A;
	C = A[, 1:2];
	print(C);

	*D = A`A + BB`;
	D = A`*A + B*B`;
	print(D);

	*D = 4C-3B;
	D = 4*C - 3*B;
	print(D);
	
	*solve AU = B for U;
	U = inv(A)*A;
	print(U);
	*;
quit;

* Question 2;
proc iml;
	*A is the matrice of coefficients;
	*B is the column vector of solution;
	start system(A, B);
		X = inv(A)*B;
		return(X);
	finish;
	A = {2 -1 4, 
		 6 -2 2,
		 3 -3 -7};
	B = {23, 19, 8};
	title1 "Homework10";
	title2 "Question 2";
	title3 "Solution for the Linear Equation";
	print(system(A, B));
quit;
		
* Question 3;
* use strep dataset under HW8;
* examine FEV by the group users provided;
%macro ex_fev(dataset, var);
	%if &var = gend or &var = smoke %then  /* for categorical variables */
		%do;
			title "Boxplot FEV vs &var";
			proc sgplot data = &dataset;
				vbox fev / category = &var;
			run;
			title "Two sample T-Test";
			proc ttest data = &dataset;
				class &var;
				var fev;
			run;
		%end;
	%else %if &var = ht %then /* Categorize dayshops into 2 groups, less than 10, larger than 10*/
		%do;
			data temp;
				set &dataset;
				if ht <= 67 then ht_grp = "shorter than median (<=67)";
				else ht_grp = "taller than median (>67)";
			run;

			title "Boxplot FEV vs &var";
			proc sgplot data = temp;
				vbox fev / category = ht_grp;
			run;

			title "Two sample T-Test";
			proc ttest data = temp;
				class ht_grp;
				var fev;
			run;
		%end;
%mend;

%ex_fev(data.fev1, ht);

* simulation data;
%let N = 500;
data simdata;
	do i = 1 to &N;
		x1 = rand("Normal");
		x2 = rand("Normal");
		x3 = rand("Bernoulli", 0.5);
		e = rand("Normal");
		y = 0.3 + 0.5*x3 + x1 + x2 + rand("Normal");
		output;
	end;
	keep x1 x2 x3 y;
run;

ods trace on;
ods output ParameterEstimates = parms;
proc reg data = simdata outest=estimates;
	model y = x3 x2;
run;
ods trace off;
proc print data = estimate;
run;

%let Nreps = 500;
%macro simulate(out);
options nonotes;
ods listing close; ods noRESULTS;
%do i = 1 %to &nreps;
	data simdata;
		do i = 1 to &N; * Generate Random variables;
			x1 = rand("Normal");
			x2 = rand("Normal");
			x3 = rand("Bernoulli", 0.5);
			e = rand("Normal");
			y = 0.3 + 0.5*x3 + x1 + x2 + rand("Normal");
			output;
		end;
		keep x1 x2 x3 y;
	run;
	
	* fit misspecified model;
	proc reg data = simdata outest=estimates;
		model y = x3 x2;
	run;

	proc datasets library = work force;
		append out = &out data = estimates;
	run;

	proc datasets library = work;
		delete estimates;
	run;
%end;
options notes;
%mend;

%simulate(parameter);


proc means data = parameter;
	title "Means of estimates x2 and x3";
	var x2 x3;
run;
