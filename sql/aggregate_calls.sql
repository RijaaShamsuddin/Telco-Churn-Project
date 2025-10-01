-- join support features with customer_features to see whether recent unresolved calls increase churn
SELECT
  cf.calls_last_90d,
  cf.unresolved_calls_90d,
  COUNT(*) AS customers,
  SUM(CASE WHEN cf.churn_flag THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN cf.churn_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0),2) AS churn_pct
FROM analytics.customer_features cf
GROUP BY cf.calls_last_90d, cf.unresolved_calls_90d
ORDER BY churn_pct DESC NULLS LAST;
--LIMIT 50;
SELECT * FROM analytics.customer_features
where calls_last_90d is not null and calls_last_90d > 0;