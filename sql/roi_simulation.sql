-- calculating ROI to target the question 
-- “If I target high-risk customers with an offer (e.g. a €20 credit), does it pay off by retaining revenue that would otherwise churn?”
SELECT
    'high_risk_customers' AS segment,
    total_customers,
    total_monthly_revenue,
    20::NUMERIC AS cost_per_offer,          -- assumption: €20 offer per customer
    total_customers * 20::NUMERIC AS total_cost,
    0.25::NUMERIC AS uplift,                -- assumption: 25% retention uplift
    total_monthly_revenue * 0.25::NUMERIC AS revenue_saved,
    (total_monthly_revenue * 0.25::NUMERIC) - (total_customers * 20::NUMERIC) AS net_benefit,
    ROUND(
        ((total_monthly_revenue * 0.25::NUMERIC) - (total_customers * 20::NUMERIC)) 
        / NULLIF((total_customers * 20::NUMERIC), 0), 4
    ) AS roi
FROM analytics.vw_revenue_at_risk;
