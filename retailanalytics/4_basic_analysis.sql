Display all items.
	select * from items;

Display all orders.
	select * from orders;

Show Electronics products.
	select item_name from items where category ='Electronics';

Display orders from Delhi.
	select * from orders where city ='Delhi';

Show products with stock greater than 100.
	select * from items where stock_quantity > 100;

Display orders paid using UPI.
	select * from orders where payment_mode ='upi';

Display products costing more than ₹20,000.
	select item_name from items where selling_price>20000;

Display unique cities.
	select distinct city from orders;

Sort items by selling price.
	select * from items order by selling_price desc;

Display top 5 expensive products.
	select item_name from items order by selling_price desc limit 5;









