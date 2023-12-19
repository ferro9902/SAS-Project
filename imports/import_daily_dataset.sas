proc sql;
%if %sysfunc(exist(WORK.DAILY_DATASET)) %then %do;
    drop table WORK.DAILY_DATASET;
%end;
%if %sysfunc(exist(WORK.DAILY_DATASET,VIEW)) %then %do;
    drop view WORK.DAILY_DATASET;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/archive/DataFiles/daily_dataset/*.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.DAILY_DATASET;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.DAILY_DATASET; RUN;


