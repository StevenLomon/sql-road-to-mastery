-- 1. Employees with first and last name along with the first and last names of their immediate manager

-- This is a very interesting table in that we don't need to do a JOIN, all info is within the employee table

SELECT 
	employeeId,
	firstName,
	lastName,
	managerId,
	(SELECT firstName FROM employee WHERE employeeId=8)
FROM
	employee

-- This would be so incredibly easy if all managers were in a separate table. But with all managers also in the
-- employee table, this is almost frustratingly difficult, wow. I'm tempted to give up on the very first 
-- challenge, this is amazing hahaha!
-- The above works. It's obviously wrong but that's about what I can do with my current tool belt. Eager to see
-- the solution!!

-- Okay, without having seen her solution, she said something bonkers: 
-- "All the information needed for this challenge is included within the employee table. So think about
-- solving this with a JOIN type that will allow you to join back to the same table more than once within 
-- your query"
-- Joining back to the same table???????? I wasn't even aware that is something you can do but it totally makes
-- sense that that is what we need to do here.

SELECT
	e1.firstName,
	e1.lastName
FROM
	employee AS e1
INNER JOIN
	employee AS e2
ON 
	e2.managerId = e1.employeeId

-- This gives the first and last name of the managers. Let's make that a CTE?

WITH Managers AS (
SELECT
	e1.firstName AS ManagerFirstName,
	e1.lastName AS ManagerLastName
FROM
	employee AS e1
INNER JOIN
	employee AS e2
ON 
	e2.managerId = e1.employeeId
)
SELECT
	firstName,
	lastName,
	SELECT ManagerFirstName FROM Managers,
	SELECT ManagerLastName FROM Managers
FROM 
	employee

-- Okay, I give up :') This is so far beyond my current ability, wow

-- SELF JOIN?????? I had no idea that was a thing!! Okay, no, it's still a regular INNER JOIN haha

SELECT
	emp.firstName,
	emp.lastName,
	emp.title,
	mng.firstName AS ManagerFirstName,
	mng.lastName AS ManagerLastName
FROM
	employee AS emp
INNER JOIN
	employee AS mng
ON
	emp.managerId = mng.employeeId
	
-- Self-joins are a thing and I now have that in my tool belt! Failing forward!
