------------Basic Reporting-----------------------------------------------------------------------------------------------------------------------------------------------------------

Display all customers.
	select customer_name from bank_transactions;
Display all transactions.
	select * from bank_transactions;
Show deposits only.
	select * from bank_transactions where transaction_type ="deposit";
Show withdrawals only.
	select * from bank_transactions where transaction_type ="withdrawal";
Find transactions above ₹50,000.
	select * from bank_transactions where transaction_amount >50000;
List customers from Delhi.
	select * from bank_transactions where city ="Delhi";
Display Savings accounts.
	select * from bank_transactions where account_type="savings";
Display Current accounts.
	select * from bank_transactions where account_type="current";
Find female customers.
	select * from bank_transactions where gender="female";
Find customers older than 60.
	select * from bank_transactions where age>60;
Show all UPI transactions.
	select * from bank_transactions where payment_channel="upi";
Show ATM transactions.
	select * from bank_transactions where payment_channel="atm";
Show Cheque transactions.
	select * from bank_transactions where payment_channel="cheque";
Show Net Banking transactions.
	select * from bank_transactions where payment_channel="net banking";
Display transactions in January.
	select * from bank_transactions where monthname(transaction_date)="January";
Sort by transaction amount.
	select * from bank_transactions order by transaction_amount desc;
Display unique cities.
	select distinct city from bank_transactions;
Display unique branches.
	select distinct branch_name from bank_transactions;
Count total customers.
	select count(customer_id) from bank_transactions;
Count total transactions.
	select count(transaction_id) from bank_transactions;
	
	
------------Buisness KPI-------------------------------------------------------------------------------------------------------------------------------------------------------------	

Total bank business.
	select sum(transaction_amount) as "Total Bank Business" from bank_transactions;

Total deposits.
	select sum(transaction_amount) from bank_transactions where transaction_type="deposit";
	
Total withdrawals.
	select sum(transaction_amount) from bank_transactions where transaction_type="withdrawal";

Average transaction.
	select avg(transaction_amount) from bank_transactions;
	
Highest transaction.
	select max(transaction_amount) from bank_transactions;
	
Lowest transaction.
	select min(transaction_amount) from bank_transactions;
	
Branch-wise business.
	name,sum(transaction_amount) from bank_transactions group by 1 order by 2 desc;
	
City-wise business.
	select city,sum(transaction_amount) from bank_transactions group by 1 order by 2 desc;
	
State-wise business.
	select state,sum(transaction_amount) from bank_transactions group by 1 order by 2 desc;
	
Account type-wise business.
	select account_type,sum(transaction_amount) from bank_transactions group by 1 order by 2 desc;
	
Customer segment-wise business.
	select customer_segment,sum(transaction_amount) from bank_transactions group by 1 order by 2 desc;

Gender-wise business.
	select gender,sum(transaction_amount) from bank_transactions group by 1 order by 2 desc;

Occupation-wise business.
	select occupation,sum(transaction_amount) from bank_transactions group by 1 order by 2 desc;

Average balance.
	select avg(balance_after_transaction) as "Average Balance" from bank_transactions;
	
Average credit score.
	select avg(credit_score) as "Average Balance" from bank_transactions;

Maximum balance.
	select max(balance_after_transaction) as "Average Balance" from bank_transactions;

Minimum balance.
	select min(balance_after_transaction) as "Average Balance" from bank_transactions;

Monthly business.
	select monthname(transaction_date) as "Month wise",sum(transaction_amount) as "Amount" from bank_transactions group by 1;

Quarterly business.
	select quarter(transaction_date) as "quarterly",sum(transaction_amount) as "Amount" from bank_transactions group by 1;

Yearly business.	
		select year(transaction_date) as "yearly",sum(transaction_amount) as "Amount" from bank_transactions group by 1;


------------– Customer Analytics------------------------------------------------------------------------------------------------------------------------------------------------------
Top 10 customers by business.&&&&&&&&&&&&&&&&&&&&&&&&
	select customer_name,sum(transaction_amount) as "total buisness" from bank_transactions group by 1 order by 2 desc limit 10;
	
Customers with more than five transactions.
	select customer_name,count(*) as "total transaction" from bank_transactions group by 1 having count(*) > 5 ;
	
