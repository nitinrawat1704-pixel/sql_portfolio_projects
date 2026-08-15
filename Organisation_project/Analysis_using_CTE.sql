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
