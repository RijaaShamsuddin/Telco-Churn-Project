# Telco-Churn-Optimization-Project 🚀

**Summary:**  
End-to-end case study to reduce revenue-at-risk from customer churn.  
I designed a workflow (ETL → SQL → Predictive model → BI Dashboard) that identified high-risk customers, simulated a retention offer, and projected **X% churn reduction and €Y revenue saved**.

---

# Telecom Customer Churn Analysis

## 📌 Problem Statement
Customer churn is a major challenge for subscription-based businesses like telecom operators. High churn leads to significant revenue loss, and businesses often invest in retention campaigns to reduce it.  

This project answers:
- What are the main drivers of churn?  
- Which customer segments are at the highest risk of leaving?  
- Can offering targeted retention credits (e.g., €20 offers) reduce churn and improve ROI?  

---

## 🛠️ Solution Approach

### Data Extraction & Preparation
- ETL pipeline (`etl_pipeline.py`) created to clean and transform customer, contract, and payment data.
- Engineered features (e.g., tenure buckets, churn flags, payment delays).
- Analytics views (`analytics.*`) created for reporting.

### Business Metrics & Churn Analysis
- **Churn Rate**: overall % of customers leaving.
- **Churn Breakdown**: by contract type, tenure, and payment method.
- **Cohort Retention**: retention trends across signup cohorts.
- **Revenue at Risk**: monthly recurring revenue at risk from high-risk segments.

All results exported via `export_results.py` into `/docs/*.csv` for reproducibility and BI.

### ROI Simulation
Hypothesis: *“If we target high-risk customers with a €20 retention credit, will it pay off by reducing churn?”*  

Assumptions:  
- `cost_per_offer = 20`  
- `uplift_in_retention = 0.25` (25% relative churn reduction)  

Formula:  
`ROI = (Revenue Saved – Cost of Offers) ÷ Cost of Offers`

**Result:** ROI values were negative (–0.17, –0.18, –0.24).  
👉 Blanket €20 offers to high-risk customers do not increase revenue.

### Multi-Platform Implementation
- **SQL**: All metrics + ROI implemented as queries and views.  
- **Python**: Automated CSV exports for reproducibility.  
- **Power BI (DAX)**: Interactive dashboard with ROI simulation slider and churn drill-downs.  

---

## 📊 Power BI Dashboard
Pages included:
1. **Churn Overview** – KPIs and trend lines.  
2. **Churn Drivers** – bar charts by contract, tenure, payment.  
3. **Revenue at Risk** – segment breakdown.  
4. **ROI Simulation** – “what-if” parameters for costs and uplift.  

---

## 📂 Repository Structure
├── sql/
│ ├── customers.sql
│ ├── support_features.sql
│ ├── churn_drivers.sql
│ ├── revenue_at_risk.sql
│ └── roi_simulation.sql
│
├── python/
│ ├── etl_pipeline.py
│ ├── export_results.py
│ └── utils.py
│
├── docs/
│ ├── baseline_kpis.csv
│ ├── churn_by_contract.csv
│ ├── cohort_activity.csv
│ ├── top_revenue_risk_segments.csv
│ ├── query_performance.md
│ ├── day3_results.md
│ └── README.md
│
├── powerbi/
│ └── Churn_Dashboard.pbix
│
└── README.md


---

## 🚀 Key Learnings
- End-to-end workflow: **ETL → Analytics → BI → Recommendation**.  
- Negative ROI insights are valuable for preventing wasted spend.  
- Same business logic demonstrated in **SQL, Python, and Power BI**.  

---
ROI Simulation (interactive “what-if” analysis with DAX parameters)
