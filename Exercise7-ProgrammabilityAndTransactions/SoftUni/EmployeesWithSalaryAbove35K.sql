USE SoftUni
GO

--Start Judge-compatible block
CREATE PROCEDURE dbo.usp_GetEmployeesSalaryAbove35000
AS
	SELECT
		FirstName AS [First Name],
		LastName AS [Last Name]
	FROM Employees
	WHERE Salary > 35000
--End Judge-compatible block
GO

EXECUTE usp_GetEmployeesSalaryAbove35000
GO
