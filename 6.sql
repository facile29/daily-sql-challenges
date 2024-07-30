--  Leetcode 50 SQL QUESTIONS 

-- Question: Classes more than 5 students
-- Table: Courses
-- Write a solution to find all the classes that have at least five students.

select class from courses 
group by class 
having count(class)>=5;


Question: Find followers count 
Table: Followers
Write a solution that will, for each user, return the number of followers.

select user_id, count(follower_id) as followers_count
from followers
group by user_id
order by user_id;


-- Question: Biggest sale numbers
-- Table:MyNumbers
-- A single number is a number that appeared only once in the MyNumbers table.
-- Find the largest single number. If there is no single number, report null.

select max(num) as num 
from
(select num
from MyNumbers 
group by num
having count(num)=1 ) as t;


-- Question: Customer who bought all products
-- Table: Customer, product
-- Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

select customer_id  from customer 
group by customer_id 
having count(distinct product_key)= (select count(distinct product_key) from product);


-- Question: The number of employees which report to each employee 
-- Table: Employees
-- Write a solution to report the ids and the names of all managers, 
-- the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

select a.employee_id, a.name , count(b.reports_to) as reports_count
, round(avg(b.age)) as average_age 
from employees as a
join employees as b
on a.employee_id=b.reports_to
group by employee_id
order by employee_id;
