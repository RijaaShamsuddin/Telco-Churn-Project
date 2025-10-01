---------------------------------
-- Churn by payment
---------------------------------
CREATE OR REPLACE VIEW analytics.vw_churn_by_paymentmethod AS
SELECT payment_method, COUNT(*) AS customers,
  SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS churn_pct
FROM analytics.customer_features
GROUP BY payment_method
ORDER BY churn_pct DESC;