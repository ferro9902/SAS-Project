/* Sort the data */
proc sort data=CASUSER.daily_dataset_merged;
  by LCLid DayOfWeek day;
run;

/* compute the CMA on 3 and on 5 lags */
proc expand out=CASUSER.daily_dataset_merged_cma data=CASUSER.daily_dataset_merged METHOD=NONE;
	by LCLid DayOfWeek;
	convert Consumption=cma5 / transform=(cmovave 5);
	convert Consumption=cma3 / transform=(cmovave 3);
	run;