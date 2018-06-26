USE SoftUni
GO

CREATE PROCEDURE dbo.usp_GetTownsStartingWith (@String NVARCHAR(MAX))
AS
	SELECT [Name]
	FROM Towns
	WHERE LEFT([Name], LEN(@String)) = @String
GO

EXECUTE usp_GetTownsStartingWith @String = 'b'
GO
