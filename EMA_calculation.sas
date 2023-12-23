/* Sort the data */
proc sort data=CASUSER.daily_dataset_merged;
  by LCLid DayOfWeek;
run;

/* Create lagged variable */
data CASUSER.daily_dataset_merged_lagged;
  set CASUSER.daily_dataset_merged;
  by LCLid DayOfWeek;

  lag_value = lag(Consumption);

  if first.DayOfWeek then lag_value = .;
run;

/* Calculate EMA */
proc expand data=CASUSER.daily_dataset_merged_lagged out=CASUSER.daily_dataset_ema;
  by LCLid DayOfWeek;
  id LCLid, day;
  convert Consumption = ema / transformout=(ema 0.5);
run;

/* Display the result */
proc print data=ema_data;
run;
