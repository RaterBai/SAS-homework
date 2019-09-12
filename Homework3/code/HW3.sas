******************************************
*TITLE: HOMEOWRK #3
*
*DESCRIPTION: Randomization and Power Analysis
*
*-------------------------------------------
*PROGRAM NAME: HOMEWORK3.SAS
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

* add id;
data result;
	set bkoutput;
	id = _N_;
run;

* print data;
proc print data = result;
	title1 "PHC6937 Homework #3";
	title2 "Question 1.c";
	title3 "Check Randomization Result";
run;

* Question 2 Part d;
* calculate sample size needed;
proc power;
	title2 "Question 2.d";
	title3 "Sample Size Calculation";
	twosamplefreq
	groupproportions = (0.55 0.7)
	power = 0.80
	nperg = .;
run;

* Question 2 Part e;
* calculate multiple power and store them into a table: powertable;
ods output output = powertable;
proc power;
	title2 "Question 2.e";
	title3 "Power Calculation";
	twosamplefreq
	groupproportions = (0.55 0.6) (0.55 0.65) (0.55, 0.7) (0.55 0.75)
	power = .
	nperg = 163;
run;

* reformat power table;
data powertable;
	set powertable (rename = (Proportion2 = Intervention_success_rate));
	keep Intervention_success_rate power;
run;

* check the power table;
proc print data = powertable;
	title3 "Check Power Table";
run;

* Question 2 Part f;
ods output output = powertable;
proc power;
	twosamplefreq
	groupproportions = 0.55 | 0.55 to 0.99 by 0.01  
	power = .
	nperg = 163;
run;

data powertable;
	set powertable (rename = (Proportion2 = Intervention_success_rate));
	keep Intervention_success_rate power;
run;

proc gplot data = powertable;
	title2 "Question 2.f";
	title3 "Power Plot";
	symbol1 interpol=join
        value=dot;
	plot power*Intervention_success_rate;
run;

* Question 2 Part g;
* calculate power when intervention success rate = 0.55;
proc power;
	title2 "Question 2.g";
	title3 "Power Calculation at intervention success rate = 0.55";
	twosamplefreq
	groupproportions = (0.55 0.55)
	power = .
	nperg = 163;
run;

* Question 2 Part g;
* calculate power when there are 10000 patients per treatment arm;
proc power;
	title2 "Question 2.g";
	title3 "Power Calculation at 10000 Patients/Group";
	twosamplefreq
	groupproportions = (0.55 0.55)
	power = .
	nperg = 10000;
run;
