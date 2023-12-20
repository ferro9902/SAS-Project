proc sql;
%if %sysfunc(exist(DATASETS.WEATHER_DAILY_DARKSKY)) %then %do;
    drop table DATASETS.WEATHER_DAILY_DARKSKY;
%end;
%if %sysfunc(exist(DATASETS.WEATHER_DAILY_DARKSKY,VIEW)) %then %do;
    drop view DATASETS.WEATHER_DAILY_DARKSKY;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/weather_daily_darksky.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=DATASETS.WEATHER_DAILY_DARKSKY;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=DATASETS.WEATHER_DAILY_DARKSKY; RUN;


