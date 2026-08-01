Display customer name, item name and quantity.
	
	SELECT o.customer_name,
	i.item_name,
	o.quantity
	FROM orders o
	INNER JOIN items i
	ON o.item_id=i.item_id;

Display category and customer name.
	
	SELECT o.customer_name,
	i.category
	FROM orders o
	INNER JOIN items i
	ON o.item_id=i.item_id;
	select * from items;
	
Display brand and quantity sold.	
	
	SELECT 
	i.brand,
	o.quantity,
	FROM orders o
	INNER JOIN items i
	ON o.item_id=i.item_id;
	
Display selling price with customer.
	
SELECT 
	i.selling_price,
	o.customer_name
	FROM orders o
	INNER JOIN items i
	ON o.item_id=i.item_id;	
	
Display supplier name with customer.	

	SELECT 
		i.supplier_name,
		o.customer_name
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id;
	
Product-wise quantity sold.

	SELECT 
		i.category,
		count(o.quantity)
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id
	group by 1 order by 2 desc;    


Category-wise sales quantity.

	SELECT 
		i.category,
		round(sum(selling_price),2)
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id
	group by 1 order by 2 desc; 

Brand-wise quantity sold.
	
	SELECT 
		i.brand,
		count(o.quantity)
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id
	group by 1 order by 2 desc;

Supplier-wise sales.

	SELECT 
		i.supplier_name,
		round(sum(selling_price),2)
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id
	group by 1 order by 2 desc; 
	
City-wise orders.
	
	SELECT 
		o.city,
		count(order_id)
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id
	group by 1 order by 2 desc;

Payment mode analysis.

	SELECT 
		o.payment_mode,
	count(o.order_id)
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id
	group by 1 order by 2 desc; 


Number of orders per product.

	SELECT 
		i.brand,
		count(o.order_id)
	FROM orders o
		INNER JOIN items i
		ON o.item_id=i.item_id
	group by 1 order by 2 desc; 

Category-wise products.
	select category,count(item_name) from items group by 1 order by 2 desc;  
	
Brand-wise products.

	select brand,count(item_name) from items group by 1 order by 2 desc;   

Supplier-wise products.
	
	select supplier_name,count(category) from items group by 1 order by 2 desc;  