Customers having business above ₹5,00,000.
	select customer_name,sum(transaction_amount) as "total transaction" from bank_transactions group by 1 having sum(transaction_amount) > 500000 ;
	
Customers with low credit score.
	select customer_name,credit_score from bank_transactions order by credit_score asc;

Customers with high credit score.
	select customer_name,credit_score from bank_transactions order by credit_score desc;

Senior citizen customers.
	select customer_name,age from bank_transactions order by 2 desc;
	
Young customers.
	select customer_name,age from bank_transactions order by 2 asc;
	
Premium customers.
	select * from bank_transactions where customer_segment="Premium";
	
Salary account customers.
	select * from bank_transactions where caccount_typet="salary";
	
Business account customers.
	select * from bank_transactions where caccount_typet="business";
	
Average customer age.
	select round(avg(age),2) from bank_transactions;
	
Age-group analysis.
	
select case 
when age>30 then 'young'
when age between 30 and 40 then 'Adult'
else 'old'
end ,count(*),round(sum(transaction_amount))
from bank_transactions group by 1
;

City-wise customer count.
	select city,count(customer_name) as "total no customers" from bank_transactions group by 1 ;
	
State-wise customer count.
	select state,count(customer_name) as "total no customers" from bank_transactions group by 1 ;
	
Customer segment distribution.
	select customer_segment,count(customer_name) as "total no customers" from bank_transactions group by 1 ;
	
Occupation distribution.
	select occupation,count(customer_name) as "total no customers" from bank_transactions group by 1 ;
	
Customers using only UPI.
	select customer_name,payment_channel from bank_transactions where payment_channel="UPI";
	
Customers using only ATM.
	select customer_name,payment_channel from bank_transactions where payment_channel="ATM";
	
Customers using Net Banking.
	select customer_name,payment_channel from bank_transactions where payment_channel="net banking";
	
Customers with highest balance.
	select customer_name,balance_after_transaction as "Highest Balance holder" from bank_transactions order by balance_after_transaction desc limit 1;


---------------------Branch Performance-------------------------------------------------------------------------------------------------------------------------------------------
Highest-performing branch.&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	
	select branch_name,sum(transaction_amount) from bank_transactions group by 1 having sum(transaction_amount)=
	(
	select max(amount) from
	(
	select sum(transaction_amount) as "amount" from bank_transactions group by branch_name)as t
	);
	
Lowest-performing branch.&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	
	select branch_name,sum(transaction_amount) from bank_transactions group by 1 having sum(transaction_amount)=
	(
	select min(amount) from
	(
	select sum(transaction_amount) as "amount" from bank_transactions group by branch_name)as t
	);
	
Branch with maximum deposits.
		
	#single highest transaction#
	select branch_name,transaction_amount as "Highest Deposit" from bank_transactions where transaction_amount =
	(select max(transaction_amount) from bank_transactions where transaction_type="Deposit");

		#branch with maximum total deposit# 
	
select branch_name,sum(transaction_amount) as "Highest Deposit" from bank_transactions group by 1 having sum(transaction_amount)=
	(select max(ta) from 
	(
    select branch_name,sum(transaction_amount) as "ta" from bank_transactions where transaction_type="Deposit" group by 1) as t
    )
    ;
	
Branch with maximum withdrawals.
	
	select branch_name,transaction_amount as "Highest withdrawal" from bank_transactions where transaction_amount =
	(select max(transaction_amount) from bank_transactions where transaction_type="withdrawal");

Average transaction by branch.
	select branch_name,round(avg(transaction_amount),2) from bank_transactions group by 1 order by 2;

Total customers by branch.
	select branch_name,count(customer_id) as "No of customers" from bank_transactions group by 1 order by 2;


Branch-wise average balance.
	select branch_name,round(avg(balance_after_transaction),2) from bank_transactions group by 1 order by 2;


Branch-wise credit score.
	select branch_name,round(avg(credit_score),2) as "avg credit score" from bank_transactions group by 1 order by 2;


Branch-wise premium customers.
	select branch_name,count(customer_id) from bank_transactions where customer_segment ="premium" group by 1 order by 2;


&&**Branch-wise business growth.**&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

select 
	branch_name,
	month,monthly_business,
	lag(monthly_business) over (partition by branch_name order by month_number)as "previous_month_buisness",
