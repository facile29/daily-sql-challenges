--  Leetcode 50 SQL QUESTIONS 

-- Question: Primary department fro each employee
-- Table: Employee
-- Write a solution to report all the employees with their primary department.
-- For employees who belong to one department, report their only department.

SELECT employee_id, department_id 
FROM Employee WHERE primary_flag = 'Y'
UNION
SELECT employee_id, department_id 
FROM Employee
GROUP BY employee_id
HAVING COUNT(department_id) = 1;


-- Question: Triangle judgement 
-- Table: Triangle
-- Report for every three line segments whether they can form a triangle.

SELECT x,y,z,IF(X+Y>Z AND Y+Z>X AND Z+X>Y, "Yes","No") AS Triangle 
FROM TRIANGLE;


-- Question: Consecutive numbers
-- Table: Logs
-- Find all numbers that appear at least three times consecutively.

SELECT distinct Num as ConsecutiveNums
FROM Logs
WHERE (Id + 1, Num) in (select * from Logs) and (Id + 2, Num) IN (select * from Logs);


-- Question: Product price at the given date 
-- Table: Products
-- Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

select distinct product_id, 10 as price
from products
group by product_id
having min(change_date) > "2019-08-16"
union
select product_id, new_price
from Products 
where (product_id, change_date) in(select product_id, max(change_date) as recent_date
from Products 
where change_date <= "2019-08-16"
group by product_id );

-- Question: Last person to fit in the bus
-- Table: Queue
-- Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
-- The test cases are generated such that the first person does not exceed the weight limit.

SELECT person_name
FROM Queue
WHERE (SELECT SUM(weight) FROM Queue AS q2 WHERE q2.turn <= Queue.turn) <= 1000
ORDER BY turn DESC
LIMIT 1;

