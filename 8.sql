--  Leetcode 50 SQL QUESTIONS 

-- Question: Count salary categories
-- Table: Accounts
-- Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

-- "Low Salary": All the salaries strictly less than $20000.
-- "Average Salary": All the salaries in the inclusive range [$20000, $50000].
-- "High Salary": All the salaries strictly greater than $50000.
-- The result table must contain all three categories. If there are no accounts in a category, return 0.

(SELECT "Low Salary" AS category, COUNT(*) AS accounts_count FROM Accounts WHERE income < 20000)

UNION

(SELECT "Average Salary" AS category, COUNT(*) AS accounts_count FROM Accounts WHERE 20000 <= income AND income <= 50000)

UNION

(SELECT "High Salary" AS category, COUNT(*) AS accounts_count FROM Accounts WHERE 50000 < income);


-- Question: Employees whose manager left the company 
-- Table: Employees
-- Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, 
-- their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.

SELECT e.employee_id 
FROM Employees e 
WHERE e.salary < 30000 AND e.manager_id NOT IN (
    SELECT m.employee_id 
    FROM Employees m)
GROUP BY e.employee_id 
ORDER BY e.employee_id;


-- Question: Exchange seats
-- Table: Seat 
-- Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

# Write your MySQL query statement below
SELECT 
CASE
WHEN (id = (SELECT MAX(id) FROM Seat) AND id MOD 2 = 1) THEN id
WHEN (id MOD 2 = 1) THEN id+1
WHEN (id MOD 2 = 0) THEN id-1
END AS id, student
FROM Seat
ORDER BY id;


-- Question: Movie rating
-- Table: Movie, Users, Movie _rating
-- Write a solution to:
-- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
-- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

(SELECT name AS results
FROM MovieRating JOIN Users USING(user_id)
GROUP BY name
ORDER BY COUNT(*) DESC, name
LIMIT 1)
UNION ALL
(SELECT title AS results
FROM MovieRating JOIN Movies USING(movie_id)
WHERE EXTRACT(YEAR_MONTH FROM created_at) = 202002
GROUP BY title
ORDER BY AVG(rating) DESC, title
LIMIT 1);


-- Question: Restaurant Growth
-- Table: Customer
-- Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). 
-- average_amount should be rounded to two decimal places.

select distinct visited_on, sum(amount) over w as amount, round((sum(amount) over w)/7, 2) as average_amount
from customer
WINDOW w as ( order by visited_on range between interval 6 day PRECEDING and current row )
Limit 6, 999;

