proc sort data=CASUSER.daily_dataset_merged nodupkey;
  by LCLid DayOfWeek day;
run;

/* compute the CMA on 3 and on 5 lags */
proc expand out=CASUSER.daily_dataset_merged_cma data=CASUSER.daily_dataset_merged METHOD=NONE;
	by LCLid DayOfWeek;
	convert Consumption=cma5 / transform=(cmovave 5);
	convert Consumption=cma3 / transform=(cmovave 3);
	run;

data CASUSER.daily_dataset_merged_cma;
   set CASUSER.daily_dataset_merged_cma;
   if not missing(cma3) then do;
      Consumption = cma3;
   end;
run;

data CASUSER.daily_dataset_merged_cma;
  set CASUSER.daily_dataset_merged_cma;
  by LCLid DayOfWeek;

  lag_value = lag(Consumption);

  if first.DayOfWeek then lag_value = .;
run;