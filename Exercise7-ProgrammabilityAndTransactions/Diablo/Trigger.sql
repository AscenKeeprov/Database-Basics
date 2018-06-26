USE Diablo
GO

CREATE TRIGGER tr_UserGameItemsLevelInsert ON UserGameItems
INSTEAD OF INSERT AS
BEGIN
	INSERT INTO UserGameItems (ItemId, UserGameId)
	SELECT
		ins.ItemId,
		--its.MinLevel,
		--its.Price,
		ug.GameId
		--ug.[Level]
	FROM inserted AS ins
	JOIN UsersGames AS ug
	ON ug.GameId = ins.UserGameId
	JOIN Items AS its
	ON its.Id = ins.ItemId
	WHERE ug.[Level] >= its.MinLevel
END
GO
--Game 159 -> level 1
--
