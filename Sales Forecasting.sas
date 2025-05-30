/* Generated Code (IMPORT) */
/* Source File: wm.csv */
/* Source Path: /home/u64242476 */
/* Code generated on: 30/05/2025 12:10 */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u64242476/wm.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);
DATA clean_sales;
    SET WORK.IMPORT;

    /* Handle character to SAS date format conversion */
    Date_fixed = INPUT(Date, yymmdd10.);
    FORMAT Date_fixed DATE9.;
RUN;
PROC SORT DATA=clean_sales;
    BY Date_fixed;
RUN;
PROC SQL;
    CREATE TABLE weekly_sales AS
    SELECT Date_fixed AS Date FORMAT=DATE9.,
           SUM(Weekly_Sales) AS Total_Sales
    FROM clean_sales
    GROUP BY Date_fixed
    ORDER BY Date_fixed;
QUIT;
TITLE "Clean Weekly Sales Over Time";
PROC SGPLOT DATA=weekly_sales;
    SERIES X=Date Y=Total_Sales /
        LINEATTRS=(COLOR=blue THICKNESS=2)
        MARKERS;
    XAXIS LABEL="Week";
    YAXIS LABEL="Total Weekly Sales";
RUN;
ROC TIMESERIES DATA=weekly_sales OUT=ts_sales;
    ID Date INTERVAL=week ACCUMULATE=total;
    VAR Total_Sales;
RUN;
PROC PRINT DATA=ts_sales (OBS=10);
RUN;


DATA sales_data;
    SET WORK.IMPORT;

    Date_fixed = INPUT(Date, yymmdd10.); 

    FORMAT Date_fixed DATE9.;
RUN;

PROC PRINT DATA=sales_data (OBS=5);
RUN;
TITLE "Weekly Sales Over Time";
PROC SGPLOT DATA=sales_data;
	SERIES X=Date Y=Weekly_Sales / LINEATTRS=(COLOR=blue THICKNESS=2);
	XAXIS LABEL="Date";
	YAXIS LABEL="Weekly Sales";
RUN;
PROC TIMESERIES DATA=sales_data OUT=ts_sales;
	ID Date INTERVAL=week ACCUMULATE=total;
	VAR Weekly_Sales;
RUN;
PROC ARIMA DATA=ts_sales;
	IDENTIFY VAR=Weekly_Sales(1) STATIONARITY=(ADF);
RUN;
PROC ARIMA DATA=ts_sales;
	IDENTIFY VAR=Weekly_Sales(1);
	ESTIMATE P=1 Q=1 METHOD=ML;
	FORECAST LEAD=12 OUT=forecast_sales;
RUN;
TITLE "Sales Forecast using ARIMA Model";
PROC SGPLOT DATA=forecast_sales;
	SERIES X=Date Y=Forecast / LINEATTRS=(COLOR=green PATTERN=solid);
	BAND X=Date LOWER=L95 UPPER=U95 / TRANSPARENCY=0.5;
	SERIES X=Date Y=Weekly_Sales / LINEATTRS=(COLOR=black THICKNESS=2);
	XAXIS LABEL="Date";
	YAXIS LABEL="Weekly Sales";
RUN;


