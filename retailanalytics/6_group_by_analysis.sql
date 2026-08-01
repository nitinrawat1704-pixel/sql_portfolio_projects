Most sold product.

SELECT 
	i.item_name,
	count(*)
FROM orders o
	INNER JOIN items i
	ON o.item_id=i.item_id
group by 1 
having count(*) >1; 


Least sold product.

	i.item_name,
	count(*)
FROM orders o
	INNER JOIN items i
	ON o.item_id=i.item_id
group by 1 
having count(*) <1; 

/*highest selling price product.*/////////////////////////////////////////////

select item_name from items where selling_price = (select max(selling_price) from items);

/*lowest selling price product.*///////////////////////////////////////////////

select item_name from items where selling_price = (select min(selling_price) from items);

/*Average selling price product.*///////////////////////////////////////////////

select round(avg(selling_price),2) from items;

Total stock available.*///////////////////////////////////////////////

select sum(stock_quantity) from items;
select category,sum(stock_quantity) from items group by 1 desc 1;

Total quantity sold.*///////////////////////////////////////////////

select sum(quantity) from orders;

Total number of products.*///////////////////////////////////////////////

select count(distinct item_name) from items;

Total number of orders.*///////////////////////////////////////////////

select count(distinct order_id) from orders;

Average order quantity.*///////////////////////////////////////////////

select avg(quantity) from orders;