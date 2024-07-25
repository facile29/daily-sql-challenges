-- Leetcode 50 SQL QUESTIONS 

-- Question : Replace employee id with the unique identifier 
-- Table: Employees
-- Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

select e1.unique_id, e2.name
from EmployeeUNI as e1 
RIGHT JOIN Employees as e2
on e1.id=e2.id;


-- Question: Product sales analysis 1
-- Table: Sales
-- Write a solution to report the product_name, year, and price for each sale_id in the Sales table.

select p.product_name, s.year, s.price from product as p
inner join sales as s
on p.product_id=s.product_id;


-- Question: Customers who visited but did not make any transactions 
-- Table: Visits
-- Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

SELECT v.customer_id, COUNT(v.visit_id) as count_no_trans 
FROM Visits v
LEFT JOIN Transactions t
ON v.visit_id = t.visit_id
WHERE transaction_id IS NULL
GROUP BY customer_id;


-- Question: Rising temperature 
-- Table:Weather 
-- Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

select a.id from weather as a
JOIN weather as b
on DATEDIFF(a.recordDate, b.recordDate) = 1
where a.temperature>b.temperature;


-- Question: Average time of process per machine
-- Table: Activity 
-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

SELECT S.machine_id, ROUND(AVG(E.timestamp - S.timestamp), 3) as processing_time
from activity as S
join activity as E
on S.machine_id = E.machine_id
and S.process_id = E.process_id
and S.activity_type = 'start'
and E.activity_type = 'end'
group by S.machine_id;

