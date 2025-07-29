---CREATING DATABASE---
create table Retail_sales ( 
						transactions_id	INT PRIMARY KEY,
						sale_date	DATE,
						sale_time	TIME,
						customer_id	INT,
						gender		VARCHAR(15),
						age		    INT,
						category	VARCHAR(15),
						quantity	INT,
						price_per_unit  FLOAT,
						cogs		FLOAT,
						total_sale	FLOAT			
						);

SELECT * FROM RETAIL_SALES limit 10;

select count(*) from RETAIL_SALES;

Select * from Retail_sales 
where transactions_id IS NOT Null;

Select * from Retail_sales 
where transactions_id IS  Null;

---Data Cleaning----

Select * from Retail_sales 
where 
	transactions_id IS  Null
	or
	sale_date  IS  Null
	or
	sale_time IS  Null
	or
	customer_id IS  Null
	or
	gender	IS  Null
	or
	age		IS  Null
	or
	category	IS  Null
	or
	quantity	IS  Null
	or
	price_per_unit IS  Null
	or
	cogs		IS  Null
	or
	total_sale	IS  Null;

Delete from retail_sales
where 
	transactions_id IS  Null
	or
	sale_date  IS  Null
	or
	sale_time IS  Null
	or
	customer_id IS  Null
	or
	gender	IS  Null
	or
	age		IS  Null
	or
	category	IS  Null
	or
	quantity	IS  Null
	or
	price_per_unit IS  Null
	or
	cogs		IS  Null
	or
	total_sale	IS  Null;


---Data Exploration---


---Total Number of sales ----

Select count(*) as total_sales from retail_sales;

---How many no. of unique customers we have ----

Select count(Distinct customer_id) as total_sales from retail_sales;

---How many unique categories we have in the data set----

Select Distinct category as total_sales from retail_sales;


-----Data Analysis and business problems with answer----


--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales where  sale_date ='2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022


select * from retail_sales 
where 
category = 'Clothing'
and 
to_char(sale_date,'YYYY-MM')='2022-11'
and 
quantity >=4;

/*select * from retail_sales 
where 
category = 'Clothing'
and
DATE_format(sale_date,'%Y-%M')='2022-11'
and 
quantity >=4;*/

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select  category, sum(total_sale) as net_sales, count(*)
as total_orders
from 
retail_sales 
group by category;

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) as avg_age_customers
from
  retail_sales 
where 
   category ='Beauty';

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from 
	retail_sales 
where 
	total_sale >1000;

--Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.

select  gender, category,count(*) as total_trans
from 
    retail_sales 
group by 
     gender , category order by category, total_trans desc;


--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

with cte as (
		select 
		extract(Year from sale_date) as year,
		extract(Month from sale_date) as Month,
		Avg(total_sale) as avg_sales,
		Rank() over(partition by extract(Year from sale_date) order by Avg(total_sale) desc) as rn
		from
			retail_sales
		group by year,Month
)

select year, month,avg_sales from cte where rn =1 order by year,avg_sales desc;

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select  customer_id , sum(total_sale) as total_sales
from 
   retail_sales 
group by customer_id
order by 
    total_sales desc
limit 5;

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select  Category, count(Distinct customer_id)
from 
   retail_sales 
group by 
   category;
--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_table as(
	select *,
	CASE
	When extract(Hour from sale_time) <12 then 'Morning'
	When extract(Hour from sale_time) between 12 and 17 then 'Afternoon'
	else 'evening'
	end as shift_times
	from retail_sales
	)

select shift_times, count(*) as total_orders 
from
	hourly_table 
group by 
	shift_times;
