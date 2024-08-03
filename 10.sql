--  Leetcode 50 SQL QUESTIONS 

-- Question: Delete duplicate emails
-- Table: Persons
-- Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

delete a
from person a 
join person b
on a.email= b.email
AND a.id> b.id;


-- Question: Second highest salary
-- Table: Employee
-- Write a solution to find the second highest salary from the Employee table. 
-- If there is no second highest salary, return null (return None in Pandas).

SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee);


-- Question: Group sold products by the date 
-- Table: Activities
-- Write a solution to find for each date the number of different products sold and their names.

SELECT 
    sell_date, 
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;


-- Question: List the products ordered in a period
-- Table: Products , orders
-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

SELECT P.PRODUCT_NAME,SUM(O.UNIT) AS UNIT
FROM PRODUCTS P,ORDERS O 
WHERE P.PRODUCT_ID = O.PRODUCT_ID AND O.ORDER_DATE BETWEEN '2020-02-01' AND '2020-02-29' 
GROUP BY O.PRODUCT_ID 
HAVING UNIT >= 100 
ORDER BY O.PRODUCT_ID;


-- Question: Find users with valid emails
-- Table: Users
-- Write a solution to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
-- The domain is '@leetcode.com'.

SELECT * 
FROM users
WHERE mail REGEXP '^[a-zA-Z][a-zAZ0-9_.-]*@leetcode[.]com';