USE TripService
GO

CREATE PROCEDURE dbo.usp_SwitchRoom (@TripId INT, @TargetRoomId INT)
AS
BEGIN
	DECLARE @HotelId INT = 
	(
		SELECT h.Id
		FROM Trips AS t
		JOIN Rooms AS r
		ON t.RoomId = r.Id
		JOIN Hotels AS h
		ON h.Id = r.HotelId
		WHERE t.Id = @TripId
	)

	DECLARE @TargetHotelId INT = 
	(
		SELECT h.Id
		FROM Rooms AS r
		JOIN Hotels AS h
		ON h.Id = r.HotelId
		WHERE r.Id = @TargetRoomId
	)

	IF (@TargetHotelId <> @HotelId)
	BEGIN
		RAISERROR ('Target room is in another hotel!', 16, 1)
		RETURN
	END

	DECLARE @GuestCount INT = 
	(
		SELECT COUNT(a.Id)
		FROM Trips AS t
		JOIN AccountsTrips AS actr
		ON actr.TripId = t.Id
		JOIN Accounts AS a
		ON a.Id = actr.AccountId
		WHERE t.Id = @TripId
	)

	DECLARE @BedsCount INT = 
	(
		SELECT Beds
		FROM Rooms
		WHERE Id = @TargetRoomId
	)

	IF (@BedsCount < @GuestCount)
	BEGIN
		RAISERROR ('Not enough beds in target room!', 16, 1)
		RETURN
	END

	UPDATE Trips
	SET RoomId = @TargetRoomId
	WHERE Id = @TripId
END
GO

EXEC usp_SwitchRoom 10, 7
GO

EXEC usp_SwitchRoom 10, 8
GO
