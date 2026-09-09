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

select officer_name,sum() from loan_officer o inner join loan_application a on o.officer_id=a.officer_id
select * from
(
select officer_name,sum(loan_amount) total,dense_rank()over(order by sum(loan_amount) desc) as rnk from 
loan_application a inner join loan_officer o
on a.officer_id=o.officer_id
group by 1
)as t where rnk=1
