******************************************
*TITLE: HOMEOWRK #2
*
*DESCRIPTION: CONTINGENCY TABLE ANALYSIS
*
*-------------------------------------------
*PROGRAM NAME: HOMEWORK2.SAS
*LANGUAGE: SAS, VERSION 9.4
*
*NAME: CHEN BAI
*DATE: 09/01/2019
*--------------------------------------------
*
*********************************************;

* Part 1 Question 1;
* input data;
data pamidronate;
	length TRT $11;
	input TRT $ SKEL_EVT $ cnt;
	datalines;
	Pamidronate yes 55
	Pamidronate no  151
	Placebo     yes 77
	Placebo     no  109
	;
run;

* Part 1 Question 2;
* cross tabulation;
proc freq data = pamidronate order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 1.2";
	title3 "Cross Tabulation of the Data";
	table TRT * SKEL_EVT;
	weight cnt;
run;

* Part 1 Question 3;
* calculate expected cell counts;
proc freq data = pamidronate order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 1.3";
	title3 "Examination of Expected Cell Counts";
	table TRT * SKEL_EVT /expected;
	weight cnt;
run;

* Part 1 Question 5;
* difference between risks;
proc freq data = pamidronate order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 1.5";
	title3 "Risk Difference";
	table TRT * SKEL_EVT /chisq riskdiff;
	weight cnt;
run;

* Part 1 Question 6;
* check independence;
proc freq data = pamidronate order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 1.6";	
	title3 "Check Independence of two variables";
	table TRT * SKEL_EVT /chisq;
	weight cnt;
run;

* Part 1 Question 8;
* relative risk;
proc freq data = pamidronate order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 1.8";	
	title3 "Compute Measure Statistics";
	table TRT * SKEL_EVT /chisq measures;
	weight cnt;
run;

* Part 2 Question 9;
* import data;
data smoke;
	input pipsmoke $ lipcancer $ cnt @@;
	datalines;
	yes yes 340 yes no 146
	no  yes 194 no  no 354
	;
run;

* Part 2 Question 9;
* create cross tabulation;
proc freq data = smoke order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 2.9";	
	title3 "Cross tabulation";
	table pipsmoke * lipcancer;
	weight cnt;
run;

* calculate expected frequency;
proc freq data = smoke order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 2.9";	
	title3 "Check Chi-Square Test Assumption";
	table pipsmoke * lipcancer /expected;
	weight cnt;
run;

* Part 2 Question 11;
* Chi-square test for independence;
proc freq data = smoke order = data;
	title1 "PHC6937 Homework #2";
	title2 "Question 2.11";	
	title3 "Chi-Square Test";
	table pipsmoke * lipcancer /chisq;
	weight cnt;
run;

* Part 2 Question 12;
* relative association measure;
proc freq data = smoke order = data;
	table pipsmoke * lipcancer /chisq measures;
	weight cnt;
run;








