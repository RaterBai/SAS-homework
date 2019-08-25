******************************************
*TITLE: HOMEOWRK #1
*
*DESCRIPTION: 
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
proc contents data = bloodlib.blood;
run;

* print the dataset;
title1 "PHC6937 Homework #1";
title2 "Question 2.a";
title3 "Listing of Blood Dataset";
proc print data = bloodlib.blood;
run;

* sort data by viscosity level;
proc sort data = bloodlib.blood output = sorted_blood;
	by viscosity;
run;

title1 "PHC6937 Homework #1";
title2 "Question 2.b";
title3 "Listing of Sorted(viscosity)Blood Dataset";
proc print data = sorted_blood;
run;

* create descriptive info for variable viscosity;
proc univariate data = bloodlib.blood;
	title1 "PHC6937 Homework #1";
	title2 "Question 2.c";
	title3 "Description of Viscosity level";
	var viscosity;
	histogram viscosity;
run;

* create descriptive info for variable PCV;
proc univariate data = bloodlib.blood;
	title1 "PHC6937 Homework #1";
	title2 "Question 2.c";
	title3 "Description of PCV (packed cell volume)";
	var PCV;
	histogram PCV;
run;

* create descriptive info for variable fibrinogen;
proc univariate data = bloodlib.blood;
	title1 "PHC6937 Homework #1";
	title2 "Question 2.c";
	title3 "Description of Fibrinogen";
	var fibrinogen;
	histogram fibrinogen;
run;

* create descriptive info for variable protein;
proc univariate data = bloodlib.blood;
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
proc corr data = bloodlib.blood;
	var viscosity PCV fibrinogen protein;
run;


* scatter plot for variables viscosity & PCV;
title1 "PHC6937 Homework #1";
title2 "Question 3.a";
title3 "Scatter plot Between Viscosity level and PCV";
proc sgplot data = bloodlib.blood;
	scatter x = viscosity y = PCV;
run;
