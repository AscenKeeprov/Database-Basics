USE Diablo
GO

CREATE FUNCTION dbo.ufn_CashInUsersGames (@gameName NVARCHAR(64))
RETURNS TABLE
AS RETURN
(
	SELECT SUM(Cash) AS [SumCash]
	FROM
	(
		SELECT
			g.[Name],
			ug.Cash,
			ROW_NUMBER() OVER(ORDER BY Cash DESC) AS [CashRank]
		FROM Games AS g
		JOIN UsersGames AS ug
		ON ug.GameId = g.Id
		WHERE g.[Name] = @gameName
	) AS GameCashRanked
	WHERE CashRank % 2 = 1
)
GO

SELECT * FROM dbo.ufn_CashInUsersGames('Lily Stargazer')
GO
