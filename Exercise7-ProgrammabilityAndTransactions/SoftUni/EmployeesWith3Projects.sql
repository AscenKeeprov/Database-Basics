USE SoftUni
GO

CREATE PROCEDURE dbo.usp_AssignProject (@employeeId INT, @projectID INT)
AS
BEGIN TRANSACTION
	IF NOT EXISTS
	(
		SELECT *
		FROM EmployeesProjects
		WHERE EmployeeID = @employeeId
		AND ProjectID = @projectID
	)
	BEGIN
		INSERT INTO EmployeesProjects (EmployeeID, ProjectID)
		VALUES (@employeeId, @projectID)

		DECLARE @employeeProjectsCount INT = 
		(
			SELECT COUNT(ProjectID)
			FROM EmployeesProjects
			WHERE EmployeeID = @employeeId
		)

		IF (@employeeProjectsCount > 3)
		BEGIN
			RAISERROR('The employee has too many projects!', 16, 1)
			ROLLBACK
			RETURN
		END
	END
COMMIT TRANSACTION
GO

EXECUTE usp_AssignProject @employeeId = 1, @projectId = 1
GO
