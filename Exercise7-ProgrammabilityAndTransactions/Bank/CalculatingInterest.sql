USE Bank
GO

CREATE PROCEDURE dbo.usp_CalculateFutureValueForAccount
(
	@accountId INT,
	@annualInterest FLOAT,
	@years INT = 5
) AS
BEGIN
	SELECT
		a.Id AS [Account Id],
		ah.FirstName AS [First Name],
		ah.LastName AS [Last Name],
		a.Balance AS [Current Balance],
		dbo.ufn_CalculateFutureValue(Balance, @annualInterest, @years)
		 AS [Balance in 5 years]
	FROM AccountHolders AS ah
	JOIN Accounts AS a
	ON a.AccountHolderId = ah.Id
	AND a.Id = @accountId
END
GO

EXECUTE usp_CalculateFutureValueForAccount
 @accountId = 1, @annualInterest = 0.1
GO
