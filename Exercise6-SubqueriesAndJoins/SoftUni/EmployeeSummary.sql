USE SoftUni

SELECT TOP(50)
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS [EmployeeName],
	m.EmployeeName AS [ManagerName],
	d.[Name] AS [DepartmentName]
FROM Employees AS e
JOIN
(
SELECT
	EmployeeID,
	CONCAT(FirstName, ' ', LastName) AS [EmployeeName]
FROM Employees
) AS m
ON m.EmployeeID = e.ManagerID
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID
