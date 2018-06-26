USE Diablo

DECLARE @SafflowerGameId INT = 
(
	SELECT Id
	FROM Games
	WHERE [Name] = 'Safflower'
)

DECLARE @StamatUserId INT = 
(
	SELECT Id
	FROM Users
	WHERE Username = 'Stamat'
)

DECLARE @StamatSafflowerGameId INT = 
(
	SELECT Id
	FROM UsersGames
	WHERE GameId = @SafflowerGameId
	AND UserId = @StamatUserId
)

DECLARE @StamatSafflowerCash MONEY = 
(
	SELECT Cash
	FROM UsersGames
	WHERE Id = @StamatSafflowerGameId
)

DECLARE @ItemsTotalPrice11To12 MONEY = 
(
	SELECT SUM(Price)
	FROM Items
	WHERE MinLevel BETWEEN 11 AND 12
)

DECLARE @ItemsCountLevel11To12 INT = 
(
	SELECT COUNT(*)
	FROM Items
	WHERE MinLevel BETWEEN 11 AND 12
)

DECLARE @ItemsTotalPrice19To21 MONEY = 
(
	SELECT SUM(Price)
	FROM Items
	WHERE MinLevel BETWEEN 19 AND 21
)

DECLARE @ItemsCountLevel19To21 INT = 
(
	SELECT COUNT(*)
	FROM Items
	WHERE MinLevel BETWEEN 19 AND 21
)

BEGIN TRANSACTION

IF (@StamatSafflowerCash >= @ItemsTotalPrice11To12)
BEGIN
	UPDATE UsersGames
	SET Cash -= @ItemsTotalPrice11To12
	WHERE Id = @StamatSafflowerGameId

	IF (@@ROWCOUNT <> 1)
	BEGIN
		ROLLBACK
		RETURN
	END

	SET @StamatSafflowerCash -= @ItemsTotalPrice11To12

	INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT i.Id, ug.Id
	FROM Items AS i, UsersGames AS ug
	WHERE i.MinLevel BETWEEN 11 AND 12
	AND ug.Id = @StamatSafflowerGameId

	IF (@@ROWCOUNT <> @ItemsCountLevel11To12)
	BEGIN
		ROLLBACK
		RETURN
	END

	COMMIT TRANSACTION
END
ELSE ROLLBACK

BEGIN TRANSACTION

IF (@StamatSafflowerCash >= @ItemsTotalPrice19To21)
BEGIN
	UPDATE UsersGames
	SET Cash -= @ItemsTotalPrice19To21
	WHERE Id = @StamatSafflowerGameId

	IF (@@ROWCOUNT <> 1)
	BEGIN
		ROLLBACK
		RETURN
	END

	SET @StamatSafflowerCash -= @ItemsTotalPrice19To21

	INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT i.Id, ug.Id
	FROM Items AS i, UsersGames AS ug
	WHERE i.MinLevel BETWEEN 19 AND 21
	AND ug.Id = @StamatSafflowerGameId

	IF (@@ROWCOUNT <> @ItemsCountLevel19To21)
	BEGIN
		ROLLBACK
		RETURN
	END

	COMMIT TRANSACTION
END
ELSE ROLLBACK

SELECT i.[Name] AS [Item Name]
FROM UserGameItems as ugi
JOIN Items as i
ON i.Id = ugi.ItemId
WHERE UserGameId = @StamatSafflowerGameId
ORDER BY i.Name
