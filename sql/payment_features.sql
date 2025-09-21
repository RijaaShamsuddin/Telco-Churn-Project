--Aggregate Payments
------Tasks
--1. Number of late payments (if late_flag exists).
--2. Last payment date.

DROP TABLE IF EXISTS analytics.payment_features;
CREATE TABLE IF NOT EXISTS analytics.payment_features AS
SELECT
    customerid,
    AVG(amount::NUMERIC) AS avg_payment,
	COUNT(*) FILTER (WHERE method IS NULL OR TRIM(method)='') AS missing_method_count,
	MAX(TO_DATE(payment_date,'YYYY-MM-DD')) AS last_payment_date
FROM staging.payments_raw
GROUP BY customerid;

