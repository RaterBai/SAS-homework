libname hw6 "M:\Desktop\SAS\Homework6";

title1 "Homework6";
title2 "Question 1";
title3 "Description of Continuous Variables";

proc univariate data = hw6.fev1;
	var fev ht;
	histogram;
run;

title3 "Description of Categorical Variables";
proc freq data = hw6.fev1;
	table gend smoke;
run;

* center the variable Height and create a new dataset;
data fev_centered;
	set hw6.fev1;
	HeightC = Ht - 66.86;
run;

title2 "Question2";
title3 "Description of Centered Height";
proc univariate data = fev_centered;
	var HeightC;
run;

* SLR FEV on Smoke;
title2 "Question 3";
title3 "Result of SLR";
proc glm data = fev_centered;
	class smoke(ref = "0");
	model fev = smoke /solution;
run;

*Fit a model;
proc glm data = fev_centered;
	class smoke(ref = "0") gend(ref = "0");
	model fev = heightc gend smoke smoke*gend;
run; 

* Fit a model without interaction term;
ods graphics on;
proc glm data = fev_centered plots = (diagnostics residuals);
	class smoke(ref = "0") gend(ref = "0");
	model fev = heightc gend smoke / solution tolerance;
	output out = hw6.diag H = leverage cookd = cooks_d rstudent = stddelres;
run; 
ods graphics off;

* examine all the obs have h > 2(3+1)/117;
title2 "Question 4.c";
title3 "Examine Leverage";
proc print data = hw6.diag;
	var id leverage;
	where leverage > 2*(3+1)/117;
run;

title3 "Examine Cook's Distance";
proc print data = hw6.diag;
	var id cooks_d;
	where cooks_d > 4/117;
run;

* QQ-plot and Shapiro-Wilk test to examine normality;
title2 "Question 4.d";
title3 "QQ-Plot of Studentized Deleted Residuals";
proc univariate data = hw6.diag normal;
	var stddelres;
	qqplot /normal(mu = est sigma = est color = red l = 1);
run;

