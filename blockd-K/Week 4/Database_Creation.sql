-- Active: 1746524308726@@194.171.191.226@3432@group_17_warehouse
CREATE TABLE users (
    user_id INT PRIMARY KEY, 
    name VARCHAR(100), 
    email VARCHAR(100), 
    phone VARCHAR(20), 
    age INT, 
    account_type VARCHAR(50),
    date_of_register DATE

);

CREATE TABLE portfolios (
    portfolio_id INT PRIMARY KEY,
    user_id INT,
    investments DECIMAL (15,2),
    profits DECIMAL(15,2),
    pportfolio_type VARCHAR(50),
    diversity VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
);

CREATE TABLE assets (
    asset_id INT PRIMARY KEY,
    asset_name VARCHAR(50),
    asset_type VARCHAR(50),
    asset_risk VARCHAR(50),
    stock_ex VARCHAR(50),
);

CREATE TABLE stock_metrics (
    Date DATE,
    Open_x FLOAT,
    High_x FLOAT,
    Low_x FLOAT,
    Close_x FLOAT,
    Volume_x FLOAT,
    transactions INT,
    Ticker VARCHAR(10),

    close_lag FLOAT,
    volume_lag FLOAT,
    close_diff FLOAT,
    volume_diff FLOAT,

    close_mean_10_days FLOAT,
    close_std_10_days FLOAT,
    close_max_10_days FLOAT,

    close_mean_30_days FLOAT,
    close_std_30_days FLOAT,
    close_max_30_days FLOAT,

    EMA_close_10_days FLOAT,
    EMA_close_30_days FLOAT,

    RSI_14_days FLOAT,

    bb_percent_b_20 FLOAT,
    bb_bandwidth_20 FLOAT,
    bb_upper_20 FLOAT,
    bb_lower_20 FLOAT,
    bb_middle_20 FLOAT,

    bb_percent_b_50 FLOAT,
    bb_bandwidth_50 FLOAT,
    bb_upper_50 FLOAT,
    bb_lower_50 FLOAT,
    bb_middle_50 FLOAT,

    timestamp DATE,

    return_1min FLOAT,
    return_5min FLOAT,
    return_15min FLOAT,
    return_30min FLOAT,

    velocity_5min FLOAT,
    acceleration_5min FLOAT,

    volume_roc_5min FLOAT,
    volume_roc_15min FLOAT,
    volume_ma_20 FLOAT,
    volume_ratio FLOAT,

    realized_vol_5min FLOAT,
    realized_vol_15min FLOAT,
    realized_vol_60min FLOAT,

    Target FLOAT,
    EPS_Estimate FLOAT,
    EPS_Actual FLOAT,
    EPS_Surprise FLOAT,
    Surprise_percent FLOAT
);
SELECT * FROM stock_metrics;
DELETE FROM stock_metrics
WHERE Ticker NOT IN ('GOOG', 'AAPL', 'QCOM');




ALTER TABLE stock_metrics
DROP COLUMN Open_x,
DROP COLUMN High_x,
DROP COLUMN Low_x,
DROP COLUMN Volume_x,
DROP COLUMN transactions,
DROP COLUMN volume_lag,
DROP COLUMN close_diff,
DROP COLUMN volume_diff,
DROP COLUMN RSI_14_days,
DROP COLUMN bb_percent_b_20,
DROP COLUMN bb_bandwidth_20,
DROP COLUMN bb_percent_b_50,
DROP COLUMN bb_bandwidth_50,
DROP COLUMN return_1min,
DROP COLUMN return_5min,
DROP COLUMN return_15min,
DROP COLUMN return_30min,
DROP COLUMN velocity_5min,
DROP COLUMN acceleration_5min,
DROP COLUMN volume_roc_5min,
DROP COLUMN volume_roc_15min,
DROP COLUMN volume_ma_20,
DROP COLUMN volume_ratio,
DROP COLUMN realized_vol_5min,
DROP COLUMN realized_vol_15min,
DROP COLUMN realized_vol_60min


-- \COPY (SELECT * FROM stock_metrics) TO 'filtered_stock_data.csv' WITH CSV HEADER;

CREATE TABLE ModelPerformance (
    Company VARCHAR(10),
    Model VARCHAR(50),
    R2_Score_Test_Set FLOAT,
    Notes VARCHAR(255)
);