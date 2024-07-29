--  Leetcode 50 SQL QUESTIONS 

-- Question: Immediate food delivery 2
-- Table: Delivery 
-- Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

SELECT
    ROUND(SUM(CASE WHEN DATEDIFF(customer_pref_delivery_date, order_date) = 0 THEN 1 ELSE 0 END) / COUNT(DISTINCT customer_id) * 100, 2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
);


-- Question: Game play analysis IV
-- Table: Activity
-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in,
-- rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days 
-- starting from their first login date, then divide that number by the total number of players.

SELECT ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY))
IN ( SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY player_id );


-- Question: Number of unique subjects taught by each teacher
-- Table: Teacher 
-- Write a solution to calculate the number of unique subjects each teacher teaches in the university.

select teacher_id , count(DISTINCT(subject_id)) as cnt
from teacher 
group by teacher_id;


-- Question: User activity for the past 30 days 
-- Table: Activity 
-- Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. 
-- A user was active on someday if they made at least one activity on that day.

SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date
ORDER BY day;


-- Question: Product sale analysis III
-- Table: Sales
-- Write a solution to select the product id, year, quantity, and price for the first year of every product sold.

select p.product_id, s.year as first_year, s.quantity,s.price 
from Product as p
left join Sales as s 
on p.product_id = s.product_id
where (s.product_id, s.year) in (select s1.product_id, min(s1.year) from Sales s1 group by s1.product_id);