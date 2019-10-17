******************************************
*TITLE: HOMEOWRK #7
*
*DESCRIPTION: Logistic Regression
*
*-------------------------------------------
*PROGRAM NAME: Homework7.SAS
*LANGUAGE: SAS, VERSION 9.4
*
*NAME: CHEN BAI
*DATE: 10/12/2019
*--------------------------------------------
*
*********************************************;

libname hw7 "M:\Desktop\SAS\Homework7\data";

title1 "Homework7";
title2 "Question1";
title3 "Chi-Square Test between outcome and Risk Factors";
proc freq data = hw7.sorethroat;
	table T*Y /expected chisq measures nocol norow nopercent;
run;

* Fit a logistic regression model;
proc logisitc data = hw7.sorethroat descending;
	class T (ref = "0") / param = ref;
	model Y = T D;
run;

*create a dataset that we will use to predict;
data pred_wanted;
	input T D;
	cards;
	1 30
	0 25
	;
run;

* append the data we used to predict to the raw data;
data newData;
	set hw7.sorethroat pred_wanted;
run;

* fit a logistic regression to predict;
proc logistic data = newData descending;
	class T (ref = "0")/param = ref;
	model Y = T D;
	output out = pred p = ppred;
run;

* fit a full model;
proc logistic data = hw7.sorethroat descending;
	class T (ref = "0")/param = ref; 
	model Y = T D T*D;
run;
