USE TripService

WITH CTE_AccountsCities AS
(
	SELECT
		a.Id AS [AccountId],
		CONCAT(
		a.FirstName, ' ',
		CASE
			WHEN a.MiddleName IS NULL THEN ''
			ELSE a.MiddleName + ' '
		END,
		a.LastName) AS [Full Name],
		c.[Name] AS [From]
	FROM Accounts AS a
	JOIN Cities AS c
	ON c.Id = a.CityId
)

SELECT
	actr.TripId,
	ac.[Full Name],
	ac.[From],
	c.[Name] AS [To],
	CASE
		WHEN t.CancelDate IS NULL THEN
		 CAST(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate) AS VARCHAR(MAX)) + ' days'
		ELSE 'Canceled'
	END
FROM CTE_AccountsCities AS ac
JOIN AccountsTrips AS actr
ON actr.AccountId = ac.AccountId
JOIN Trips AS t
ON t.Id = actr.TripId
JOIN Rooms AS r
ON r.Id = t.RoomId
JOIN Hotels AS h
ON h.Id = r.HotelId
JOIN Cities AS c
ON c.Id = h.CityId
ORDER BY ac.[Full Name], actr.[TripId]
