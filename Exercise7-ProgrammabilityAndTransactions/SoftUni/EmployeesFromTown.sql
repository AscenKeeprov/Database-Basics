USE SoftUni
GO

CREATE PROCEDURE dbo.usp_GetEmployeesFromTown (@TownName NVARCHAR(MAX))
AS
	SELECT
		Employees.FirstName AS [First Name],
		Employees.LastName AS [Last Name]
	FROM Employees
	JOIN
	(
		SELECT
			a.AddressID,
			a.AddressText,
			t.TownID,
			t.[Name] AS [TownName]
		FROM Addresses AS a
		JOIN Towns AS t
		ON t.TownID = a.TownID
	) AS AddressesTowns
	ON AddressesTowns.AddressID = Employees.AddressID
	WHERE AddressesTowns.TownName = @TownName + '%'
GO

EXECUTE usp_GetEmployeesFromTown @TownName = 'Sofia'
GO
