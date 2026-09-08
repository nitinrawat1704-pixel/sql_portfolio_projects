create table customers
(
customer_id int primary key,
customer_name varchar(50) not null,
age int,
state varchar(30),
annual_income decimal(12,2),
employment_status varchar(30),
credit_score int not null,
first_time_buyer varchar(20)
);


create table loan_officer
(
officer_id int primary key, 
officer_name varchar(20),
region varchar(20)
);


create table loan_application
(
application_id int primary key,
customer_id int not null,
officer_id int not null,
application_date date,
loan_type varchar(30),
loan_amount decimal(12,2),
property_value decimal(12,2),
monthly_debt decimal(12,2),
application_status varchar(20),
funding_date  date,
foreign key(customer_id) references customers(customer_id),
foreign key(officer_id) references loan_officer(officer_id)
);
