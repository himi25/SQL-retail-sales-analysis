CREATE TABLE retail_sales
(
 transactions_id INT PRIMARY KEY,
 sale_date DATE,
 sale_time TIME,
 customer_id INT,
 gender VARCHAR(15),
 age INT,
 category VARCHAR(15),
 quantity INT,
 price_per_unit FLOAT,
 cogs FLOAT,
 total_sale FLOAT
);

-- SELECT customer_id from retail_sales
-- limit 10
SELECT * from retail_sales

-- CHECKING NULL VALUES >
SELECT * FROM retail_sales 
WHERE 
	transactions_id IS NULL 
	OR 
	sale_date IS NULL 
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR 
	age IS NULL
	OR 
	category IS NULL
	OR 
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR 
	cogs IS NULL 
	OR 
	total_sale IS NULL

-- DELETING THE DATA WHERE THE VALUES ARE NULL >>
DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL 
	OR 
	sale_date IS NULL 
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR 
	age IS NULL
	OR 
	category IS NULL
	OR 
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR 
	cogs IS NULL 
	OR 
	total_sale IS NULL


-- total no of transactions >>
SELECT COUNT(*) AS total_transactions
FROM retail_sales

-- number of unique customers >>
SELECT COUNT (DISTINCT customer_id) AS unique_customers FROM retail_sales

-- find available category >
SELECT DISTINCT category FROM retail_sales

-- gender distributions >>
SELECT gender, COUNT(*) as total_transactions
FROM retail_sales
GROUP BY gender

--sales made on 2022-11-05
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05'

--find all transactions where---
SELECT * FROM retail_sales
WHERE category='Clothing'
AND 
quantity > 3
AND 
TO_CHAR(sale_date,'YYYY-MM')='2022-11'

-- TOTAL SALES FOR EACH CATEGORY >

SELECT category,SUM(total_sale) as TOTAL_SALE
FROM retail_sales
GROUP BY category 

-- Find the average age of customers who purchased from the Beauty category

SELECT AVG(age) from retail_sales
WHERE category='Beauty'

--  Get all transactions where the total sale is greater than 1000

SELECT * from retail_sales
WHERE total_sale >1000

-- Show the number of transactions made by each gender in each category
SELECT category, COUNT(*) AS no_of_transactions FROM retail_sales
GROUP BY category 

-- For each month in each year, calculate the average sale
SELECT TO_CHAR(sale_date,'YYYY-MM') as year_month ,
AVG(total_sale) as avg_sales from retail_sales
GROUP BY TO_CHAR(sale_date,'YYYY-MM')
ORDER BY year_month
-- OR WE CAN DO THIS LIKE >>

SELECT 
 year,month,avg_sale 
 FROM
 (
SELECT 

EXTRACT(YEAR FROM sale_date) as year,
EXTRACT(MONTH FROM sale_date)as month,
AVG(total_sale) as avg_sale,
RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as rank
FROM retail_sales
GROUP BY year,month
) as t1
WHERE rank=1


-- Find the top 5 customers with the highest total spending

SELECT 
customer_id, 
SUM(total_sale) AS total_spending
from retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC 
LIMIT 5

-- Show the number of unique customers who purchased from each category

SELECT 
  category,
  COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

-- Create shifts based on sale_time:-- Morning: before 12 PM-- Afternoon: between 12 PM and 5 PM-- Evening: after 5 PM-- Then count number of orders in each shift

SELECT 
  CASE
  	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
	WHEN EXTRACT(HOUR FROM sale_time) >= 12 AND EXTRACT(HOUR FROM sale_time) < 17 THEN 'Afternoon'
	ELSE 'EVENING'
  END as shift,
   COUNT(*) AS orders
 FROM retail_sales
 GROUP BY shift

 -- end
	
	
	







