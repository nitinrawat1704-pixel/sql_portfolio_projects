Total Customers
   select count(distinct customer_id) as "Total customers" from bank_transactions; 


Total Transactions

	select count(distinct transaction_id) as "Total No of Transactions" from bank_transactions;

Total Business
	select sum(transaction_amount) as "Total Business" from bank_transactions;

Total Deposits
	select sum(transaction_amount) as "Total Deposits" from bank_transactions
	where transaction_type="Deposit";

Total Withdrawals
	select sum(transaction_amount) as "Total withdrawal" from bank_transactions
	where transaction_type="withdrawal";

Average Transaction
	select avg(transaction_amount) as "Average Transaction" from bank_transactions;
	
Average Balance
	select round(avg(balance_after_transaction),2) as "Average Balance" from bank_transactions;
	
Highest Transaction
	select max(balance_after_transaction) as "Highest Transaction" from bank_transactions;
