******************************************
*TITLE: HOMEOWRK #1
*
*DESCRIPTION: BASIC SAS OPERATIONS
*
*-------------------------------------------
*PROGRAM NAME: HW1.SAS
*LANGUAGE: SAS, VERSION 9.4
*
*NAME: CHEN BAI
*DATE: 08/22/2019
*--------------------------------------------
*
*********************************************;

%let path = M:\Desktop\SAS\Homework1\data;

*create a sas library;
libname bloodlib "&path";

* create a dataset to store blood info;
data bloodlib.blood;
	infile "&path\blood.dat.txt" firstobs = 2; *Read this file start from the second row, first row is the variable name;
	input viscosity PCV fibrinogen protein pntid;
run;

* create a temporary dataset copied from bloodlib.blood;
data blood;
	set bloodlib.blood;
run;

* create descriptive info for the dataset;
title1 "PHC6937 Homework #1";
title2 "Question 2.a";
title3 "Descriptive Info of Blood Dataset";
proc contents data = blood;
run;

* print the dataset;
title1 "PHC6937 Homework #1";
title2 "Question 2.a";
title3 "Listing of Blood Dataset";
proc print data = blood;
run;

* sort data by viscosity level;
proc sort data = blood output = sorted_blood;
	by viscosity;
run;

title1 "PHC6937 Homework #1";
title2 "Question 2.b";
title3 "Listing of Sorted(viscosity)Blood Dataset";
proc print data = sorted_blood;
run;

* create descriptive info for variable viscosity;
proc univariate data = blood;
	title1 "PHC6937 Homework #1";
	title2 "Question 2.c";
	title3 "Description of Viscosity level";
	var viscosity;
	histogram viscosity;
	ods output quantiles = viscoq; *output the quantile of viscosity;
	*output out = med median = medv;
run;

* create descriptive info for variable PCV;
proc univariate data = blood;
	title1 "PHC6937 Homework #1";
	title2 "Question 2.c";
	title3 "Description of PCV (packed cell volume)";
	var PCV;
	histogram PCV;
run;

* create descriptive info for variable fibrinogen;
proc univariate data = blood;
	title1 "PHC6937 Homework #1";
	title2 "Question 2.c";
	title3 "Description of Fibrinogen";
	var fibrinogen;
	histogram fibrinogen;
run;

* create descriptive info for variable protein;
proc univariate data = blood;
	title1 "PHC6937 Homework #1";
	title2 "Question 2.c";
	title3 "Description of Protein";
	var protein;
	histogram protein;
run;

* calculate correlation coefficients;
title1 "PHC6937 Homework #1";
title2 "Question 3.a";
title3 "Correlation Analysis";
proc corr data = blood;
	var viscosity PCV fibrinogen protein;
run;


* scatter plot for variables viscosity & PCV;
title1 "PHC6937 Homework #1";
title2 "Question 3.a";
title3 "Scatter plot Between Viscosity level and PCV";
proc sgplot data = blood;
	scatter x = viscosity y = PCV;
run;

* get the median of viscosity level;
data medq;
	set viscoq;
	if quantile = "50% Median";
	drop varname quantile;
run;

* merge the median of viscosity dataset and blood dataset together;
data blood_vmed;
	merge bloodlib.blood medq;
	retain medianv;
	if _N_ = 1 then medianv = estimate;
	drop estimate;
run;

* classify viscosity level and assign the class to a new variable;
data blood2;
	set blood_vmed;
	length vLevel $4; 
	if viscosity < medianv then vLevel = "Low";
	else if viscosity >= medianv then vLevel = "High";
run;

* create descriptive statistics for each variable by vLevel;
title1 "PHC6937 Homework #1";
title2 "Question 3.c";
title3 "Descriptive Statistics by Viscosity Level";
proc means data = blood2 min max median mean stddev ndec=2;
var PCV fibrinogen protein;
class vLevel;
run;
