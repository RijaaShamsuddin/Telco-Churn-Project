---------------------------------
--Revenue at risk & prioritization
--Compute revenue at risk per segment and create a prioritized list for retention.
--Assume parameter assumed_months = 6 (tune later). 
--This query computes monthly revenue per segment and revenue at risk if churn occurs for next assumed_months.
---------------------------------

CREATE OR REPLACE VIEW analytics.vw_revenue_at_risk AS
WITH params AS (SELECT 6 AS months_assumed), -- can change horizon of months from here
seg AS (
  SELECT contract AS segment,
         COUNT(*) AS total_customers,
         SUM(monthly_charges)::numeric AS total_monthly_revenue,
         SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)::numeric AS churned_count,
         ROUND(100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0),2) AS churn_pct
  FROM analytics.customer_features
  GROUP BY contract
)
SELECT
  segment,
  total_customers,
  churned_count,
  churn_pct,
  total_monthly_revenue,
  -- expected revenue at risk (if churn happens for months_assumed)
  ROUND((total_monthly_revenue * params.months_assumed * (churn_pct/100.0)),2) AS revenue_at_risk_estimated,
  params.months_assumed AS months_horizon
FROM seg, params
ORDER BY revenue_at_risk_estimated DESC;

