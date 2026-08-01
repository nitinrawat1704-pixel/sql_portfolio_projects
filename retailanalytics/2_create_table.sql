CREATE TABLE items
(
item_id INT PRIMARY KEY AUTO_INCREMENT,

item_name VARCHAR(100),

category VARCHAR(50),

brand VARCHAR(50),

purchase_price DECIMAL(10,2),

selling_price DECIMAL(10,2),

stock_quantity INT,

supplier_name VARCHAR(100)
);


CREATE TABLE orders
(
order_id INT PRIMARY KEY AUTO_INCREMENT,

order_date DATE,

customer_name VARCHAR(100),

city VARCHAR(50),

payment_mode VARCHAR(30),

quantity INT,

item_id INT,

FOREIGN KEY(item_id)
REFERENCES items(item_id)
)
