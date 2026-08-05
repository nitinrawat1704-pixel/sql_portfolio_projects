create table employee
(
id int auto_increment primary key,
first_name varchar(24) not null,
last_name  varchar(24) not null,
full_name  varchar(50)  generated always as (concat(concat(upper(left(first_name,1)),lower(right(first_name,length(first_name)-1))),concat(upper(left(last_name,1)),lower(right(last_name,length(last_name)-1))))) stored unique,
sal int,
DOJ date,
company_pn varchar(24)default  '1005264587',
phone varchar(24) check(length(phone)=10) default '1005264587',
email varchar(100) generated always as (concat(lower(full_name),'@gmail.com')) stored, 
department varchar(24) default ('Temp') check (department in('Admin','Sales','Finance','IT','Temp','VP')) 
);


alter table employee modify department varchar(24) default("temp") check(department in("Admin","Sales","CEO","VP","IT","Temp","Finance"));
ALTER TABLE employee
DROP CHECK employee_chk_2;
ALTER TABLE employee
ADD CONSTRAINT employee_chk_2
CHECK (department IN ('Admin', 'Sales', 'Finance', 'IT', 'Temp', 'VP', 'CEO'));
