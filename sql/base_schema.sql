-- Create Database
CREATE DATABASE telco_project
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
-- Customers table
CREATE TABLE customers (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    seniorCitizen INT,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INT,
    phoneService VARCHAR(5),
    multipleLines VARCHAR(20),
    internetService VARCHAR(20),
    onlineSecurity VARCHAR(20),
    onlineBackup VARCHAR(20),
    deviceProtection VARCHAR(20),
    techSupport VARCHAR(20),
    streamingTV VARCHAR(20),
    streamingMovies VARCHAR(20),
    contract VARCHAR(20),
    paperlessBilling VARCHAR(5),
    paymentMethod VARCHAR(30),
    monthlyCharges NUMERIC,
    totalCharges NUMERIC,
    churn VARCHAR(5)
);

-- Support Calls table
CREATE TABLE support_calls (
    call_id VARCHAR(20) PRIMARY KEY,
    customerID VARCHAR(20),
    call_date DATE,
    issue_type VARCHAR(20),
    resolution_time INT,
    resolved VARCHAR(5),
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

-- Payments table
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    customerID VARCHAR(20),
    payment_date DATE,
    amount NUMERIC,
    method VARCHAR(20),
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

SELECT 'customers' AS table, COUNT(*) FROM base.customers
UNION ALL
SELECT 'support_calls', COUNT(*) FROM base.support_calls
UNION ALL
SELECT 'payments', COUNT(*) FROM base.payments;

-- find rows with empty customerid
SELECT COUNT(*) FROM staging.telco_raw WHERE customerid IS NULL OR TRIM(customerid) = '';

-- check totalcharges blanks
SELECT COUNT(*) FROM staging.telco_raw WHERE TRIM(totalcharges) = '' OR totalcharges IS NULL;
