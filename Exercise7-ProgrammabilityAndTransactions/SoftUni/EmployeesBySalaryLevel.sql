USE SoftUni
GO

CREATE PROCEDURE dbo.usp_EmployeesBySalaryLevel (@SalaryLevel VARCHAR(7)) AS
BEGIN
	SELECT
		e.FirstName AS [First Name],
		e.LastName AS [Last Name]
	FROM dbo.Employees AS e
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLevel
END
GO

EXECUTE dbo.usp_EmployeesBySalaryLevel @SalaryLevel = 'High'
GO
