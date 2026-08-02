
Business Analytics 


Which category is most popular?

	select item_name,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1 having sum(quantity) =
	(
	select max(c) from
	(select item_name,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1)as t
	); 

Which city places the most orders?

	select city,count(order_id)as c from items i inner join orders o on i.item_id=o.item_id group by 1 having count(*) =
	(
	select max(c) from
	(select city,count(order_id)as c from items i inner join orders o on i.item_id=o.item_id group by 1)as t
	);
	
Which suppliers products sell the most?
	
 select supplier_name,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1 having sum(quantity) =
	(
	select max(c) from
	(select supplier_name,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1)as t
	);

Which payment mode is most used?

	select payment_mode,count(order_id)as c from items i inner join orders o on i.item_id=o.item_id group by 1 having count(*) =
	(
	select max(c) from
	(select payment_mode,count(order_id)as c from items i inner join orders o on i.item_id=o.item_id group by 1)as t
	);
	
Which product has never been ordered?

	select item_name,count(order_id)as c from items i left join orders o on i.item_id=o.item_id group by 1 having count(order_id) =0;

Which products have low stock (less than 20)?

	select item_name,stock_quantity from items where stock_quantity < 20;

Which customers bought Electronics?

	select customer_name from  items i inner join orders o on i.item_id=o.item_id where category ='Electronics';

Which customers bought Furniture?

select customer_name from  items i inner join orders o on i.item_id=o.item_id where category ='Furniture';

Which brand generated the highest sales quantity?
		
	select brand,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1 having sum(quantity) =
	(
	select max(c) from
	(select brand,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1)as t
	);
	
Which product has the highest stock?

	select item_name from items where stock_quantity =(select max(stock_quantity) from items);

Which product has the lowest stock?

	select item_name from items where stock_quantity =(select min(stock_quantity) from items);

Which city purchased the highest quantity?

	select city,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1 having sum(quantity) =
	(
	select max(c) from
	(select city,sum(quantity)as c from items i inner join orders o on i.item_id=o.item_id group by 1)as t
	); 
