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
	input  TRT $ SKEL_EVT $ cnt;
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
