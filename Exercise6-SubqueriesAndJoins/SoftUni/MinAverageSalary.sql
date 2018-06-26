USE SoftUni

SELECT MIN(AvgSalByDept.AvgSal) AS [MinAverageSalary]
FROM Employees AS Emp
JOIN
(
SELECT
	DepartmentID,
	AVG(Salary) AS [AvgSal]
FROM Employees
GROUP BY DepartmentID
) AS AvgSalByDept
ON AvgSalByDept.DepartmentID = Emp.DepartmentID
