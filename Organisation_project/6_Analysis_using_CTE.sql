Q1.Salary comparison with department average
  with t as 
(
select 
full_name,
department,
sal,avg(sal) over(partition by department) as daverage,
sal-avg(sal) over(partition by department) as "diff" 
from employee
)
(select full_name,department,sal,daverage,diff,
case 
when diff>0 then "Higher"
when diff<0 then "Lower"
else "Same"
end as "status"
from t)

Q2.Management wants to know how much each employee contributes to their department's total salary.


WITH T AS
(
select 
full_name,
department,
sal,
sum(sal)over(partition by department) as "department_total_salary"
from employee
)
select *,
concat(round((sal/department_total_salary)*100,2),"%") as"employee's salary as a percentage of department salary"
from t;
