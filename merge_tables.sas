/* flag instances in uk bank holidays */
proc sql;
    CREATE TABLE CASUSER.daily_dataset_flagged AS
    SELECT *, CASE WHEN daily_dataset.day IN (SELECT t1.'Bank holidays'n FROM CASUSER.uk_bank_holidays t1) THEN 1 ELSE 0 END AS is_uk_holiday
    FROM CASUSER.daily_dataset;
quit;

/* convert weather table time to date */
data CASUSER.weather_daily_darksky;
	set CASUSER.weather_daily_darksky;
	day = datepart(time);
	format day YYMMDD10.;
run;

/* merge daily_dataset with information_households and weather_daily_darksky */
proc sql;
%if %sysfunc(exist(CASUSER.QUERY_FOR_daily_dataset_flagged)) %then %do;
    drop table CASUSER.QUERY_FOR_daily_dataset_flagged;
%end;
%if %sysfunc(exist(CASUSER.QUERY_FOR_daily_dataset_flagged,VIEW)) %then %do;
    drop view CASUSER.QUERY_FOR_daily_dataset_flagged;
%end;
quit;
;
PROC SQL;
	CREATE TABLE CASUSER.daily_dataset_merged AS
		SELECT
			t2.LCLid,
			t2.'day'n,
			t2.energy_median,
			t2.energy_mean,
			t2.energy_max,
			t2.energy_std,
			t2.energy_sum,
			t2.energy_min,
			t2.is_uk_holiday,
			t1.stdorToU,
			t3.temperatureMax,
			t3.temperatureMaxTime,
			t3.icon,
			t3.cloudCover,
			t3.windSpeed,
			t3.precipType,
			t3.visibility,
			t3.uvIndex,
			t3.uvIndexTime,
			t3.sunriseTime,
			t3.sunsetTime,
			t3.temperatureLow,
			t3.temperatureLowTime,
			t3.temperatureMin,
			t3.temperatureMinTime,
			t3.temperatureHigh,
			t3.temperatureHighTime
		FROM
			CASUSER.DAILY_DATASET_FLAGGED t2
				INNER JOIN CASUSER.INFORMATION_HOUSEHOLDS t1 ON (t2.LCLid = t1.LCLid)
				INNER JOIN CASUSER.WEATHER_DAILY_DARKSKY t3 ON (t2.'day'n = t3.'day'n)
	;
QUIT;
RUN;