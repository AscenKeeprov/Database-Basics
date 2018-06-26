USE SoftUni

SELECT FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'SA%'

SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%ei%'

SELECT FirstName
FROM Employees
WHERE DepartmentID IN (3, 10)
AND YEAR(HireDate) BETWEEN 1995 AND 2005

SELECT FirstName, LastName
FROM Employees
WHERE LOWER(JobTitle) NOT LIKE '%engineer%'

SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

