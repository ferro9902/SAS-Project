proc sql;
%if %sysfunc(exist(DATASETS.DAILY_DATASET)) %then %do;
    drop table DATASETS.DAILY_DATASET;
%end;
%if %sysfunc(exist(DATASETS.DAILY_DATASET,VIEW)) %then %do;
    drop view DATASETS.DAILY_DATASET;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/daily_dataset/*.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=DATASETS.DAILY_DATASET;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=DATASETS.DAILY_DATASET; RUN;


