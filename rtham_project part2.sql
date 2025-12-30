/* Project Part2.sql 
   REN-HUI MICHELLE THAM
   CS 31A, Winter 2024
*/

/* Purpose: Use the Bank database */
USE bank;

/* Query 1
Purpose: Display all customer information.
Rows Returned: 12 */
SELECT *
FROM customers;

/* Query 2
Purpose: Find the total balance in all accounts. 
Rows Returned: 1 */
SELECT SUM(balance) AS 'Total Balance'
FROM accounts;

/* Query 3
Purpose: List all transactions for the account with ID # 202. Display the transaction ID, account ID, 
transaction type, amount, and transaction date.
Rows Returned: 1 */
SELECT transaction_ID, account_ID, transaction_type, amount, transaction_date
FROM transactions
WHERE account_ID = 202;

/* Query 4
Purpose: Show the average balance of all accounts.
Rows Returned: 1 */
SELECT AVG(balance) AS 'Average Balance'
FROM accounts;

/* Query 5
Purpose: Retrieve the card details for the customer whose ID is 777. 
Rows Returned: 1 */
SELECT *
FROM cards
WHERE customer_ID = 777;

/* Query 6
Purpose: List all active loans.
Rows Returned: 10 */
SELECT loan_ID, 
       customer_ID, 
       loan_type, 
       amount, 
       approval_date
FROM loans l
WHERE customer_ID IN (
      SELECT customer_ID
      FROM cards 
      WHERE is_activated = TRUE);

/* Query 7
Purpose: Calculate the total number of transactions for each account. Display the account ID 
and number of transactions.
Rows Returned: 10 */
SELECT account_ID, COUNT(transaction_ID) AS 'Total Number of Transactions'
FROM transactions
GROUP BY account_ID;

/* Query 8
Purpose: Retrieve the names of employees earning more than $50,000. Display the first name 
and last name.
Rows Returned: 6 */
SELECT first_name, last_name
FROM employees
WHERE salary > 50000;

/* Query 9
Purpose: Retrieve the latest deposit for each customer. Display the deposit ID, customer ID, 
amount, deposit date, first name, and last name.
Rows Returned: 10 */
SELECT deposit_ID, 
       d.customer_ID, 
       amount, 
       deposit_date, 
       first_name, 
       last_name
FROM deposits d
JOIN customers c ON (d.customer_ID = c.customer_ID)
WHERE deposit_date IN (SELECT MAX(deposit_date)
					   FROM deposits
                       GROUP BY customer_ID);

/* Query 10
Purpose: List all customers who have a credit card.
Rows Returned: 4 */
SELECT customer_ID, 
       first_name, 
       last_name, 
       email, 
       phone
FROM customers
WHERE customer_ID IN (SELECT customer_ID
				      FROM cards
                      WHERE card_type = 'Credit' AND is_activated = TRUE);

/* Query 11
Purpose: Find the average annual salary of all employees.
Rows Returned:  */
SELECT AVG(salary) AS 'Avg Annual Salary of All Employees'
FROM employees;

/* Query 12
Purpose: Retrieve the top 3 accounts with the highest balance.
Rows Returned:  */
SELECT account_ID, 
       customer_ID, 
       account_type, 
       balance, 
       open_date
FROM accounts
ORDER BY balance DESC
LIMIT 3;

/* Query 13
Purpose: List all loans with payments due in the next 30 days.
Rows Returned: 0 */
SELECT l.loan_ID, 
	   customer_ID, 
       loan_type, 
       amount, 
       approval_date, 
       payment_date
FROM loans l
JOIN payments p ON (p.loan_ID = l.loan_ID)
WHERE DATEDIFF(p.payment_date, l.approval_date) = 30;
                  
/* Query 14
Purpose: Display the total number of active and inactive cards.
Rows Returned: 1 */
SELECT SUM(is_activated) AS 'Active Cards', COUNT(is_activated) - SUM(is_activated) AS 'Inactive Cards'
FROM cards;

/* Query 15
Purpose: Retrieve the names of customers who have both a savings and a checking account.  
Display the first name and last name.
Rows Returned: 2 */
SELECT first_name, 
       last_name
FROM customers 
WHERE customer_ID IN (SELECT customer_ID
					  FROM accounts
                      WHERE account_type = 'Savings')
AND customer_ID IN (SELECT customer_ID
                    FROM accounts
					WHERE account_type = 'Checking'); 

/* Query 16
Purpose: Show the number of loans approved each month. Display the month and the number of loans.
Rows Returned: 11 */
SELECT MONTH(approval_date) AS 'month', COUNT(loan_ID) AS 'num_loans'
FROM loans
GROUP BY MONTH(approval_date);

/* Query 17
Purpose: Retrieve all accounts with no transactions. Display account ID, customer ID, account type, 
balance, and open date.
Rows Returned: 3 */
SELECT account_ID, 
       customer_ID, 
       account_type, 
       balance, 
       open_date
FROM accounts
WHERE account_ID NOT IN (SELECT account_ID
						 FROM transactions);

/* Query 18
Purpose: List all customers who have made a transfer in 2024. Display the customer ID, first name, 
last name, email, and phone.
Rows Returned: 10 */
SELECT customer_ID, 
       first_name, 
       last_name, 
       email, 
       phone
FROM customers 
WHERE customer_ID IN (SELECT customer_ID
                      FROM accounts a 
                      JOIN transfers t ON (a.account_ID = t.source_account_ID)
                      WHERE YEAR(transfer_date) = 2024);

/* Query 19
Purpose: Show all accounts with a balance greater than the average balance.
Rows Returned:  */
SELECT account_ID
FROM accounts
WHERE balance > (SELECT AVG(balance) 
                 FROM accounts);

/* Query 20
Purpose: Retrieve the names of customers who have not taken a loan. Display the customer ID, 
first name, last name, email, and phone.
Rows Returned: 2 */
SELECT c.customer_id, 
       first_name, 
	   last_name,
       email,
       phone
FROM customers c
WHERE NOT EXISTS (
      SELECT *
	  FROM loans l
	  WHERE c.customer_id = l.customer_id);

/* Query 21
Purpose: Show all accounts with negative balances. Display the account ID, customer ID, 
account type, balance, and open date.
Rows Returned:  */
SELECT *
FROM accounts
WHERE balance < 0;

/* Query 22
Purpose: List all customers who have made transactions on the same day they opened their 
account. Display the customer ID, first name, last name, email, and phone.
Rows Returned: 1 */
SELECT customer_ID, 
       first_name, 
       last_name, 
       email, 
       phone
FROM customers 
WHERE customer_ID IN (SELECT customer_ID
                      FROM accounts a 
                      JOIN transactions t ON (a.account_ID = t.account_ID)
                      WHERE open_date = transaction_date);
                      
/* Query 23
Purpose: List all customers who have more than one active card. Display the customer ID, 
first name, last name, email, and phone.
Rows Returned: 2 */
SELECT customer_ID, 
       first_name, 
       last_name, 
       email, 
       phone
FROM customers
WHERE customer_ID IN (SELECT customer_ID
					  FROM cards
                      GROUP BY customer_ID
                      HAVING COUNT(card_ID) > 1);