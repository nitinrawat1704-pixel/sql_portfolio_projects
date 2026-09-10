-- Q1. How many Mortgage application are there?

select count(application_id) from loan_application;

-- Q2. Total loan amount requested

select sum(loan_amount) from loan_application;

-- Q3. Average Loan Amount

select avg(loan_amount) from loan_application;

-- Q4. Application  by Status

select application_status,count(*) from loan_application group by 1;

-- Q5. Application by Loan Type

select loan_type,count(*) from loan_application group by 1;

-- Q6. Total loan amount by application status

select application_status,sum(loan_amount) from loan_application group by 1;

-- Q7. Average loan amount by loan type

select loan_type,avg(loan_amount) from loan_application group by 1;

-- Q8. Number of applications handled by each loan officer

select officer_name,count(application_id) from loan_application a inner join loan_officer o on a.officer_id=o.officer_id group by 1 order by 2 desc;

-- Q9. Total loan amount handled by each loan officer

select officer_name,sum(loan_amount) from loan_application a inner join loan_officer o on a.officer_id=o.officer_id group by 1 order by 2 desc;

-- Q10. Applications where loan amount > 5,000,000

select * from loan_application where loan_amount>5000000;

-- Q11. Average credit score of all customers

select avg(credit_score) from customers;

-- Q12. Number of customers by employment status

select employment_status,count(*) from customers group by 1;

-- Q13. Average annual income by employment status

select employment_status,avg(annual_income) from customers group by 1;

-- Q14. Number of applications by state

select state,count(application_id) from customers c inner join loan_application a on c.customer_id=a.customer_id group by 1;

-- Q15. Total property value by loan type

select loan_type,sum(property_value) from loan_application group by 1 order by 2 desc;

-- Q16. Find the number of Approved applications.

select count(*) from loan_application where application_status = "Approved";

-- Q17. Find the total loan amount for Approved applications.

select sum(loan_amount) from loan_application where application_status = "Approved";

-- Q18. Find the average credit score of customers who have applications.

select avg(credit_score) from (select distinct c.customer_id,credit_score from customers c inner join loan_application a on c.customer_id=a.customer_id) as t;

-- Q19. Find the number of applications with a loan amount greater than 5,000,000.

select count(application_id) from loan_application where loan_amount>5000000;

-- Q20. Find the total loan amount by loan type, highest first.

select loan_type,sum(loan_amount) from loan_application group by 1 order by 2 desc;

-- Q21. Find loan applications where loan amount is greater than 80% of property value.

select *,concat(round((loan_amount/property_value)*100,2),"%") as LTV from loan_application where (loan_amount/property_value)*100>80;

-- Q22. Show each application with:

select application_id,loan_amount,property_value,concat(round((loan_amount/property_value)*100,2),"%") from loan_application;

-- Q23. Find the average LTV by loan type.

select loan_type,concat(round(avg((loan_amount/property_value)*100),2),"%") from loan_application group by 1;

-- Q24. Find customers whose DTI is greater than 40%.

with cte as
( 
select customer_name,(annual_income/12) as mi,monthly_debt d from loan_application a left join customers c on a.customer_id=c.customer_id
)
select customer_name,mi,d,d/mi*100 as DTI from cte having d/mi*100>40;

-- Q25. Find the average DTI by employment status.

with cte as(
select employment_status,customer_name,(annual_income/12) as mi,monthly_debt d from loan_application a inner join customers c on a.customer_id=c.customer_id)
select employment_status,avg(d/mi*100) as average_DTI from cte group by 1;

-- Q26. Find the approval rate as a percentage of total applications.

select concat(((select count(*) from loan_application where application_status="Approved")/count(*))*100,"%") as "Approval rate percentage" from loan_application ;

-- Q27. Find the rejection rate as a percentage of total applications.

select concat(((select count(*) from loan_application where application_status="Rejected")/count(*))*100,"%") as "Rejection rate percentage" from loan_application ;


-- Q28. Find the approval rate by loan type.

select loan_type,(count(*)/(select count(*) from loan_application))*100from loan_application where application_status="Approved" group by 1;

