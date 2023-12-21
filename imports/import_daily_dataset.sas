proc sql;
%if %sysfunc(exist(CASUSER.DAILY_DATASET)) %then %do;
    drop table CASUSER.DAILY_DATASET;
%end;
%if %sysfunc(exist(CASUSER.DAILY_DATASET,VIEW)) %then %do;
    drop view CASUSER.DAILY_DATASET;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/daily_dataset/*.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CASUSER.DAILY_DATASET;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=CASUSER.DAILY_DATASET; RUN;


