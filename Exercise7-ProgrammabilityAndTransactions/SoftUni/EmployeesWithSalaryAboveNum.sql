USE SoftUni
GO

CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Number DECIMAL (18,4))
AS
	SELECT
		FirstName AS [First Name],
		LastName AS [Last Name]
	FROM Employees
	WHERE Salary >= @Number
GO

EXECUTE usp_GetEmployeesSalaryAboveNumber @Number = 48100
GO