-- Q29. Find the average loan amount for Approved applications.

select application_status,round(avg(loan_amount),2) as average_loan_amount from loan_application where application_status="Approved";

-- Q30. Find the maximum loan amount for each loan type.

select loan_type,max(loan_amount) from loan_application group by 1 ;

-- Q31. Find loan applications where the LTV is between 70% and 80%. 

select *,round((loan_amount/property_value)*100,2) as LTV from loan_application  where (loan_amount/property_value)*100  between 70 and 80;

-- Q32. Categorize applications based on LTV:

select *,(loan_amount/property_value)*100 as LTV,
case 
when (loan_amount/property_value)*100 < 70 then "LOW"
when (loan_amount/property_value)*100 between 70 and 80 then "MEDIUM"
else "HIGH"
end
as LTI_grade from loan_application ; 

-- Q33. Categorize customers based on credit score:

select customer_name,credit_score,
case when credit_score<700 then "low"
when credit_score between 700 and 749 then "good"
when credit_score between 750 and 799 then "very good"
else "Excellent"
end as Customer_Grade
from customers;

-- Q34. Find the average loan amount by application status, but show only statuses where the average loan amount is greater than 4,000,000.

select application_status,avg(loan_amount) from loan_application  group by 1 having avg(loan_amount)>4000000;

-- Q35. Find the loan officer with the highest total loan amount handled.-- 

select * from
(
select officer_name,sum(loan_amount) total,dense_rank()over(order by sum(loan_amount) desc) as rnk from 
loan_application a inner join loan_officer o
on a.officer_id=o.officer_id
group by 1
)as t where rnk=1

-- Q36 Find the average loan amount for each loan type, but return only loan types whose average loan amount is greater than ₹40 lakh.-- 

select loan_type,avg(loan_amount) from loan_application group by 1 having avg(loan_amount)>4000000;

with cte as (select loan_type,avg(loan_amount) a from loan_application group by 1 )
select loan_type,a from cte where a>4000000;

-- Q37 Find all customers whose credit score is higher than the overall average credit score.

select customer_name from customers where credit_score>(select avg(credit_score) from customers);


-- Q38 Find the top 5 customers by total loan amount applied.

select customer_name,Total_loan_amount from(
select customer_name,sum(loan_amount) as "Total_loan_amount",dense_rank()over(order by sum(loan_amount) desc) as rnk from loan_application a inner join customers c on a.customer_id=c.customer_id group by 1) as t where rnk <6 order by 2 desc;

with cte as 
(
select customer_name,sum(loan_amount) as "Total_loan_amount",dense_rank()over(order by sum(loan_amount) desc) as rnk from loan_application a inner join customers c on a.customer_id=c.customer_id group by 1
)
select customer_name,Total_loan_amount from cte where rnk<6 order by rnk asc;


-- Q39 For each customer, assign a row number to their loan applications based on application_date, with the latest application = 1.

select customer_id,application_id,application_date,row_number()over(partition by customer_id order by application_date desc) as "row_number" 
from loan_application;

--  Q40 find the latest application of every customer.

with cte as(
select customer_id,application_id,application_date,application_status,row_number()over(partition by customer_id order by application_date desc) as "rw_number" 
from loan_application)
select customer_id,application_id,application_date,application_status from cte where rw_number=1;

-- Q41 For each loan officer, show their applications along with the previous application's loan amount.

select officer_id,application_id,application_date,application_status,loan_amount,
lag(loan_amount)over(partition by officer_id order by application_date asc) as "Previous application loan amount"
 from loan_application;
 
 -- Q42 Find the number of loan applications submitted each month.
 
 select DATE_FORMAT(application_date,'%Y-%m'),count(application_id) from loan_application group by 1 order by 2 desc;
 
 -- Q43 Find the monthly application count and the previous month's application count.
 
  select DATE_FORMAT(application_date,'%Y-%m'),count(application_id),LAG(COUNT(*)) OVER(ORDER BY DATE_FORMAT(application_date,'%Y-%m')) as previous_month
  from loan_application group by 1 ;

