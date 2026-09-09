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
