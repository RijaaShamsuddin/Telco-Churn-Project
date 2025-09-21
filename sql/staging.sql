-- staging schema for loading csv
-- analytics schema for processed tables
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS analytics;

-- staging.telco_raw
--DROP TABLE IF EXISTS staging.telco_raw;
CREATE TABLE staging.telco_raw (
  customerid TEXT,
  gender TEXT,
  seniorcitizen TEXT,
  partner TEXT,
  dependents TEXT,
  tenure TEXT,
  phoneservice TEXT,
  multiplelines TEXT,
  internetservice TEXT,
  onlinesecurity TEXT,
  onlinebackup TEXT,
  deviceprotection TEXT,
  techsupport TEXT,
  streamingtv TEXT,
  streamingmovies TEXT,
  contract TEXT,
  paperlessbilling TEXT,
  paymentmethod TEXT,
  monthlycharges TEXT,
  totalcharges TEXT,
  churn TEXT
);

-- staging.support_calls_raw
--DROP TABLE IF EXISTS staging.support_calls_raw;
CREATE TABLE staging.support_calls_raw (
  customerid TEXT,
  call_date TEXT,
  issue_type TEXT,
  resolution_time TEXT,
  resolved TEXT
);

-- staging.payments_raw
--DROP TABLE IF EXISTS staging.payments_raw;
CREATE TABLE staging.payments_raw (
  customerid TEXT,
  payment_date TEXT,
  amount TEXT,
  method TEXT
);

--using TEXT for staging avoids load errors.


-- Loading data in staging 
COPY staging.telco_raw
FROM 'D:/telco_clean.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');

COPY staging.payments_raw
FROM 'D:/payments.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');

COPY staging.support_calls_raw
FROM 'D:/support_calls.csv'
WITH (FORMAT csv, HEADER);


--Verifying the Load
-- row counts
SELECT 'telco' AS table, COUNT(*) FROM staging.telco_raw
UNION ALL
SELECT 'support_calls', COUNT(*) FROM staging.support_calls_raw
UNION ALL
SELECT 'payments', COUNT(*) FROM staging.payments_raw;

-- sample rows
SELECT * FROM staging.telco_raw LIMIT 5;
SELECT * FROM staging.support_calls_raw LIMIT 5;
SELECT * FROM staging.payments_raw LIMIT 5;