-- Q44 — Approval Rate by Month

with cte as 
(
select date_format(application_date,"%Y-%M") m,
count(application_id) t_a,
sum(case when application_status="Approved" then 1
else 0 end) as a_a
from loan_application group by 1
)
select m as application_month,t_a as total_applications,a_a as approved_applications,concat(((a_a/t_a)*100),"%") as approval_rate from cte;

-- Q45 — MoM Approval Rate Change

with cte as 
(
select date_format(application_date,"%y-%m") m,
count(application_id) t_a,
sum(case when application_status="Approved" then 1
else 0 end) as a_a
from loan_application group by 1
)
select m as application_month,
t_a as total_applications,
a_a as approved_applications,
concat(round(((a_a/t_a)*100),2),"%") as approval_rate,
lag(concat(round((a_a/t_a)*100,2),'%'))over( order by m ) as previous_month_approval_rate
from cte;

-- Q46 Calculate monthly applications and the percentage growth compared with the previous month.

with cte as
(
select date_format(application_date,"%Y-%m") as d,count(*) as cm,lag(count(*))over(order by  date_format(application_date,"%Y-%m")) as pm
from loan_application group by 1
)
select d as month,cm as application_count,pm as previous_month_count,(((cm-pm)/pm)*100) as growth_percentage from cte;

-- Q47 Find the total loan amount handled by each officer for each month.

select officer_name,date_format(application_date,"%Y-%M"),sum(loan_amount)
from loan_officer o inner join loan_application a on o.officer_id=a.officer_id group by 1,2;

-- Q48 identify the top-performing loan officer for each month based on total loan amount.

select * from(select officer_name,date_format(application_date,"%y-%m") d,sum(loan_amount),
dense_rank()over(partition by date_format(application_date,"%y-%m") order by sum(loan_amount) desc) as rnk
from loan_officer o inner join loan_application a on o.officer_id=a.officer_id group by 1,2) as t where rnk=1 order by d asc;


-- Q49 Which officer had the highest loan amount in each month, and how many months did each officer lead?

with cte as(
select * from(
select officer_name,date_format(application_date,"%y-%b") d,sum(loan_amount) as s ,
dense_rank()over(partition by date_format(application_date,"%y-%b") order by sum(loan_amount) desc) as rnk
from loan_officer o inner join loan_application a on o.officer_id=a.officer_id group by 2,1)as t where rnk=1
)select officer_name,count(*) months_as_top_officer,sum(s)total_leading_month_amount,group_concat(d) months_led from cte group by 1 order by 3 desc;

-- Q50 Calculate the running total of loan amount over time.

with cte as 
(
    SELECT DATE_FORMAT(application_date,'%Y-%m') AS mnth,
           SUM(loan_amount) AS monthly_loan_amount
    FROM loan_application
    GROUP BY 1
)
select mnth,monthly_loan_amount,sum(monthly_loan_amount)over(order by mnth) as running_total from cte;

-- Q51 Find customers who have submitted more than one loan application

select c.customer_id,customer_name,count(application_id) as application_count
from customers c inner join loan_application a on c.customer_id=a.customer_id 
group by 1,2 HAVING COUNT(*)>1;

-- Q52 For every customer who has multiple applications, calculate the number of days between their first and latest application.

with cte as(
select customer_name,min(application_date) as first_application,max(application_date) as last_application
from customers c inner join loan_application a on c.customer_id=a.customer_id 
group by 1
HAVING COUNT(application_id)>1
)
select customer_name,first_application,last_application,DATEDIFF(last_application , first_application) as days_between from cte;

-- Q53 For funded applications only, calculate the processing time:

select application_id,application_date,funding_date,datediff(funding_date,application_date) as processing_days 
from loan_application where funding_date is not null ;

-- Q54 Calculate the average processing time for each loan officer, using only applications that have been funded.

select officer_name,round(avg(datediff(funding_date,application_date))) as average_processing_days 
from loan_application a inner join loan_officer o on a.officer_id=o.officer_id
where funding_date is not null 
group by 1
order by 1

