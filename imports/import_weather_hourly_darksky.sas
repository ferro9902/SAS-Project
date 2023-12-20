proc sql;
%if %sysfunc(exist(WORK.WEATHER_HOURLY_DARKSKY)) %then %do;
    drop table WORK.WEATHER_HOURLY_DARKSKY;
%end;
%if %sysfunc(exist(WORK.WEATHER_HOURLY_DARKSKY,VIEW)) %then %do;
    drop view WORK.WEATHER_HOURLY_DARKSKY;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/weather_hourly_darksky.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.WEATHER_HOURLY_DARKSKY;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.WEATHER_HOURLY_DARKSKY; RUN;


