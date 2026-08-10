----------Best Branch
	
	select 
		branch_name,
		sum(transaction_amount)
	from 
		bank_transactions 
	group by 1   
	having sum(transaction_amount) =(
								select max(all_s) from
								(select branch_name,sum(transaction_amount) as all_s from bank_transactions group by 1) as t 
                                );
----------Best Customer

	select 
		customer_name,
		balance_after_transaction,
		credit_score
	from 
		bank_transactions 
	where
		transaction_type = 'Deposit' and
        balance_after_transaction =(select max(balance_after_transaction) from bank_transactions where transaction_type = 'Deposit') and
        credit_score > (select avg(credit_score) from bank_transactions )
        ;
		
---------------/*compare transaction during weekends vs weekdays*/--------------------------------------


SELECT
    CASE
        WHEN WEEKDAY(transaction_date) IN (5,6)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS transaction_day_type,
    COUNT(*) AS total_transactions,
    SUM(transaction_amount) AS total_amount
FROM bank_transactions
GROUP BY 
  1;


---------------/*compare transaction during weekends vs weekdays for offline and online*/---------------------------------



SELECT
    CASE
        WHEN WEEKDAY(transaction_date) IN (5,6)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS transaction_day_type,
	Case
			when payment_channel = ("Cheque")
            then 'offline'
            else 'online'
    end as payment_channel,        
    COUNT(*) AS total_transactions,
    SUM(transaction_amount) AS total_amount
FROM bank_transactions
GROUP BY 
  1,2;

---------------------------------Quarter-over-Quarter Business-----------------------------------------------------------------------------------------------
select quarter(transaction_date)"recent qtr",sum(transaction_amount),lag(sum(transaction_amount))over(order by sum(transaction_amount) desc) as "previous qtr" 
	from bank_transactions group by 1 ;
---------------------------------- Top 3 Customers From Each Branch-------------------------------------------------------------------------------------------
select * from
(select branch_name,customer_name,sum(balance_after_transaction),rank()over(partition by branch_name order by sum(balance_after_transaction) desc) as rnk from bank_transactions group by 1,2) as t where rnk <4;
