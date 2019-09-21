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

* load dataset ;
data dental (drop = i);
	do i = 1 to 30;
		if i <= 10 then method = "1";
		else if i <= 20 then method = "2";
		else method = "3";
	input id age anxi @;
	output;
	end;
datalines;
1 27 30.2 
2 32 35.3 
3 23 32.4 
4 28 31.9 
5 30 27.4 
6 35 30.5 
7 32 34.8 
8 21 32.5 
9 26 33.0 
10 27 29.9 
11 29 33.6 
12 29 33.0 
13 31 31.7 
14 36 34.0 
15 23 29.9 
16 26 33.2 
17 22 31.0 
18 20 32.0 
19 28 33.0 
20 32 31.1 
21 33 29.9 
22 35 30.0 
23 21 26.0 
24 28 30.0 
25 27 31.0 
26 23 29.6 
27 25 33.0 
28 26 31.0 
29 27 29.1 
30 29 31.0
;
run;

*Use box plot to have a rough look at the differences of means among groups;
title1 "Homework 4";
title2 "Question 2";
proc boxplot data = dental;
	title3 "Boxplot for Different Groups";
	plot anxi * method;
run;

title3 "One-way ANOVA Test";
proc anova data = dental;
	class method;
	model anxi = method;
run;

* Question 3;
* perform an ancova test;
proc glm data = dental;
	title2 "Question 3";
	title3 "ANCOVA for Saturated Model";
	class method;
	model anxi = age method age*method;
run;

* ancova for the model without interaction term;
proc glm data = dental;
	title3 "ANCOVA for the Model without Interaction";
	class method;
	model anxi = age method;
run;
* Question 4;

* Kruskal-Wallis Test;
proc npar1way data = dental wilcoxon;
	title2 "Question 4";
	title3 "Non-parametirc ANOVA";
	class method;
	var anxi;
run;

