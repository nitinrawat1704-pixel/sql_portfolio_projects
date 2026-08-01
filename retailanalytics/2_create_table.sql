CREATE TABLE bank_transactions
(
transaction_id INT PRIMARY KEY AUTO_INCREMENT,

transaction_date DATE,

customer_id INT,

customer_name VARCHAR(50),

gender VARCHAR(10),

age INT,

city VARCHAR(40),

state VARCHAR(40),

branch_name VARCHAR(50),

account_number VARCHAR(20),

account_type VARCHAR(20),

customer_segment VARCHAR(20),

transaction_type VARCHAR(20),

payment_channel VARCHAR(30),

transaction_amount DECIMAL(12,2),

balance_after_transaction DECIMAL(12,2),

loan_status VARCHAR(20),

credit_score INT,

occupation VARCHAR(40)
);