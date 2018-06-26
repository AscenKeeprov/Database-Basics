USE SoftUni
GO

CREATE TABLE Deleted_Employees
(
	EmployeeId INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	MiddleName VARCHAR(50),
	JobTitle VARCHAR(50) NOT NULL,
	DepartmentId INT NOT NULL,
	Salary MONEY NOT NULL
)
GO

CREATE TRIGGER tr_EmployeesDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
	INSERT INTO Deleted_Employees
	SELECT
		EmployeeId,
		FirstName,
		LastName,
		MiddleName,
		JobTitle,
		DepartmentId,
		Salary
	FROM deleted
END
GO

--Judge-compatible solution:
--CREATE TRIGGER tr_EmployeesDelete
--ON Employees
--FOR DELETE
--AS
--BEGIN
--	INSERT INTO Deleted_Employees
--	SELECT
--		FirstName,
--		LastName,
--		MiddleName,
--		JobTitle,
--		DepartmentId,
--		Salary
--	FROM deleted
--END
--GO

DELETE FROM Employees
WHERE EmployeeID = 293
GO
