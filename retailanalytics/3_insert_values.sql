INSERT INTO items
(item_name,category,brand,purchase_price,selling_price,stock_quantity,supplier_name)

VALUES

('Laptop','Electronics','HP',45000,52000,40,'ABC Traders'),

('Mobile','Electronics','Samsung',18000,22000,80,'XYZ Electronics'),

('Refrigerator','Electronics','LG',28000,34000,25,'Cool Appliances'),

('Office Chair','Furniture','Nilkamal',2200,3500,100,'Furniture World'),

('Dining Table','Furniture','Godrej',12000,17000,30,'Furniture World'),

('Rice 10kg','Grocery','India Gate',700,900,250,'Fresh Foods'),

('Cooking Oil','Grocery','Fortune',120,170,300,'Fresh Foods'),

('T-Shirt','Clothing','Levis',500,900,150,'Fashion Hub');


INSERT INTO orders
(order_date,customer_name,city,payment_mode,quantity,item_id)

VALUES

('2026-01-02','Rahul','Delhi','UPI',2,2),

('2026-01-03','Priya','Noida','Cash',1,1),

('2026-01-05','Amit','Delhi','Card',3,6),

('2026-01-07','Neha','Mumbai','UPI',1,3),

('2026-01-09','Rohit','Pune','Card',2,4),

('2026-01-10','Pooja','Delhi','Cash',5,7),

('2026-01-12','Ankit','Jaipur','UPI',2,8),

('2026-01-14','Komal','Delhi','Card',1,5),

('2026-01-16','Mohit','Noida','UPI',2,2),

('2026-01-18','Nisha','Lucknow','Cash',1,1);
