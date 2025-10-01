---------------------------------
-- Overall churn & basic KPIs view
---------------------------------
CREATE OR REPLACE VIEW analytics.vw_overall_churn AS
SELECT
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) AS churn_count,
  ROUND(100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS churn_pct,
  ROUND(AVG(monthly_charges)::numeric,2) AS avg_monthly_charges,
  ROUND(SUM(monthly_charges)::numeric,2) AS total_monthly_revenue
FROM analytics.customer_features;

--SELECT * FROM analytics.vw_overall_churn
