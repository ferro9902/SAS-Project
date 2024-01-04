/* flag instances in uk bank holidays + add day of week and of year (as %) + remove header values */
proc sql;
    CREATE TABLE CASUSER.daily_dataset_augmented AS
    SELECT *, 
		CASE WHEN daily_dataset_filtered.day IN (SELECT t1.'Bank holidays'n FROM CASUSER.uk_bank_holidays t1) THEN 1 ELSE 0 END AS isUkHoliday, 
		weekday(day) AS dayOfWeek, 
		yrdif(INPUT(CATS('01JAN', year(day)), DATE9.), day, 'ACT/365') AS dayOfYear
    FROM CASUSER.daily_dataset_filtered
	WHERE LCLid <> 'LCLid';
quit;

/* convert weather time column to date */
data CASUSER.weather_daily_darksky;
	set CASUSER.weather_daily_darksky;
	day = datepart(time);
	format day YYMMDD10.;
run;

/* merge daily_dataset with information_households and weather_daily_darksky and bonify columns*/
proc sql;
%if %sysfunc(exist(CASUSER.daily_dataset_merged)) %then %do;
    drop table CASUSER.daily_dataset_merged;
%end;
%if %sysfunc(exist(CASUSER.daily_dataset_merged,VIEW)) %then %do;
    drop view CASUSER.daily_dataset_merged;
%end;
quit;
;
PROC SQL;
	CREATE TABLE CASUSER.daily_dataset_merged AS
		SELECT
			t2.LCLid,
			t2.'day'n,
			t2.energy_sum AS consumption,
			t2.isUkHoliday,
			t2.dayOfWeek,
			t2.dayOfYear,
			t1.stdorToU,
			t3.cloudCover,
			t3.windSpeed,
			t3.precipType,
			t3.uvIndex,
			(t3.sunsetTime - t3.sunriseTime)/3600 AS sunlightHours,
			t3.temperatureLow,
			t3.temperatureMin,
			t3.temperatureHigh,
			t3.temperatureMax,
			t3.summary
		FROM
			CASUSER.daily_dataset_augmented t2
				INNER JOIN CASUSER.INFORMATION_HOUSEHOLDS t1 ON (t2.LCLid = t1.LCLid)
				INNER JOIN CASUSER.WEATHER_DAILY_DARKSKY t3 ON (t2.'day'n = t3.'day'n)
	;
QUIT;
RUN;