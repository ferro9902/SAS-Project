proc sql;
%if %sysfunc(exist(DATASETS.ACORN_DETAILS)) %then %do;
    drop table DATASETS.ACORN_DETAILS;
%end;
%if %sysfunc(exist(DATASETS.ACORN_DETAILS,VIEW)) %then %do;
    drop view DATASETS.ACORN_DETAILS;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/acorn_details.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=DATASETS.ACORN_DETAILS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=DATASETS.ACORN_DETAILS; RUN;


