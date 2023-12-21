proc sql;
%if %sysfunc(exist(CASUSER.WEATHER_DAILY_DARKSKY)) %then %do;
    drop table CASUSER.WEATHER_DAILY_DARKSKY;
%end;
%if %sysfunc(exist(CASUSER.WEATHER_DAILY_DARKSKY,VIEW)) %then %do;
    drop view CASUSER.WEATHER_DAILY_DARKSKY;
%end;
quit;



FILENAME REFFILE DISK '/shared/home/francesco.feroldi01@icatt.it/casuser/DataFiles/weather_daily_darksky.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CASUSER.WEATHER_DAILY_DARKSKY;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=CASUSER.WEATHER_DAILY_DARKSKY; RUN;


