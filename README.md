# Telco-Churn-Project-Project 🚀

**Summary (30 seconds):**  
End-to-end case study to reduce revenue-at-risk from customer churn.  
I designed a workflow (ETL → SQL → Predictive model → BI Dashboard) that identified high-risk customers, simulated a retention offer, and projected **X% churn reduction and €Y revenue saved**.

---

## 🔎 Problem
Telco companies lose significant recurring revenue due to **high churn rates** among month-to-month customers.  
The goal: **diagnose churn drivers** and propose **data-backed interventions** with measurable business impact.  

Details in [problem.md](./problem.md).

---

## 📊 Approach
1. **Day 1 – Baseline & Data Quality**
   - Cleaned telco, support calls, and payments datasets.
   - Calculated baseline churn rate and revenue metrics.
   - Logged data quality issues.  
   Deliverables: [baseline metrics](./docs/baseline/)

2. **Day 2 – ETL & Feature Engineering**
   - Built `customers_features` table in Postgres (contract type, high monthly flag, support call stats).

3. **Day 3 – Segmentation & SQL Analysis**
   - Identified top churn drivers and at-risk segments.
   - Quantified revenue at risk.

4. **Day 4 – Predictive Modeling & ROI Simulation**
   - Logistic Regression model for churn prediction.
   - Simulated targeted retention offer and computed ROI.

5. **Day 5 – Dashboard & Storytelling**
   - Power BI dashboard with “Action Tab” (segments → retention action → projected impact).
   - [REPORT.pdf](./docs/REPORT.pdf) executive summary.

---

## 📂 Repository Structure
