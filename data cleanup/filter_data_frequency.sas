
/* filter out days whose numbero of daily samples is lower than the 75th percentile */
proc sql;
    CREATE TABLE CASUSER.daily_dataset_filtered AS
    SELECT *
    FROM CASUSER.daily_dataset
    WHERE day >= '20Jun2012'd;
quit;
