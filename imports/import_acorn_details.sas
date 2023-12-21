proc sql;
%if %sysfunc(exist(CASUSER.ACORN_DETAILS)) %then %do;
    drop table CASUSER.ACORN_DETAILS;
%end;
%if %sysfunc(exist(CASUSER.ACORN_DETAILS,VIEW)) %then %do;
    drop view CASUSER.ACORN_DETAILS;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/acorn_details.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CASUSER.ACORN_DETAILS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=CASUSER.ACORN_DETAILS; RUN;


