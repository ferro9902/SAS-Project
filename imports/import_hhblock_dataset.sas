proc sql;
%if %sysfunc(exist(DATASETS.HHBLOCK_DATASET)) %then %do;
    drop table DATASETS.HHBLOCK_DATASET;
%end;
%if %sysfunc(exist(DATASETS.HHBLOCK_DATASET,VIEW)) %then %do;
    drop view DATASETS.HHBLOCK_DATASET;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/hhblock_dataset/*.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=DATASETS.HHBLOCK_DATASET;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=DATASETS.HHBLOCK_DATASET; RUN;


