******************************************
*TITLE: HOMEOWRK #2
*
*DESCRIPTION: Randomization and Power Analysis
*
*-------------------------------------------
*PROGRAM NAME: HOMEWORK2.SAS
*LANGUAGE: SAS, VERSION 9.4
*
*NAME: CHEN BAI
*DATE: 09/07/2019
*--------------------------------------------
*
*********************************************;

* Question 1 Part c;
* Perform permuted randomizatin for the first 24 subjects, block size = 6;
proc plan seed = 828;
	factors block = 4 ordered unit = 6 random;
	output out = bkoutput unit cvals = ("T" "T" "T" "P" "P" "P");
run;

data result;
	set bkoutput;
	id = _N_;
run;

proc print data = result;
	title1 "PHC6937 Homework #3";
	title2 "Question 1.c";
	title3 "Check Randomization Result";
run;
