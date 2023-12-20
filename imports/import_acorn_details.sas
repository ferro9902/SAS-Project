proc sql;
%if %sysfunc(exist(WORK.ACORN_DETAILS)) %then %do;
    drop table WORK.ACORN_DETAILS;
%end;
%if %sysfunc(exist(WORK.ACORN_DETAILS,VIEW)) %then %do;
    drop view WORK.ACORN_DETAILS;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/acorn_details.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.ACORN_DETAILS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.ACORN_DETAILS; RUN;


