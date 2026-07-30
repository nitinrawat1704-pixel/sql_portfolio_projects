1.	Display all records.
2.	Show customer name, city and product purchased.
3.	Find all customers from Delhi.
4.	Display all Electronics products.
5.	Find sales greater than ₹30,000.
6.	Show customers aged above 30 years.
7.	Sort records by highest sale amount.
8.	Display the first 5 records.
9.	Find customers whose names start with 'R'.
10.	Display all unique cities.
11.	Calculate total sales revenue.
12.	Calculate average sales amount.
13.	Find the maximum sale amount.
14.	Find the minimum sale amount.
15.	Count total orders.
16.	Display city-wise total sales.
17.	Display category-wise revenue.
18.	Display salesperson-wise revenue.
19.	Count orders by payment mode.
20.	Find customers who have placed more than one order.
21.	Find the city with the highest sales.
22.	Find the category generating the highest revenue.
23.	Display monthly sales revenue.
24.	Find the top 5 highest sales transactions.
25.	Display product-wise quantity sold.
26.	Calculate average sales by city.
27.	Show gross amount before discount for every order.
28.	List customers who paid using UPI.
29.	Find the most popular payment mode.
30.	Display all Furniture products costing more than ₹20,000.
31.	Find customers between ages 25 and 35.
32.	Count male and female customers.
33.	Display state-wise revenue.
34.	Find the salesperson with the maximum revenue.
35.	Create a business KPI report showing:








1.	Select * from store_sales;
2.	select customer_name,city,product_name from store_sales;
3.	select * from store_sales where city ="Delhi";
4.	select * from store_sales where category ="Electronics";
5.	select * from store_sales where total_amount>30000;
6.	select * from store_sales where age > 30;
7.	select * from store_sales order by total_amount desc;
8.	select * from store_sales order by order_date asc limit 5;
9.	select * from store_sales where customer_name like "r%";
10.	select distinct city from store_sales;
11.	select sum(total_amount) from store_sales;
12.	select avg(total_amount) from store_sales;
13.	select max(total_amount) from store_sales;
14.	select min(total_amount) from store_sales;
15.	select count(total_amount) from store_sales;
16.	select city,sum(total_amount) from store_sales group by 1;
17.	select category,sum(total_amount) from store_sales group by 1;
18.	select salesperson,sum(total_amount) from store_sales group by 1;
19.	select payment_mode,count(*) from store_sales group by 1;
20.	select customer_name,count(*) from store_sales group by 1 having count(*) >1;
21.	select city, from store_sales where total_amount=(select max(total_amount) from store_sales);
22.	select category,sum(total_amount) from store_sales group by category order by 2 desc limit 1;
23.	select monthname(order_date),sum(total_amount) from store_sales group by 1;

24.	select* from store_sales order by total_amount desc limit 5;
 	select * from (select *,row_number() over(order by total_amount desc ) as rn from store_sales 	) as t where rn <6;

25.	select product_name,sum(quantity) from store_sales  group by 1;

26.	select city,avg(total_amount) from store_sales group by 1;

27.	select *,quantity*unit_price as "amount before discount" from store_sales;
	select sum(quantity*unit_price) as "amount before discount" from store_sales;

28.	select customer_name from store_sales where payment_mode = "UPI";
29.	select payment_mode,count(*) from store_sales group by payment_mode order by 2 desc limit 1;
30.	select * from store_sales where category = "furniture" and unit_price > 20000;
31.	select customer_name from store_sales where age between 25 and 35;
32.	select gender,count(*) from store_sales group by 1;
33.	select state,sum(total_amount) from store_sales group by 1;


34.	select salesperson,sum(total_amount) from store_sales group by 1 order by 2 desc limit 1;
	select salesperson,sum(total_amount) as revenue from store_sales group by 1 having 	sum(total_amount) = (select max(revenue) from (select salesperson,sum(total_amount) as 	revenue from store_sales group by 1) as t);

35.	select count(*) as Total_orders,sum(total_amount) as Toatl_Revenue,avg(total_amount) as Average,max(total_amount) as Highest_Sale from store_sales;

