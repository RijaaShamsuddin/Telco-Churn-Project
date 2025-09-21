--Building a cleaner customer table 
------Tasks
--1. Convert TotalCharges to numeric (may contain blanks).
--2. Create tenure buckets.
--3. Add churn flag as BOOLEAN.
--4. Normalize column names to snake_case.

DROP TABLE IF EXISTS analytics.customers;
CREATE TABLE IF NOT EXISTS analytics.customers AS
SELECT
    customerid,
    LOWER(contract) AS contract,
    CAST(REPLACE(NULLIF(totalcharges, ''), ' ', '0') AS NUMERIC) AS total_charges,
    monthlycharges::NUMERIC AS monthly_charges,
    tenure::INT,
    CASE WHEN churn='Yes' THEN TRUE ELSE FALSE END AS churn_flag,
    CASE 
        WHEN tenure::INT < 6 THEN '0-6'
        WHEN tenure::INT < 12 THEN '6-12'
        WHEN tenure::INT < 24 THEN '12-24'
        WHEN tenure::INT < 48 THEN '24-48'
        ELSE '48+'
    END AS tenure_bucket
FROM staging.telco_raw;

-- Add index for faster joins/filters
CREATE INDEX ON analytics.customers(customerid);
CREATE INDEX ON analytics.customers(churn_flag);
