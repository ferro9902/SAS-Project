proc sql;
%if %sysfunc(exist(CASUSER.UK_BANK_HOLIDAYS)) %then %do;
    drop table CASUSER.UK_BANK_HOLIDAYS;
%end;
%if %sysfunc(exist(CASUSER.UK_BANK_HOLIDAYS,VIEW)) %then %do;
    drop view CASUSER.UK_BANK_HOLIDAYS;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/uk_bank_holidays.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CASUSER.UK_BANK_HOLIDAYS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=CASUSER.UK_BANK_HOLIDAYS; RUN;


