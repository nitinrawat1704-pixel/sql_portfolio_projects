Q1.Display all employee records.
  select * from employee;
Q2.Find employees working in the IT department.
  select * from employee where department ="IT";
Q3.List employees earning more than ₹80,000.
  select full_name,sal,department from employee where sal>80000;
Q4.Find the highest-paid employee.
  select full_name,sal,department from employee where sal = (select max(sal) from employee);
Q5.Calculate the average salary for each department.
  select department,round(avg(sal)) from employee group by 1 order by 2 desc;
Q6.Count the number of employees in each department.
  select department,COUNT(ID) AS "NO OF EMP" from employee group by 1 order by 2 desc;
Q7.Find employees who joined after January 1, 2025
  SELECT full_name,DOJ from employee where DOJ>'2025-01-1' order by 2 asc;
Q8.Display employees in descending order of salary.
(Show the top 5 highest-paid employees)
  SELECT full_name,SAL from employee  order by 2 DESC limit 5;
Q9.Find employees whose first name starts with the letter 'A'.
(Display their full names, email addresses, and departments.)
  SELECT full_name,email,department from employee where full_name like "A%";

Q10.Generate a department salary report.

  SELECT 
    department,
    count(id) as "No of emp",
    min(sal) as"Minimum Sal",
    max(sal) as"Maximum Sal",
    round(avg(sal)) as"Average Sal",
    sum(sal)  as"Total Sal Department wise" 
  from employee 
  group by 1 
  order by 2 desc ;


Q11.Combine all employee names into one column for each department.
  select department,group_concat(full_name) from employee group by 1;

Q12.HR wants to know how long each employee has been with the company.
  select full_name,DOJ,timestampdiff(year ,DOJ,curdate()) as "Year", mod(timestampdiff(month ,DOJ,curdate()),12) as "month" from employee order by 3 desc;

