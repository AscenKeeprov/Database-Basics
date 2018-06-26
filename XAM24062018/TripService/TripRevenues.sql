USE TripService

SELECT
	t.Id,
	h.[Name] AS [HotelName],
	r.[Type] AS [RoomType],
	CASE
		WHEN t.CancelDate IS NULL THEN
			ISNULL(SUM(h.BaseRate + r.Price), 0)
		ELSE 0
	END AS [Revenue]
FROM AccountsTrips AS actr
JOIN Trips AS t
ON t.Id = actr.TripId
JOIN Rooms AS r
ON r.Id = t.RoomId
JOIN Hotels AS h
ON h.Id = r.HotelId
GROUP BY t.Id, h.[Name], r.[Type], t.CancelDate
ORDER BY r.[Type], t.Id
