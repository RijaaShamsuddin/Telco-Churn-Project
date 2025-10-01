
CREATE MATERIALIZED VIEW analytics.mv_revenue_by_month AS
  SELECT date_trunc('month', TO_DATE(payment_date,'YYYY-MM-DD')) AS month,
         SUM(amount::numeric) AS monthly_revenue
  FROM staging.payments_raw
  GROUP BY 1;
-- refresh with: REFRESH MATERIALIZED VIEW analytics.mv_revenue_by_month;

-- sql/mv_revenue_at_risk.sql
CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.mv_revenue_at_risk AS
SELECT * FROM analytics.vw_revenue_at_risk;

-- Refresh when you want the latest numbers:
-- REFRESH MATERIALIZED VIEW analytics.mv_revenue_at_risk;
