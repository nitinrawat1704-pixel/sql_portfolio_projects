-- =====================================================
-- Retail Store Sales Analysis
-- Business KPI Report
-- =====================================================
-- 📊 Overall Business KPIs
  select 
	    sum(total_amount) as "Total Revenue",count(sale_id) as "Total Orders",count(distinct customer_name) as "Total Customers" from store_sales;

-- 🏙️ City-wise Sales Performance
    select city,sum(total_amount) as "City-wise Sales" from store_sales group by 1;
   
-- 📦 Category-wise Revenue
  select category,sum(total_amount) as "Category-wise Revenue" from store_sales group by 1;

-- 💳 Payment Mode Analysis
  select payment_mode,count(*) as "Payment Mode Analysis" from store_sales group by 1 order by 2 desc;

-- 👨‍💼 Salesperson Performance  
  select salesperson,sum(total_amount) as "Salesperson Performance" from store_sales group by 1 order by 2 desc;

-- 📅 Monthly Sales Trend
  select monthname(order_date),count(*) as "Monthly Sales Trend",sum(total_amount) as "Monthly Sale" from store_sales group by 1 order by 2 desc;

-- 💰 Average Order Value
  select avg(total_amount) as "Average Order Value" from store_sales;

-- 🏆 Best-Selling Productt
  select product_name,count(*) as "Best-Selling Product" from store_sales group by 1 having count(*) >1 limit 1;

---Rank customers based on their total transaction amount. 
select customer_name,sum(total_amount) ,rank() over(order by sum(total_amount) desc)from store_sales group by 1;

-----------------------------------------------------------------------------weekly growth city wise---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select city,week,weekly_sales,lag(weekly_sales) over (partition by city order by week) as "previous week sales",
(weekly_sales - lag(weekly_sales) over (partition by city order by week) ) as "current - previous ",
(weekly_sales - lag(weekly_sales) over (partition by city order by week))/lag(weekly_sales) over (partition by city order by week) as"current-previous/previous",
(weekly_sales - lag(weekly_sales) over (partition by city order by week))/lag(weekly_sales) over (partition by city order by week) * 100 as "(current-previous/previous)*100",
round((weekly_sales - lag(weekly_sales) over (partition by city order by week))/lag(weekly_sales) over (partition by city order by week),2) * 100 as "rounding of (current-previous/previous)*100",
concat(round((weekly_sales - lag(weekly_sales) over (partition by city order by week))/lag(weekly_sales) over (partition by city order by week),2) * 100,"%") as "concat(rounding of (current-previous/previous)*100)%",
concat(round((weekly_sales - lag(weekly_sales) over (partition by city order by week))/lag(weekly_sales) over (partition by city order by week),2) * 100,"%") as "Growth in %"
from(
select city,week(order_date) as "week" ,sum(total_amount) as weekly_sales from store_sales group by 1,2 )as t;


