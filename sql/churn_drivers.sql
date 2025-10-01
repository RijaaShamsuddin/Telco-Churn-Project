---------------------------------
-- Overall Churn Rate (percentage) 
---------------------------------
SELECT ROUND(100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0),2) AS overall_churn_pct
FROM analytics.customer_features;

---------------------------------
--churn by high_monthly in quarterly manner	
---------------------------------
WITH q AS (
  SELECT percentile_cont(ARRAY[0.25,0.5,0.75]) WITHIN GROUP (ORDER BY monthly_charges) AS p FROM analytics.customer_features
)
SELECT
  CASE
    WHEN monthly_charges <= (SELECT p[1] FROM q) THEN 'Q1'
    WHEN monthly_charges <= (SELECT p[2] FROM q) THEN 'Q2'
    WHEN monthly_charges <= (SELECT p[3] FROM q) THEN 'Q3'
    ELSE 'Q4'
  END AS charge_quartile,
  COUNT(*) AS customers,
  SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) AS churned,
  ROUND(100.0 * SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0),2) AS churn_pct
FROM analytics.customer_features
GROUP BY charge_quartile
ORDER BY charge_quartile;

---------------------------------
--Lift = segment_churn_pct / overall_churn_pct
---------------------------------
WITH overall AS (
  SELECT SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(*),0)::numeric AS overall_rate
  FROM analytics.customer_features
), seg AS (
  SELECT contract AS segment, SUM(CASE WHEN churn_flag THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(*),0)::numeric AS seg_rate
  FROM analytics.customer_features GROUP BY contract
)
SELECT segment, seg_rate, seg_rate / overall.overall_rate AS lift
FROM seg CROSS JOIN overall
ORDER BY lift DESC;
 	