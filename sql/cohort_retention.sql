---------------------------------
--Cohort & retention analysis 
--(payments → cohort by first payment month)
--using staging.payments_raw to compute first_payment_month per customer and retention by months since first payment.
---------------------------------


-- cohort base: first payment month
WITH first_pay AS (
  SELECT customerid,
         date_trunc('month', TO_DATE(payment_date,'YYYY-MM-DD'))::date AS cohort_month
  FROM staging.payments_raw
  GROUP BY customerid,cohort_month
),
payments_months AS (
  SELECT customerid,
         date_trunc('month', TO_DATE(payment_date,'YYYY-MM-DD'))::date AS pay_month
  FROM staging.payments_raw
),
activity AS (
  SELECT
    f.cohort_month,
    pm.pay_month,
    (EXTRACT(YEAR FROM pm.pay_month)::int - EXTRACT(YEAR FROM f.cohort_month)::int)*12
       + (EXTRACT(MONTH FROM pm.pay_month)::int - EXTRACT(MONTH FROM f.cohort_month)::int) AS months_since_cohort,
    COUNT(DISTINCT pm.customerid) AS active_customers
  FROM first_pay f
  JOIN payments_months pm ON f.customerid = pm.customerid
  GROUP BY 1,2,3
)
SELECT cohort_month, months_since_cohort, active_customers
FROM activity
ORDER BY cohort_month, months_since_cohort
