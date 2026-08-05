Q1.Display all employee records.
  select * from employee;
Q2.Find employees working in the IT department.
  select * from employee where department ="IT";
Q3.List employees earning more than ₹80,000.
  select full_name,sal,department from employee where sal>80000;
Q4.Find the highest-paid employee.
  select full_name,sal,department from employee where sal = (select max(sal) from employee);

