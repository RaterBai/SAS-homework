*********************************************
*TITLE: HOMEOWRK #8
*
*DESCRIPTION: Linear Mixed Effect Model
*
*--------------------------------------------
*PROGRAM NAME: Homework9.SAS
*LANGUAGE: SAS, VERSION 9.4
*
*NAME: CHEN BAI
*DATE: 11/9/2019
*--------------------------------------------
*
*********************************************;
libname smoking "M:\Desktop\SAS\Homework9\data";

* count the sample size;
title1 "Homework #9";
title2 "Question 1.1";
proc sql;
	title3 "Individual sample size";
	select count(distinct(id)) from smoking.smoking;
run;

* range of observations per persion;
proc sql;
	create table obs as 
	select id, count(*) as count from smoking.smoking group by id;
run;

proc means data = obs min max mean median; 
	title3 "Range of Observations per Person";
	var count;
run;

* mean and std for each time;
proc means data = smoking.smoking mean std;
	class time smoker;
	var fev1;
run;

* plot of mean fev1 at each time;
proc sgplot data = smoking.smoking;
	title3 "Plot of Mean FEV by Time";
	vline time / response = fev1 stat = mean limitstat = stderr group = smoker groupdisplay = cluster;
run;

*Question 2.b;
*Compound Symmetry/Random intercept;
proc mixed data = smoking.smoking method = REML;
	class smoker;
	model fev1 = time smoker time*smoker/solution ddfm = kr;
	repeated /subject=ID type = CS;
run;

*Random intercept and slope;
proc mixed data = smoking.smoking method = REML;
	class smoker;
	model fev1 = time smoker time*smoker/solution ddfm = kr;
	random Intercept time /subject = id type = un;
run;

*AR(1) structure with random intercept;
proc mixed data = smoking.smoking method = REML;
	class smoker;
	model fev1 = time smoker time*smoker/solution ddfm = kr;
	random intercept /subject=id type = un;
	repeated /subject=id type = AR(1) r rcorr;
run;

*Unstructured within person correlation structure;
proc mixed data = smoking.smoking method = REML;
	class smoker;
	model fev1 = time smoker time*smoker/solution ddfm = kr;
	repeated /subject=id type = un;
run;

*AR(1) structure with random intercept and remove interaction;
proc mixed data = smoking.smoking method = REML;
	class smoker;
	model fev1 = time smoker /solution ddfm = kr outp = pred;
	random intercept /subject=id type = un;
	repeated /subject=id type = AR(1) r rcorr;
run;

proc sgpanel data = pred noautolegend;
	panelby smoker / spacing = 10;
	series y = pred x = time / group = id;
	title3 "Individual Prediction by Smoking Status";
run;
