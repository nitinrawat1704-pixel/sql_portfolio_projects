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
