--------------------
-- Sanity checks & quick indexes
--------------------

-- sanity counts
SELECT 'customer_features' AS table, COUNT(*) FROM analytics.customer_features;
SELECT 'support_calls' AS table, COUNT(*) FROM staging.support_calls_raw;
SELECT 'payments' AS table, COUNT(*) FROM staging.payments_raw;

-- Add indexes used by later queries 
CREATE INDEX IF NOT EXISTS idx_cf_customerid ON analytics.customer_features(customerid);
CREATE INDEX IF NOT EXISTS idx_cf_churn ON analytics.customer_features(churn_flag);
CREATE INDEX IF NOT EXISTS idx_cf_contract ON analytics.customer_features(contract);
CREATE INDEX IF NOT EXISTS idx_support_custid ON staging.support_calls_raw(customerid);
CREATE INDEX IF NOT EXISTS idx_payments_custid ON staging.payments_raw(customerid);
