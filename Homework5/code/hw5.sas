******************************************
*TITLE: HOMEOWRK #4
*
*DESCRIPTION: ANOVA 
*
*-------------------------------------------
*PROGRAM NAME: HOMEWORK4.SAS
*LANGUAGE: SAS, VERSION 9.4
*
*NAME: CHEN BAI
*DATE: 09/20/2019
*--------------------------------------------
*
*********************************************;

* load data into SAS dataset;
proc import datafile = "M:\Desktop\SAS\Homework5\data\HW5dat2019.csv"
DBMS = csv out = platelet;
run;


* Univariate analysis for variable pltcnt;
title1 "Homework #5";
title2 "Quesiton 1";
title3 "Univariate Analysis";
proc univariate data = platelet;
	var pltcnt g_pdgf g_tgf;
	histogram ;
run;

* Univariate analysis for age;
title3 "Freqency Table of Age";
proc freq data = platelet;
	table ptage;

* draw a scatter plot for platelet count & PDGF;
title2 "Question2";
title3 "Scatter Plot of PDGF vs Platelet Count";
proc sgplot data = platelet;
	scatter x = pltcnt y = g_pdgf;
run;

* draw a scatter plot for platelet count & TGF;
title3 "Scatter Plot of TGF vs Platelet Count";
proc sgplot data = platelet;
	scatter x = pltcnt y = g_tgf;
run;

* non-parametric correlation test;
title3 "Spearman's Test of Platelet Count & PDGF";
proc corr data = platelet fisher;
	var pltcnt g_pdgf;
run;

title3 "Spearman's Test of Platelet Count & TGF";
proc corr data = platelet fisher;
	var pltcnt g_tgf;
run;

* fit a SLM to PDGF & Platelet count;
title3 "SLM on PDGF & Platelet Count";
proc reg data = platelet;
	model g_pdgf = pltcnt;
run;

* use anova to test whehter mean PDGF counts differ by age group;
proc anova data = platelet;
	class ptage;
	model g_pdgf = ptage;
run;