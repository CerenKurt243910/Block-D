-- Question 1: Retrieve EUR/USD and GBP/USD exchange rates for the year 2020 to observe yearly trends
SELECT 
    date_value, 
    eurusd, 
    gbpusd
FROM 
    exchange_rates
WHERE 
    date_value BETWEEN '2020-01-01' AND '2020-12-31'
ORDER BY 
    date_value;

-- Question 2: Identify all unique stock indices present in the dataset
SELECT DISTINCT stock_index
FROM stock_indices;

-- Question 3: Find days when the gold price closed higher than it opened, indicating gains
SELECT date_value, open_value, close_value
FROM gold
WHERE close_value > open_value
ORDER BY date_value;

-- Question 4: Compute the daily gain in crude oil by subtracting open from close price
SELECT 
    date_value,
    open_value,
    close_value,
    close_value - open_value AS daily_gain
FROM crude_oil
ORDER BY date_value;

-- Question 5: Calculate the average inflation rate using CPI values
SELECT 
    AVG(inflation_cpi) AS avg_inflation_rate
FROM 
    macro_economic_indicators;

-- Question 6: Count how many days the gold price closed above $1800
SELECT 
    COUNT(*) AS days_above_1800
FROM 
    gold
WHERE 
    close_value > 1800;

-- Question 7: Find days with significant daily range (high - low) in NASDAQ 100
SELECT 
    date_value,
    stock_index,
    high_value,
    low_value,
    (high_value - low_value) AS daily_range
FROM 
    stock_indices
WHERE 
    (high_value - low_value) > 300
ORDER BY 
    daily_range DESC;

-- Question 8: Find the top 5 stocks with the highest daily price changes (|close - open|)
SELECT 
    date_value,
    stock_index,
    open_value,
    close_value,
    ABS(close_value - open_value) AS price_change
FROM 
    stock_indices
ORDER BY 
    price_change DESC
LIMIT 5;

-- Question 9: Join unemployment data with stock indices to analyze macroeconomic correlation
SELECT 
    si.date_value,
    si.stock_index,
    si.close_value,
    mi.unemployment_rate
FROM 
    stock_indices si
JOIN 
    macro_economic_indicators mi
ON 
    si.date_value = mi.date_value
ORDER BY 
    si.date_value
LIMIT 10;

-- Question 10: Compare stock close prices with the previous day
SELECT 
    current.date_value AS current_day,
    current.stock_index,
    current.close_value AS current_close,
    previous.date_value AS previous_day,
    previous.close_value AS previous_close,
    (current.close_value - previous.close_value) AS price_change
FROM 
    stock_indices current
JOIN 
    stock_indices previous
ON 
    current.stock_index = previous.stock_index
    AND current.date_value = previous.date_value + INTERVAL '1 day'
ORDER BY 
    current.date_value;

-- Question 11: Categorize opening oil prices for 2021 and 2022
SELECT 
    date_value,
    open_value,
    EXTRACT(YEAR FROM date_value) AS year,
    CASE 
        WHEN open_value > 90 THEN 'High'
        WHEN open_value BETWEEN 60 AND 90 THEN 'Medium'
        ELSE 'Low'
    END AS price_category
FROM 
    crude_oil
WHERE 
    EXTRACT(YEAR FROM date_value) IN (2021, 2022)
ORDER BY 
    date_value;

-- Question 12: Pick a ticker and for the year 2022 analyse whether the stock closed “up” “down” or “no change”
SELECT
    date_value,
    company_prefix,
    open_value,
    close_value,
    CASE
        WHEN close_value > open_value THEN 'Up'
        WHEN close_value < open_value THEN 'Down'
        ELSE 'No Change'
    END AS day_status
FROM
    nasdaq_100_daily
WHERE
    EXTRACT(YEAR FROM date_value) = 2022
    AND company_prefix = 'AAPL'
ORDER BY
    date_value;

-- Question 13: Join unemployment data with stock indices to analyze macroeconomic correlation
SELECT
    s.date_value,
    s.stock_index,
    s.close_value AS stock_close,
    m.unemployment_rate
FROM
    stock_indices s
JOIN
    macro_economic_indicators m
ON
    s.date_value = m.date_value
ORDER BY
    s.date_value
LIMIT 100;

-- Question 14: Compare stock price trends of one day with the previous day
SELECT 
    today.date_value,
    today.company_prefix,
    today.close_value AS close_today,
    yesterday.close_value AS close_yesterday,
    (today.close_value - yesterday.close_value) AS price_change
FROM 
    nasdaq_100_daily today
JOIN 
    nasdaq_100_daily yesterday 
ON 
    today.company_prefix = yesterday.company_prefix
    AND today.date_value = yesterday.date_value + INTERVAL '1 day'
ORDER BY 
    today.company_prefix, today.date_value
LIMIT 100;

-- Question 15: Categorise oil prices for 2021 and 2022
SELECT 
    date_value,
    open_value,
    EXTRACT(YEAR FROM date_value) AS year,
    CASE
        WHEN open_value > 90 THEN 'High'
        WHEN open_value BETWEEN 60 AND 90 THEN 'Medium'
        ELSE 'Low'
    END AS price_category
FROM 
    crude_oil
WHERE 
    EXTRACT(YEAR FROM date_value) IN (2021, 2022)
ORDER BY 
    date_value
LIMIT 100;

-- Question 16: Analyse if a stock closed up, down, or no change in 2022
SELECT 
    date_value,
    company_prefix,
    open_value,
    close_value,
    CASE
        WHEN close_value > open_value THEN 'Up'
        WHEN close_value < open_value THEN 'Down'
        ELSE 'No Change'
    END AS price_movement
FROM 
    nasdaq_100_daily
WHERE 
    EXTRACT(YEAR FROM date_value) = 2022
    AND company_prefix = 'AAPL'
ORDER BY 
    date_value
LIMIT 100;

-- Question 17: 7-day moving average of gold prices
CREATE TABLE s243910_level4_gold AS
SELECT 
    date_value,
    close_value,
    ROUND(
        AVG(close_value) OVER (
            ORDER BY date_value
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        )::numeric, 2
    ) AS moving_avg_7day
FROM 
    gold;

-- Question 18: Rank crude oil closing prices in descending order
DROP TABLE IF EXISTS s243910_level4_crude_oil;
CREATE TABLE s243910_level4_crude_oil AS
SELECT 
    date_value,
    close_value,
    RANK() OVER (ORDER BY close_value DESC) AS closing_price_rank
FROM 
    crude_oil;

-- Question 19: Calculate a rolling average over 5 days (2 before and after) for closing price
CREATE TABLE s243910_level4_rolling_avg AS
SELECT 
    date_value,
    close_value,
    AVG(close_value) OVER (
        ORDER BY date_value 
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) AS rolling_avg_5day
FROM 
    gold;

