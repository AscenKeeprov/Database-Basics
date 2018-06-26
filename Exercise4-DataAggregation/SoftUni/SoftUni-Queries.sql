USE SoftUni

SELECT
	DepartmentID,
	SUM(Salary) AS [TotalSalary]
FROM Employees
GROUP BY DepartmentID

SELECT
	DepartmentID,
	MIN(Salary) AS [MinimumSalary]
FROM Employees
WHERE DepartmentID IN (2, 5, 7)
AND HireDate > '01/01/2000'
GROUP BY DepartmentID

SELECT * INTO EmployeesSalaryAbove30K
FROM Employees
WHERE Salary > 30000

DELETE FROM EmployeesSalaryAbove30K
WHERE ManagerID = 42

UPDATE EmployeesSalaryAbove30K
SET Salary += 5000
WHERE DepartmentID = 1

SELECT
	DepartmentID,
	AVG(Salary) AS [AverageSalary]
FROM EmployeesSalaryAbove30K
GROUP BY DepartmentID

SELECT
	DepartmentID,
	MAX(Salary) AS [MaxSalary]
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) < 30000 OR MAX(Salary) > 70000

SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL

SELECT DISTINCT DepartmentID, Salary FROM
(
SELECT
	DepartmentID,
	Salary,
	DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS [SalaryRank]
FROM Employees
) AS DepartmentsSalariesRanked
WHERE SalaryRank = 3

SELECT TOP(10) FirstName, LastName, DepartmentID
FROM Employees AS e1
WHERE Salary >
(
	SELECT AVG(Salary)
	FROM Employees AS e2
	WHERE e2.DepartmentID = e1.DepartmentID
	GROUP BY DepartmentID
)
ORDER BY DepartmentID
