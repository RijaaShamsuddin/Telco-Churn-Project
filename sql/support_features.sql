--Aggregate Support Calls
------Tasks
--1. Total calls in last 90 days.
--2. Count of unresolved calls.
--3. Avg resolution time.

DROP TABLE IF EXISTS analytics.support_features;
CREATE TABLE IF NOT EXISTS analytics.support_features AS
SELECT
    customerid,
    COUNT(*) FILTER (WHERE call_date::DATE >= CURRENT_DATE - INTERVAL '90 days') AS calls_last_90d,
    COUNT(*) FILTER (WHERE resolved='No' AND call_date::DATE >= CURRENT_DATE - INTERVAL '90 days') AS unresolved_calls_90d,
    AVG(resolution_time::INT) AS avg_resolution_time
FROM staging.support_calls_raw
GROUP BY customerid;
