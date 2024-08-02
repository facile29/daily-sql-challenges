--  Leetcode 50 SQL QUESTIONS 

-- Question: Friends request 2: who has the most Friends
-- Table: RequestsAccepted
-- Write a solution to find the people who have the most friends and the most friends number.

SELECT id, COUNT(*) AS num 
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS friends_count
GROUP BY id
ORDER BY num DESC 
LIMIT 1;


-- Question: Investment in 2016
-- Table: Insurance 
-- Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:
-- have the same tiv_2015 value as one or more other policyholders, and
-- are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
-- Round tiv_2016 to two decimal places.

select round(sum(TIV_2016),2) as tiv_2016
from insurance
where tiv_2015 in (select tiv_2015 
                from insurance 
                group by tiv_2015
                having count(pid) > 1)
and (lat, lon) in (select lat, lon 
                from insurance 
                group by lat, lon 
                having count(pid) = 1);


-- Question: Department top 3 salaries
-- Table: Employee, Department
-- Write a solution to find the employees who are high earners in each of the departments.

Select d.name as department , e1.name as employee, e1.salary as Salary
From Employee e1 join Department d on e1.DepartmentId = d.Id
Where  3 > (select count(distinct (e2.Salary))
            from  Employee e2
            where e2.Salary > e1.Salary
            and e1.DepartmentId = e2.DepartmentId);


-- Question: Fix name in table 
-- Table: Users
-- Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
-- Return the result table ordered by user_id.

SELECT 
    user_id, 
    CONCAT(UPPER(LEFT(name,1)),LOWER(SUBSTRING(name,2))) AS name
FROM Users 
ORDER BY user_id;


-- Question: Patients with a condition
-- Table: Patients
-- Write a solution to find the patient_id, patient_name, 
-- and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.

SELECT *
FROM Patients
WHERE conditions LIKE '% DIAB1%' OR conditions LIKE 'DIAB1%';