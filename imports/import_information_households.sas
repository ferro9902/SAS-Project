proc sql;
%if %sysfunc(exist(WORK.INFORMATION_HOUSEHOLDS)) %then %do;
    drop table WORK.INFORMATION_HOUSEHOLDS;
%end;
%if %sysfunc(exist(WORK.INFORMATION_HOUSEHOLDS,VIEW)) %then %do;
    drop view WORK.INFORMATION_HOUSEHOLDS;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/archive/DataFiles/information_households.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.INFORMATION_HOUSEHOLDS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.INFORMATION_HOUSEHOLDS; RUN;


