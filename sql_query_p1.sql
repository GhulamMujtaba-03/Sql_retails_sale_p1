-- SQL Retail Sales Analysis-P1
-- create database sql_project_p2;


-- create table
Create table retails_sale ( 
					transactions_id int,
					sale_date Date,
					sale_time time,
					customer_id INT,
					gender varchar(15),
					age INT,
					category varchar(15),
					quantiy INT,
					price_per_unit float,
					cogs float,	
					total_sale float
);



-- DATA CLEANING 
select * from retails_sale 
where 
	transactions_id is null
    OR 
    sale_date is null
    OR
    sale_time is null
    OR 
    customer_id is null
    OR 
    gender is null
    OR
    age is null
    OR
    Category is null
    or
    quantiy is null 
    or 
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;
  
Delete from retails_sale
where 
	transactions_id is null
    OR 
    sale_date is null
    OR
    sale_time is null
    OR 
    customer_id is null
    OR 
    gender is null
    OR
    age is null
    OR
    Category is null
    or
    quantiy is null 
    or 
    price_per_unit is null
    or
    cogs is null
    or 
    total_sale is null;


-- DATA EXPLORATION

-- HOW MANY SALES We HAVE
SELECT count(*) as total_sale from retails_sale;

-- HOW MANY UNIQUE COUSTOMER WE HAVE
SELECT count(distinct customer_id) from retails_sale;

-- HOW MANY CATEGORY WE HAVE 
SELECT distinct CATEGORY FROM RETAILS_SALE ;

-- DATA ANALYSIS & BUSSNIESS KEY PROBLEM & ANSWERS
SELECT * FROM RETAILS_SALE 
WHERE SALE_DATE="2022-11-05";



-- Q:3 Calculate the totol_sale (total_sale) for each category
SELECT  category,sum(total_sale) as net_sale,
count(*) as total_order
from RETAILS_SALE 
group by 1;


-- Q4 Write a SQL query to find  the average age 
-- of customers who purchased items from the "Beauty", Category
select ROUND(avg(age),2) as avg_age
from retails_sale where category ="Beauty";


-- Q5 Write a sql query to find  all transctions where the total_sale is greater than 1000
select * from retails_sale where transactions_id>1000;


-- Q6 Write a sql query to find  the total number of
-- transactions (transaction_id) made by each gender in each category
Select category,gender,count(transactions_id) as total_trans_id from
 retails_sale
 group by
 gender ,category
 order by 1;

-- Q7 write a sql query to calculate the avergae sale
-- for each month.find out best sellong month in each year
SELECT year, month
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank_no
    FROM retails_sale
    GROUP BY year, month
) AS t1
WHERE rank_no = 1;

-- Q8 Write a query to find  the 
-- top 6 ccustomers based on the hghest total_sale

Select customer_id,sum(total_sale) as total_sales
from retails_sale group by 1 order by 2 DESC LIMIt 5;

-- Q9 Write a sql query to find the
-- number of unique customer who purchased items from each category.

Select 
	category,
	count(distinct customer_id) as count_uni_cust
    from retails_sale 
    group by category;


-- Q10 Write s sql query to create each 
-- shift and number of oders 
-- -- (EXample Morning<=12,Afternoon Between 12 & 17 , evening>17)
WITH HOURLY_SALE
AS
(
Select * ,
	CASE 
	WHEN EXTRACT(HOUR FROM SALE_TIME) <=12 THEN "MORNING"
    WHEN EXTRACT(HOUR FROM SALE_TIME) between 12 AND 17 THEN "AFTERNOON"
    ELSE "EVENGING"
END AS SHIFT
FROM RETAILS_SALE)

select 
SHIFT ,
COUNT(*) AS TOTAL_ORDERS from HOURLY_SALE GROUP BY SHIFT;

-- ENDS OF PROJECT



