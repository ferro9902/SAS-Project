proc sql;
%if %sysfunc(exist(DATASETS.UK_BANK_HOLIDAYS)) %then %do;
    drop table DATASETS.UK_BANK_HOLIDAYS;
%end;
%if %sysfunc(exist(DATASETS.UK_BANK_HOLIDAYS,VIEW)) %then %do;
    drop view DATASETS.UK_BANK_HOLIDAYS;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/uk_bank_holidays.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=DATASETS.UK_BANK_HOLIDAYS;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=DATASETS.UK_BANK_HOLIDAYS; RUN;


