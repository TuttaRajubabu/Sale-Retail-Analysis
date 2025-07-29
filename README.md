#  Sales Retail Analysis SQL Project

## Project Overview

**Project Title**: Sales Retail Analysis  
**Level**: Beginner  
**Database**: `Sql_project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Sql_project_1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE Sql_project_1;

create table Retail_sales
                    ( 
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql

Select * from Retail_sales 
where 
	transactions_id IS  Null
	or
	sale_date      IS  Null
	or
	sale_time      IS  Null
	or
	customer_id    IS  Null
	or
	gender	       IS  Null
	or
	age		       IS  Null
	or
	category	   IS  Null
	or
	quantity	   IS  Null
	or
	price_per_unit IS  Null
	or
	cogs		   IS  Null
	or
	total_sale	   IS  Null;

Delete from retail_sales
where 
	transactions_id  IS  Null
	or
	sale_date        IS  Null
	or
	sale_time        IS  Null
	or
	customer_id      IS  Null
	or
	gender	         IS  Null
	or
	age		         IS  Null
	or
	category	     IS  Null
	or
	quantity	     IS  Null
	or
	price_per_unit   IS  Null
	or
	cogs		     IS  Null
	or
	total_sale	     IS  Null;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * 
from 
	retail_sales 
where  
	sale_date ='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * 
from 
	retail_sales 
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
quantity >=4;*/---In Mysql

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select  category, sum(total_sale) as net_sales, count(*)
as total_orders
from 
    retail_sales 
group by
    category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select round(avg(age),2) as avg_age_customers
from
  retail_sales 
where 
   category ='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select *
from 
	retail_sales 
where 
	total_sale >1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select  gender, category,count(*) as total_trans
from 
    retail_sales 
group by 
     gender , category 
order by
	category, total_trans desc;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
with rank_table as
            (
        		select 
        		extract(Year from sale_date) as year,
        		extract(Month from sale_date) as Month,
        		Avg(total_sale) as avg_sales,
        		Rank() over(partition by extract(Year from sale_date) order by Avg(total_sale) desc) as rn
        		from
        			retail_sales
        		group by year,Month
            )

select year, month,avg_sales from rank_table where rn =1 order by year,avg_sales desc;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select  customer_id , sum(total_sale) as total_sales
from 
   retail_sales 
group by 
	customer_id
order by 
    total_sales desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select  Category, count(Distinct customer_id)
from 
   retail_sales 
group by 
   category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with hourly_table as
                (
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Rajubabu Tutta

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

Thank you for your support, and I look forward to connecting with you!
