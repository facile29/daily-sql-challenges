--  Leetcode 50 SQL QUESTIONS 

-- Question: Average selling price
-- Table: Prices 
-- Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.

SELECT p.product_id, IFNULL(ROUND(SUM(units*price)/SUM(units),2),0) AS average_price
FROM Prices p LEFT JOIN UnitsSold u
ON p.product_id = u.product_id AND
u.purchase_date BETWEEN start_date AND end_date
group by product_id;


-- Question: Project Employees 1
-- Table: Project 
-- Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

select project_id, ROUND(avg(experience_years), 2) as average_years
from project as p
join employee as e
on p.employee_id=e.employee_id
group by project_id;


-- Question: Percentage of user attended a contest
-- Table: Users
-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

SELECT
    r.contest_id,
    ROUND(COUNT(r.user_id) / (SELECT COUNT(DISTINCT user_id) FROM Users) * 100, 2) AS percentage
FROM Register r
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id;


-- Question: Queries quality and percentage 
-- Table: Queries 
-- Write a solution to find each query_name, the quality and poor_query_percentage. Both quality and poor_query_percentage should be rounded to 2 decimal places.


select distinct query_name ,
round(avg(rating/position) over(partition by query_name) ,2) as quality,
round(avg(case when rating<3 then 1 else 0 end) over(partition by query_name)*100,2) as poor_query_percentage 
from queries
where query_name is not null;


-- Question: Monthly transactions 1
-- Table: Transactions
-- Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

SELECt DATE_FORMAT(trans_date, '%Y-%m') AS month,country, COUNT(*) AS trans_count,
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country;
