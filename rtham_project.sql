/* Project.sql 
   REN-HUI MICHELLE THAM
   CS 31A, Winter 2024
*/

/* Purpose: Create and use the Bank database */
DROP SCHEMA IF EXISTS bank;
CREATE SCHEMA bank;
USE bank;

/* Query 1
Purpose: Create the Customers table */
CREATE TABLE customers (
  customer_ID INT(4),
  first_name VARCHAR(15) NOT NULL,
  last_name VARCHAR(15) NOT NULL,
  email VARCHAR(45),
  phone CHAR(12),
  PRIMARY KEY (customer_ID)
);

/* Query 2
Purpose: Create the Accounts table */
CREATE TABLE accounts (
  account_ID INT(4),
  customer_ID INT(4),
  account_type VARCHAR(45) NOT NULL,
  balance DECIMAL(10, 2) NOT NULL,
  open_date DATE NOT NULL,
  PRIMARY KEY (account_ID),
  FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID)
);

/* Query 3
Purpose: Create the Transactions table */
CREATE TABLE transactions (
  transaction_ID INT(4),
  account_ID INT(4),
  transaction_type VARCHAR(45) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  transaction_date DATE NOT NULL,
  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (account_ID) REFERENCES accounts(account_ID)
);

/* Query 4
Purpose: Create the Cards table */
CREATE TABLE cards (
  card_ID INT(5),
  customer_ID INT(4),
  card_type VARCHAR(45) NOT NULL,
  expiry_date DATE NOT NULL,
  is_activated BOOLEAN NOT NULL,
  PRIMARY KEY (card_ID),
  FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID)
);

/* Query 5
Purpose: Create the Branches table */
CREATE TABLE branches (
  branch_ID INT(4),
  branch_name VARCHAR(45) NOT NULL,
  location VARCHAR(45) NOT NULL,
  manager_name VARCHAR(45),
  phone CHAR(12),
  PRIMARY KEY (branch_ID)
);

/* Query 6
Purpose: Create the Loans table */
CREATE TABLE loans (
  loan_ID INT(5),
  customer_ID INT(4),
  loan_type VARCHAR(45) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  approval_date DATE NOT NULL,
  PRIMARY KEY (loan_ID),
  FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID)
);

/* Query 7
Purpose: Create the Payments table */
CREATE TABLE payments (
  payment_ID INT(4),
  loan_ID INT(4),
  amount_paid DECIMAL(10, 2) NOT NULL,
  payment_date DATE NOT NULL,
  PRIMARY KEY (payment_ID),
  FOREIGN KEY (loan_ID) REFERENCES loans(loan_ID)
);

/* Query 8
Purpose: Create the Employees table */
CREATE TABLE employees (
  employee_ID INT(4),
  first_name VARCHAR(15) NOT NULL,
  last_name VARCHAR(15) NOT NULL,
  position VARCHAR(45),
  salary DECIMAL(10, 2),
  PRIMARY KEY (employee_ID)
);

/* Query 9
Purpose: Create the Deposits table */
CREATE TABLE deposits (
  deposit_ID INT(4),
  customer_ID INT(4),
  amount DECIMAL(10, 2) NOT NULL,
  deposit_date DATE NOT NULL,
  PRIMARY KEY (deposit_ID),
  FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID)
);

/* Query 10
Purpose: Create the Transfers table */
CREATE TABLE transfers (
  transfer_ID INT(4),
  source_account_ID INT(4) NOT NULL,
  destination_account_ID INT(4) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  transfer_date DATE NOT NULL,
  PRIMARY KEY (transfer_ID),
  FOREIGN KEY (source_account_ID) REFERENCES accounts(account_ID),
  FOREIGN KEY (destination_account_ID) REFERENCES accounts(account_ID)
);