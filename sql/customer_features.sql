-- Join all features into one consolidated table:
DROP TABLE IF EXISTS analytics.customer_features;
CREATE TABLE IF NOT EXISTS analytics.customer_features AS
SELECT
    c.customerid,
    c.contract,
    c.total_charges,
    c.monthly_charges,
    c.tenure,
    c.tenure_bucket,
    c.churn_flag,
	c.payment_method,
    s.calls_last_90d,
    s.unresolved_calls_90d,
    s.avg_resolution_time,
    p.avg_payment,
    p.missing_method_count,
    p.last_payment_date
FROM analytics.customers c
LEFT JOIN analytics.support_features s ON c.customerid = s.customerid
LEFT JOIN analytics.payment_features p ON c.customerid = p.customerid;

CREATE INDEX ON analytics.customer_features(customerid);
