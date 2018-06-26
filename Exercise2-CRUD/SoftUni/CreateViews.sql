CREATE VIEW V_EmployeesSalaries
AS SELECT FirstName, LastName, Salary
FROM Employees
GO

CREATE VIEW V_EmployeeNameJobTitle AS
SELECT
	CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS [FullName],
	JobTitle
FROM Employees
