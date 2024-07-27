-- Leetcode 50 SQL QUESTIONS 

-- Question:Employee Bonus
-- Table:Employee
-- Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.

select e.name, b.bonus from employee as e 
left join bonus as b
on e.empId = b.empId
where b.bonus<1000 OR b.bonus IS NULL;


-- Question: Students and Examinations
-- Table: Student 
-- Write a solution to find the number of times each student attended each exam.

SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.student_id) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;


-- Question:Manager with at least 5 direct reports
-- Table:Employee
-- Write a solution to find managers with at least five direct reports.

SELECT a.name
FROM Employee as a
WHERE (
    SELECT COUNT(*)
    FROM Employee as b
    WHERE b.managerId = a.id
) >= 5;


-- Question:Confirmation Rate 
-- Table: Sign ups
-- Write a solution to find the confirmation rate of each user.

SELECT s.user_id,
IFNULL( ROUND( SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(*), 2), 0.00) AS confirmation_rate
FROM Signups as s
LEFT JOIN Confirmations as c
ON s.user_id = c.user_id
GROUP BY s.user_id;


-- Question: Not boring movies 
-- Table: Cinema
-- Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".

select* from cinema 
where id%2 <>0 and description <> "boring"
order by rating desc;
