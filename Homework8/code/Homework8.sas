libname hw8 "M:\Desktop\SAS\Homework8\data";

title1 "Homework #8";
title2 "Question 1";
title3 "Univariate of Variable Dayshosp";
proc univariate data = hw8.strep;
	var dayshosp;
	histogram;
run;

title3 "Univariate Analysis of Variable Dayshops by Subgroup";
proc univariate data = hw8.strep;
	var dayshosp;
	by grpa;
	histogram;
run;

proc univariate data = hw8.strep;
	var age wbc;
run;

* center age and wbc;
proc sql;
	create table cstrep as 
	select ptid, grpa, multilobe, dayshosp,
		   age - avg(age) as cage,
		   wbc - avg(wbc) as cwbc from hw8.strep;
run;

proc genmod data = cstrep desc;
	class grpa (ref = "0") multilobe (ref = "0") / param = ref;
	model dayshosp = grpa cwbc cage multilobe / dist = P link = log;
	estimate "intercept" intercept 1 / exp;
	estimate "grpa" grpa 1 / exp;
	estimate "wbc" cwbc 1 / exp;
	estimate "age" cage 1 / exp;
	estimate "multilobe" multilobe 1 / exp;
run;

data add_pred;
	input ptid grpa multilobe cage cwbc;
	cards;
	1 1 0 0.5 -1.6
	2 0 0 0.5 -1.6
	;
run;

data newdata;
	set cstrep add_pred;
run;

* calculate predicted probabilities ;
proc genmod data = newdata desc;
	class grpa (ref = "0") multilobe (ref = "0") / param = ref;
	model dayshosp = grpa cwbc cage multilobe / dist = P link = log;
	output out = pred p = ppred;
run;

*calculate p-value for scaled deviance;
data chisq;
	pvalue = 1-probchi(180.4250, 121);
run;

title2 "Question 5";
title3 "P-value Corresponding to Scaled Deviance";
proc print data = chisq; run;

* Quasi-Likelihood model;
proc genmod data = cstrep desc;
	class grpa (ref = "0") multilobe (ref = "0") / param = ref;
	model dayshosp = grpa cwbc cage multilobe / dist = negbin;
	estimate "intercept" intercept 1 / exp;
	estimate "grpa" grpa 1 / exp;
	estimate "wbc" cwbc 1 / exp;
	estimate "age" cage 1 / exp;
	estimate "multilobe" multilobe 1 / exp;
run;

data chisq;
	pvalue = 1-probchi(98.6406, 121);
run;

title2 "Question 5";
title3 "P-value After Correcting Overdispersion";
proc print data = chisq; run;
