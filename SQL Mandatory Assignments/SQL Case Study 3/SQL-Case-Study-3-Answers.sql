--1. Count of Customers with Transactions in 2020 by Region:
SELECT c.region_id, cnt.region_name, 
COUNT(DISTINCT c.customer_id) AS customer_count
FROM [CaseStudy03].[dbo].[Customers] c
JOIN [CaseStudy03].[dbo].[Continent] cnt ON c.region_id = cnt.region_id
JOIN [CaseStudy03].[dbo].[Transaction] t ON c.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2020
GROUP BY c.region_id, cnt.region_name;

--2.Minimum and Maximum Transaction Amount by Type:

SELECT txn_type, MIN(txn_amount) AS min_amount, MAX(txn_amount) AS max_amount 
FROM [CaseStudy03].[dbo].[Transaction]
GROUP BY txn_type;

-- 3.Customers with Deposits over $2000:

SELECT c.customer_id, cnt.region_name, t.txn_amount 
FROM [CaseStudy03].[dbo].[Customers] c
JOIN [CaseStudy03].[dbo].[Continent] cnt ON c.region_id = cnt.region_id
JOIN [CaseStudy03].[dbo].[Transaction] t ON c.customer_id = t.customer_id
WHERE t.txn_type = 'deposit' AND t.txn_amount > 2000;

--4.Find Duplicate Records in Customers Table:

SELECT customer_id, COUNT(*) AS cnt
  FROM Customers
  GROUP BY customer_id
  HAVING COUNT(*) >1

