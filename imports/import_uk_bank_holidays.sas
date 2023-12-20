proc sql;
%if %sysfunc(exist(WORK.UK_BANK_HOLIDAYS)) %then %do;
    drop table WORK.UK_BANK_HOLIDAYS;
%end;
%if %sysfunc(exist(WORK.UK_BANK_HOLIDAYS,VIEW)) %then %do;
    drop view WORK.UK_BANK_HOLIDAYS;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/uk_bank_holidays.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.UK_BANK_HOLIDAYS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.UK_BANK_HOLIDAYS; RUN;