concat(round((
	((monthly_business-lag(monthly_business) over (partition by branch_name order by month_number))
	/(lag(monthly_business)over(partition by branch_name order by month_number)))*100),2),'%') 
    as "growth in percentage"
from
(SELECT
    branch_name,
    monthname(transaction_date) AS "Month",
    month(transaction_date) AS "month_number",
    SUM(transaction_amount) AS "Monthly_Business"
FROM bank_transactions
GROUP BY 1,2,3
ORDER BY 1)as t;

Branch-wise cash transactions.
	select branch_name,sum(transaction_amount) from bank_transactions where payment_channel ="Cash" group by 1 order by 2;


Branch-wise digital transactions.
	select branch_name,sum(transaction_amount) from bank_transactions where payment_channel != "Cheque" group by 1 order by 2;


Branch-wise customer segment analysis.
	use bank;
select branch_name ,customer_segment,count(distinct customer_id) as total_customer from bank_transactions group by 1,2 order by 1 ;

Branch-wise gender ratio.
		SELECT
			branch_name,
			gender,
			COUNT(DISTINCT customer_id) AS customers,
			ROUND(
			COUNT(DISTINCT customer_id) * 100 /
			SUM(COUNT(DISTINCT customer_id)) OVER(PARTITION BY branch_name),
			2
			) AS gender_percentage
		FROM bank_transactions
		GROUP BY
			branch_name,
			gender
		ORDER BY
			branch_name;
		

Branch-wise occupation analysis.
	
	select branch_name,occupation,count(customer_id) as no_of_person 
	from bank_transactions
	group by 1,2
	order by 1,3;
	


----------------------------------Fraud & Risk Analytics-----------------------------------------------------------------------------------
Transactions above ₹2,00,000.
	select * from bank_transactions where transaction_amount > 200000;

Cash deposits above ₹2,00,000.
	select * from bank_transactions where transaction_amount > 200000 and payment_channel ="cash" and transaction_type="deposit";
	
Cash withdrawals above ₹2,00,000.
	select * from bank_transactions where transaction_amount > 200000 and payment_channel ="cash" and transaction_type="withdrawal";

**$$Customers with multiple high-value transactions.$$**
	
	select customer_name,count(*) from bank_transactions where transaction_amount >
	(
	select avg(transaction_amount) from bank_transactions

	)
	group by 1 having count(*) >1;
	
Customers with low balance.
	select distinct customer_name from bank_transactions where balance_after_transaction <
	(
	select avg(balance_after_transaction) from bank_transactions

	);
	
Customers with credit score below 600.
	select customer_name from bank_transactions where credit_score < 600;
	
Transactions during weekends.
	select customer_name from bank_transactions where weekday(transaction_date) in ( "5","6");
	select customer_name,transaction_date,dayname(transaction_date) as day from bank_transactions where weekday(transaction_date) in ( "5","6");

Large withdrawals.
	select * from bank_transactions where transaction_type ="withdrawal" and transaction_amount 
	>
	(select avg(transaction_amount) from bank_transactions where transaction_type ="withdrawal");

Large deposits.
	select * from bank_transactions where transaction_type ="deposit" and transaction_amount 
	>
	(select avg(transaction_amount) from bank_transactions where transaction_type ="deposit");

**$$Suspicious repeated transactions.$$**
	select customer_name,transaction_date,transaction_amount,payment_channel,count(*) from bank_transactions group by 1,2,3,4 having count(*)>1;

Customers making many ATM withdrawals.
	select customer_name,count(*) from bank_transactions where transaction_type="withdrawal" and payment_channel ="atm" group by 1 having count(*) > 1;

Customers making many UPI payments.
	select customer_name,count(*) from bank_transactions where payment_channel ="upi" group by 1 having count(*) > 1;
	
**$$Branches with high-risk customers.$$**
		select branch_name,count(*) from bank_transactions 
		where
			transaction_type!="deposit" and
			loan_status ="active" and
			credit_score < 
					(select avg(credit_score) from bank_transactions)
		group by 1 having count(*) > 1;
	
	
Customers with loan default status.
	select *from bank_transactions where loan_status ="default";


**$$High-risk customer report.**$$
		select customer_name,account_type,loan_status,transaction_type,credit_score from bank_transactions 
		where
			transaction_type!="deposit" and
			loan_status ="active" and
			credit_score < 
					(select avg(credit_score) from bank_transactions)
		;
	
