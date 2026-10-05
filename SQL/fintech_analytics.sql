CREATE DATABASE fintech_analytics;

USE FINTECH_ANALYTICS;

CREATE TABLE transactions(
Transaction_ID VARCHAR(30) PRIMARY KEY,
Customer_ID varchar(30),
Transaction_Date datetime,
Amount_INR decimal(12,2),
Transaction_Type VARCHAR(30),
Payment_Method VARCHAR(30),
Merchant_Category VARCHAR(50),
State VARCHAR(50),
City VARCHAR(60),
PIN_Code INT,
Bank VARCHAR(100),
Device_Type VARCHAR(60),
Customer_Age INT,
Account_Age_Days INT,
Transaction_Status VARCHAR(50),
Is_Fraud INT,
Fraud_Type VARCHAR(60)

);

SELECT * FROM TRANSACTIONS;
select count(*) as total_transactions
from transactions;

select 
count(*) as total_transactions,
round(sum(Amount_INR), 2) as total_transaction_value,
round(avg(Amount_INR), 2) as average_transaction_value,
min(Amount_INR) as minimum_transaction,
max(Amount_INR) as maximum_transaction
from transactions;

SELECT
    COUNT(*) AS total_transactions,
    SUM(Is_Fraud) AS fraud_transactions,
    ROUND(SUM(CASE WHEN Is_Fraud = 1 THEN Amount_INR ELSE 0 END), 2) AS fraud_amount,
    ROUND(SUM(Is_Fraud) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM transactions;

SELECT
    Payment_Method,
    COUNT(*) AS total_transactions,
    SUM(Is_Fraud) AS fraud_transactions,
    ROUND(SUM(Is_Fraud) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM transactions
GROUP BY Payment_Method
ORDER BY fraud_rate DESC;

SELECT
    State,
    COUNT(*) AS total_transactions,
    SUM(Is_Fraud) AS fraud_transactions,
    ROUND(SUM(Is_Fraud) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM transactions
GROUP BY State
ORDER BY fraud_rate DESC;


SELECT
    DATE_FORMAT(Transaction_Date, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    SUM(Is_Fraud) AS fraud_transactions,
    ROUND(SUM(Amount_INR), 2) AS total_transaction_value,
    ROUND(SUM(CASE WHEN Is_Fraud = 1 THEN Amount_INR ELSE 0 END), 2) AS fraud_amount
FROM transactions
GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
ORDER BY month;


SELECT
    Transaction_ID,
    Customer_ID,
    Transaction_Date,
    Amount_INR,
    Payment_Method,
    Merchant_Category,
    City,
    State,
    Bank,
    Fraud_Type
FROM transactions
WHERE Is_Fraud = 1
ORDER BY Amount_INR DESC
LIMIT 10;