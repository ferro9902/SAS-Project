proc sql;
%if %sysfunc(exist(WORK.HHBLOCK_DATASET)) %then %do;
    drop table WORK.HHBLOCK_DATASET;
%end;
%if %sysfunc(exist(WORK.HHBLOCK_DATASET,VIEW)) %then %do;
    drop view WORK.HHBLOCK_DATASET;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/hhblock_dataset/*.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.HHBLOCK_DATASET;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.HHBLOCK_DATASET; RUN;


