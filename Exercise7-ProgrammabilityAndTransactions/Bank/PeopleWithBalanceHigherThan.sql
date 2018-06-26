USE Bank
Go

CREATE PROCEDURE dbo.usp_GetHoldersWithBalanceHigherThan (@Number DECIMAL(15,2)) AS
BEGIN
	WITH CTE_AccountsTotalBalances AS
	(
		SELECT
			AccountHolderId,
			SUM(Balance) AS [TotalBalance]
		FROM Accounts
		GROUP BY AccountHolderId
	)

	SELECT
		ah.FirstName AS [First Name],
		ah.LastName AS [Last Name]
	FROM AccountHolders AS ah
	JOIN CTE_AccountsTotalBalances AS atb
	ON atb.AccountHolderId = ah.Id
	WHERE atb.TotalBalance > @Number
	ORDER BY ah.LastName, ah.FirstName
END
GO

EXECUTE dbo.usp_GetHoldersWithBalanceHigherThan @Number = 200000
GO
