--Aggregate Support Calls
------Tasks
--1. Total calls in last 90 days.
--2. Count of unresolved calls.
--3. Avg resolution time.

DROP TABLE IF EXISTS analytics.support_features;
CREATE TABLE IF NOT EXISTS analytics.support_features AS
SELECT
    customerid, issue_type, resolved,
    COUNT(*) FILTER (WHERE TO_DATE(call_date, 'MM/DD/YYYY') >= '2023-01-01'::DATE - INTERVAL '90 days') AS calls_last_90d,
    COUNT(*) FILTER (WHERE resolved='No' AND TO_DATE(call_date, 'MM/DD/YYYY') <= '2023-01-01'::DATE - INTERVAL '90 days') AS unresolved_calls_90d,
    ROUND(AVG(resolution_time::INT),2) AS avg_resolution_time,
	COUNT(*) AS Resolved_char
FROM staging.support_calls_raw
GROUP BY customerid, issue_type, resolved;

