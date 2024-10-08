-- SQL RETAIL SALES ANALYSIS
create database zero;
-- create table
create table retail_sales (
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender	varchar(15),
age int,
category varchar(20),
quantity int,
price_per_unit float,
cogs float,
total_sale float
);
-- viewing data after imorting from excel file
select * from retail_sales;

-- total number of rows
select count(*) from retail_sales;

-- finding null values using the following syntax
select * from retail_sales where column_name is null;

-- deleting null columns using the following syntax
delete from reatail_sales where column_name is null;

-- data exploration
-- total number of sales
select count(*) as total_sale from retail_sales;

-- total number of  distinct customers
select count(distinct customer_id) as total_customers from retail_sales;

-- types of categories
select distinct category as total_categories from retail_sales;

-- data analysis and business insights based on business tasks.
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date = '2022-11-05'; 

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >=4
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';
  
  -- 3 Write a SQL query to calculate the total sales (total_sale) for each category.
  select category,
  sum(total_sale) as net_sale,
  count(*) as total_orders
  from retail_sales group by 1;
  
  -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
  select round((age),2) as avg_age 
  from retail_sales
  where category = 'Beauty';
  
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale > '1000'; 

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,
count(*) as total_transactions
 from retail_sales group by category,gender
 order by 1;
 
 -- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
 select year,month,avg_sale from
 (
 select 
 extract(year from sale_date) as year,
 extract(month from sale_date) as month ,
 round(avg(total_sale),2) as avg_sale,
 rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as pos
 from retail_sales
 group by year ,month
 ) as t1 
 where pos = 1
 order by 1,3 desc;
 
 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 select customer_id ,
 sum(total_sale) as total_sale
 from retail_sales 
 group by 1
 order by 2 desc
 limit 5;
 
 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 select 
 category,
 count(distinct customer_id) as unq_customers
 from retail_sales
 group by category;
 
 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
 with hourly_sale
 as
 (
 select *,
 case
   when extract(hour from sale_time) <= 12 then 'morning'
   when extract(hour from sale_time) between 12 and 17 then 'afternoon'
   when extract(hour from sale_time) > 17 then 'evening'
 end as shift
from retail_sales
)
select shift,
 count(*) as total_orders
from hourly_sale
group by shift

-- end of project.
 










