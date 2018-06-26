USE TripService
GO

CREATE Function dbo.udf_GetAvailableRoom
 (@HotelId INT, @Date DATE, @People INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @Result NVARCHAR(MAX)
	DECLARE @RoomId VARCHAR(14)
	DECLARE @RoomType NVARCHAR(20)
	DECLARE @Beds VARCHAR(4)
	DECLARE @TotalPrice NVARCHAR(21)

	IF (EXISTS
	(
		SELECT
			t.RoomId,
			r.[Type] AS [RoomType],
			r.Beds,
			r.Price AS [RoomPrice],
			h.Id AS [HotelId],
			h.BaseRate AS [HotelBaseRate]
		FROM Trips AS t
		JOIN Rooms AS r
		ON r.Id = t.RoomId
		AND r.Beds >= @People
		JOIN Hotels AS h
		ON h.Id = r.HotelId
		AND h.Id = @HotelId
		WHERE @Date < t.ArrivalDate
		OR @Date > t.ReturnDate
		OR t.CancelDate IS NOT NULL
	))
	BEGIN
		SET @RoomId = CAST(
		(
			SELECT TOP(1) t.RoomId
			FROM Trips AS t
			JOIN Rooms AS r
			ON r.Id = t.RoomId
			AND r.Beds >= @People
			JOIN Hotels AS h
			ON h.Id = r.HotelId
			AND h.Id = @HotelId
			WHERE @Date < t.ArrivalDate
			OR @Date > t.ReturnDate
			OR t.CancelDate IS NOT NULL
			ORDER BY r.Price DESC
		) AS VARCHAR(14))

		SET @RoomType = CAST(
		(
			SELECT TOP(1) r.[Type]
			FROM Trips AS t
			JOIN Rooms AS r
			ON r.Id = t.RoomId
			AND r.Beds >= @People
			JOIN Hotels AS h
			ON h.Id = r.HotelId
			AND h.Id = @HotelId
			WHERE @Date < t.ArrivalDate
			OR @Date > t.ReturnDate
			OR t.CancelDate IS NOT NULL
			ORDER BY r.Price DESC
		) AS NVARCHAR(20))

		SET @Beds = CAST(
		(
			SELECT TOP(1) r.Beds
			FROM Trips AS t
			JOIN Rooms AS r
			ON r.Id = t.RoomId
			AND r.Beds >= @People
			JOIN Hotels AS h
			ON h.Id = r.HotelId
			AND h.Id = @HotelId
			WHERE @Date < t.ArrivalDate
			OR @Date > t.ReturnDate
			OR t.CancelDate IS NOT NULL
			ORDER BY r.Price DESC
		) AS VARCHAR(4))

		SET @TotalPrice = CAST(
		(
			SELECT TOP(1)
				(h.BaseRate + r.Price) * @People
			FROM Trips AS t
			JOIN Rooms AS r
			ON r.Id = t.RoomId
			AND r.Beds >= @People
			JOIN Hotels AS h
			ON h.Id = r.HotelId
			AND h.Id = @HotelId
			WHERE @Date < t.ArrivalDate
			OR @Date > t.ReturnDate
			OR t.CancelDate IS NOT NULL
			ORDER BY r.Price DESC
		) AS NVARCHAR(21))

		SET @Result = 'Room ' + @RoomId + ': ' + @RoomType
		 + ' (' + @Beds + ' beds) - $' + @TotalPrice
	END
	ELSE
	BEGIN
		SET @Result = 'No rooms available'
	END

	RETURN @Result
END
GO

SELECT dbo.udf_GetAvailableRoom(112, '2011-12-17', 2)
GO

SELECT dbo.udf_GetAvailableRoom(94, '2015-07-26', 3)
GO
