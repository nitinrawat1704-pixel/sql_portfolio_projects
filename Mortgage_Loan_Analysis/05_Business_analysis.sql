-- Q1. Application  by Status

select application_status,count(*) from loan_application group by 1;

-- Q2. Application by Loan Type

select loan_type,count(*) from loan_application group by 1;

-- Q3 — Approval Rate by Month

with cte as 
(
select date_format(application_date,"%Y-%M") m,
count(application_id) t_a,
sum(case when application_status="Approved" then 1
else 0 end) as a_a
from loan_application group by 1
)
select m as application_month,t_a as total_applications,a_a as approved_applications, ((a_a/t_a)*100) as approval_rate from cte;

-- Q4 Calculate monthly applications and the percentage growth compared with the previous month.

with cte as
(
select date_format(application_date,"%Y-%m") as d,count(*) as cm,lag(count(*))over(order by  date_format(application_date,"%Y-%m")) as pm
from loan_application group by 1
)
select d as month,cm as application_count,pm as previous_month_count,(((cm-pm)/pm)*100) as growth_percentage from cte;

-- Q5 Calculate the approval rate for each credit-score band:

with cte as (select case 
when credit_score<700 then "Low"
when credit_score between 700 and 749 then"Good"
when credit_score between 750 and 799 then"Very Good"
else "Excellent" end as credit_band,
count(application_id) as total_application,
sum(case when application_status="Approved" then 1
else 0 end) as total_approved_application
from customers c inner join loan_application a on c.customer_id=a.customer_id group by 1)
select credit_band,
total_application,
total_approved_application,
round((total_approved_application/total_application)*100) as approval_rate from cte;

-- Q6 High-Risk Applications

with cte as(
select
customer_name,
application_id,
credit_score,
round((loan_amount/property_value)*100) as LTV ,
round((monthly_debt/(annual_income/12))*100) as DTI,application_status
from loan_application a inner join customers c on a.customer_id=c.customer_id)
select customer_name,application_id,credit_score,LTV,DTI,application_status FROM CTE Where LTV >80 or DTI>40 OR credit_score < 700;

-- Q7 — Officer Quality vs Volume
select 
officer_name,
count(*) total_applications,
sum(case when application_status="Approved" then 1 else 0 end) as total_approved_application,
(sum(case when application_status="Approved" then 1 else 0 end)/count(*))*100 as approval_rate,
sum(case when application_status="Approved" then loan_amount else 0 end) as approved_loan_amount
from loan_application a inner join loan_officer o on a.officer_id=o.officer_id
group by 1
order by 4 desc;

-- Q8 - Region Performance

select 
region,
count(application_id) total_application,
sum(case when application_status="Approved" then 1 else 0 end) as total_approved_application,
(sum(case when application_status="Approved" then 1 else 0 end)/count(*))*100 as approval_rate,
sum(case when application_status="Approved" then loan_amount else 0 end) as approved_loan_amount
from loan_application a inner join loan_officer o on a.officer_id=o.officer_id
group by 1
order by 4 desc;

-- Q9 — Funding Conversion
select 
sum(case when application_status="Approved" then 1 else 0 end) as total_approved_application,
sum(case when funding_date is not null and application_status="Approved" then 1 else 0 end) as funded_application,
(sum(case when funding_date is not null and application_status="Approved" then 1 else 0 end)/sum(case when application_status="Approved" then 1 else 0 end))*100 as funding_conversion_rate
from loan_application;


-- Q10 — Processing Time by Loan Type

with cte as(
select 
loan_type,
sum(case when application_status="Approved" and funding_date is not null then 1 end) as funded_application,
avg(datediff(funding_date,application_date)) as average_processing_days 
from loan_application WHERE funding_date IS NOT NULL group by 1 order by 3 )
select loan_type,funded_application,average_processing_days,dense_rank()over(order by average_processing_days asc) from cte;

-- Q11 Monthly Funding Performance

with cte as
(
select date_format(funding_date,"%Y-%m") d,
count(*) as funded_application,
sum(loan_amount) tla,
avg(loan_amount) ala,
lag(sum(loan_amount)) over(order by date_format(funding_date,"%Y-%m") ) as pmtla
from loan_application
where funding_date is not null
group by 1)
select d as month,
funded_application,
tla as total_funded_loan_amount,
ala as average_funded_loan_amount,
pmtla as previous_month_funded_amount,
round(((tla-pmtla)/pmtla)*100) as mom_growth_percentage from cte;



-- Q12 Create a risk category for every application.

with cte as 
(
select 
c.customer_id,
credit_score,
application_id,
application_status,
loan_amount,
round((loan_amount/property_value)*100) as LTV ,
round(((monthly_debt/(annual_income/12))*100)) as DTI
from loan_application a inner join customers c on a.customer_id=c.customer_id
)
select 
case when LTV > 80 OR DTI > 40 OR credit_score < 700 then "High Risk"
when LTV between 70 and 80 and DTI between 30 and 40 and credit_score between 700 and 749 then "Medium Risk"
else "Low risk" end as risk_category,
count(application_id) as application,
sum(case when application_status="Approved" then 1 end) as approved_applications,
((sum(case when application_status="Approved" then 1 end))/count(application_id))*100  as approval_rate,
round(avg(loan_amount),2) as average_loan_amount
from cte group by 1;
