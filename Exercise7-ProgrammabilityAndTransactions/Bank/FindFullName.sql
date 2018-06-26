USE Bank
GO

CREATE PROCEDURE dbo.usp_GetHoldersFullName AS
BEGIN
	SELECT CONCAT(FirstName, ' ', LastName) AS [Full Name]
	FROM AccountHolders
END
GO

EXECUTE usp_GetHoldersFullName
GO
