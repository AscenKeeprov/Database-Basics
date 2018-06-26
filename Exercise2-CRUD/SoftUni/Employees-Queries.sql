USE SoftUni

SELECT FirstName, LastName, Salary
FROM Employees

SELECT FirstName, MiddleName, LastName
FROM Employees

SELECT CONCAT(FirstName, '.', LastName, '@softuni.bg')
AS [Full Email Address]
FROM Employees

SELECT DISTINCT Salary
FROM Employees

SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative'

SELECT FirstName, LastName, JobTitle, Salary
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName)
AS [Full Name]
FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)

SELECT FirstName, LastName
FROM Employees
WHERE ManagerID IS NULL

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > 50000
ORDER BY Salary DESC

SELECT TOP(5) FirstName, LastName
FROM Employees
ORDER BY Salary DESC

BEGIN /* All Employees Except Marketing */
DECLARE @MarketingId INT =
(
SELECT DepartmentID FROM Departments
WHERE Name LIKE '%Marketing%'
)

SELECT FirstName, LastName
FROM Employees
WHERE DepartmentID != @MarketingId
END

SELECT * FROM Employees
ORDER BY Salary DESC, FirstName, LastName DESC, MiddleName

SELECT DISTINCT JobTitle
FROM Employees

SELECT TOP(7)
	FirstName,
	LastName,
	HireDate
FROM Employees
ORDER BY HireDate DESC

UPDATE Employees
SET Salary *= 1.12
WHERE DepartmentID IN (1, 2, 4, 11)

SELECT Salary
FROM Employees

UPDATE Employees
SET Salary /= 1.12
WHERE DepartmentID IN (1, 2, 4, 11)

SELECT Salary
FROM Employees
