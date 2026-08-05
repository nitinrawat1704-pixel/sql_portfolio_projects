Display all employee records.
  select * from employee;
Find employees working in the IT department.
  select * from employee where department ="IT";
List employees earning more than ₹80,000.
  select full_name,sal,department from employee where sal>80000;
Find the highest-paid employee.
  select full_name,sal,department from employee where sal = (select max(sal) from employee);

