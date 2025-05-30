#  Sales Forecasting with Time Series Analysis (SAS)

This project performs sales forecasting using time series modeling on weekly retail data. Implemented entirely in SAS, it includes data preprocessing, visualization, and ARIMA-based forecasting.

---

##  Dataset

**File**: `walmart_sales_data.csv`  
**Source**: Local input  
**Columns**:
- `Date`: Week start date
- `Weekly_Sales`: Sales for the week
- `Holiday_Flag`: Whether the week included a major holiday
- `Temperature`: Average temperature for the week
- `Fuel_Price`: Average fuel price
- `CPI`: Consumer Price Index
- `Unemployment`: Weekly unemployment rate

---

##  Project Flow

1. **Data Import**  
   - Using `PROC IMPORT` to read `wm.csv`.

2. **Data Cleaning**
   - Ensuring correct date parsing with `ANYDTDTE.` informat.
   - Removing rows with missing or invalid dates and sales values.

3. **Exploratory Visualization**
   - Plotting clean weekly sales trend over time using `PROC SGPLOT`.

4. **Time Series Preparation**
   - Creating time series structure using `PROC TIMESERIES`.

5. **Modeling with ARIMA**
   - Using `PROC ARIMA` to identify, estimate, and forecast future weekly sales.
   - Evaluating stationarity with ADF test.

6. **Forecast Visualization**
   - Showing both actual and forecasted values with 95% confidence intervals.

---

##  Key SAS Features Used

- `PROC IMPORT`, `PROC CONTENTS`, `PROC SQL`, `PROC SGPLOT`
- `INPUT()` with `ANYDTDTE.` to handle multiple date formats
- `PROC TIMESERIES` and `PROC ARIMA` for time series modeling

---

##  Output

- Weekly sales time series chart  
- ARIMA model forecast graph  
- Forecast values with confidence intervals

---

##  Requirements

- SAS Studio or any SAS environment with:
  - `PROC IMPORT`
  - `PROC ARIMA`
  - `PROC TIMESERIES`

---



