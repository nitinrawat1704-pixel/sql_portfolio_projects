CREATE TABLE store_sales
(
sale_id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE,
customer_name VARCHAR(50),
gender VARCHAR(10),
age INT,
city VARCHAR(40),
state VARCHAR(40),
product_name VARCHAR(60),
category VARCHAR(40),
quantity INT,
unit_price DECIMAL(10,2),
discount DECIMAL(10,2),
total_amount DECIMAL(10,2),
payment_mode VARCHAR(20),
salesperson VARCHAR(50)
);
