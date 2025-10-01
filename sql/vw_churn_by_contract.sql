---------------------------------
-- Churn by contract
---------------------------------
CREATE OR REPLACE VIEW analytics.vw_churn_by_contract AS
SELECT
  contract,
  COUNT(*) AS customers,
  SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS churn_pct,
  ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges
FROM analytics.customer_features
GROUP BY contract
ORDER BY churn_pct DESC;


--SELECT * FROM analytics.vw_churn_by_contract