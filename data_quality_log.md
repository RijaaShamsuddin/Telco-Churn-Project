# Data Quality Log

This file records issues found in the datasets and actions taken to address them.  
Keeping a transparent log shows the data is not blindly trusted.

---

## Issues Found & Fixes

1. **Null / Blank Values**
   - `TotalCharges` had blank entries for customers with tenure = 0.
   - **Fix:** Replaced with 0 or cast as numeric with `NULLIF`.

2. **Data Type Mismatch**
   - `TotalCharges` loaded as text instead of numeric.
   - **Fix:** Converted to `NUMERIC` after cleaning.

3. **Duplicates**
   - Some duplicate `customerID` entries in `telco_clean`.
   - **Fix:** Retained first occurrence, flagged others for review.

4. **Date Inconsistencies**
   - `support_calls.call_date` contained nulls.
   - **Fix:** Dropped null rows for recent-call features.

---

## Outstanding Checks (to revisit)
- Validate that payment records align with billing cycles.  
- Cross-check churn flag vs. contract end dates.  
- Outlier analysis for `MonthlyCharges` (extremely high values).
