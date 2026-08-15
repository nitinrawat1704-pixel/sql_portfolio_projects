/*Department-wise salary ranking*/
select full_name,department,sal,rank()over (partition by department order by sal desc)  as "rank" from employee;
/*Overall salary ranking*/
select full_name,sal,dense_rank()over(order by sal desc) as dn from employee;
/*Assign a row number to employees by salary*/
select full_name,department,sal,row_number()over(order by sal desc) as rn from employee;
/*Department-wise employee sequence*/
select *,row_number() over(partition by department order by DOJ asc) from employee;
/*Compare employee salary with department average*/
select full_name,department,sal,round(avg(sal)over(partition by department)) as "avg of dept" from employee;
/*Find the highest-paid employee in each department*/
select * from
(
select full_name,department,sal,max(sal)over(partition by department order by sal desc) as highest_sal,dense_rank()over(partition by department order by sal desc) as rn from employee
)as t having rn =1;
/*Top 2 highest-paid employees from each department*/
select * from
(
select full_name,department,sal,dense_rank()over(partition by department order by sal desc) as rn from employee
)as t having rn <3;
/*Compare salary with the previous employee*/
select full_name,sal,lag(sal)over(order by sal desc) as "previous sal" ,lag(sal)over(order by sal desc)-sal as "diff in sal" from employee;
/*Compare salary with the next employee*/
select full_name,sal,lead(sal)over(order by sal desc) as "next sal",sal-lead(sal)over(order by sal desc) as "diff in sal" from employee;
/*Running total of salaries*/
select full_name,DOJ,sal,sum(sal) over(order by doj) as "running total of sal" from employee;
/* Branch Performance Ranking*/
select department,sum(sal),rank() over(order by sum(sal) desc) from employee group by 1 order by 2 desc;


/*Identify salary outliers within each department*/
select full_name,department,sal,average,diff from 
  (
  select full_name,
    department,
    sal,avg(sal)over(partition by department ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as average,
  sal-avg(sal)over(partition by department ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as "diff"
  from employee 
  order by 5 asc)as t 
where diff>0 
order by 5 desc;

/* Find employees whose salary is greater than the previous employee*/

select full_name,department,sal,lag(sal)over(order by sal desc) as "previous sal",
 case
when lag(sal)over(order by sal desc) is null then "First emp"
when (sal > lag(sal)over(order by sal desc) ) > 0 then "Higher"
when (lag(sal)over(order by sal desc)  = sal) Then "Same"
else "Low" 
end as sal_status from employee 
