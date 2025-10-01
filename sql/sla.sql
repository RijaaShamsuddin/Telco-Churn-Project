-- Support/ SLA diagnostics
-- metrics to support calls

-- avg resolution and % resolved
SELECT issue_type,
       COUNT(*) AS calls,
       AVG(CAST(resolution_time AS numeric)) AS avg_resolution_minutes,
       SUM(CASE WHEN LOWER(resolved) = 'yes' THEN 1 ELSE 0 END) AS resolved_count,
       ROUND(100.0 * SUM(CASE WHEN LOWER(resolved) = 'yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0),2) AS pct_resolved
FROM staging.support_calls_raw
GROUP BY issue_type
ORDER BY avg_resolution_minutes DESC;


