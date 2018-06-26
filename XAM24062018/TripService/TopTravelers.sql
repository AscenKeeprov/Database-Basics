USE TripService

WITH CTE_TripsByCountry AS
(
	SELECT
		a.Id AS [AccountId],
		a.Email,
		c.CountryCode,
		COUNT(t.Id) AS [TripsCount],
		DENSE_RANK() OVER
		(
			PARTITION BY c.CountryCode
			ORDER BY COUNT(t.Id) DESC
		) AS [TripsRank]
	FROM Cities AS c
	JOIN Hotels AS h
	ON h.CityId = c.Id
	JOIN Rooms AS r
	ON r.HotelId = h.Id
	JOIN Trips AS t
	ON t.RoomId = r.Id
	JOIN AccountsTrips AS at
	ON at.TripId = t.Id
	JOIN Accounts AS a
	ON a.Id = at.AccountId
	GROUP BY c.CountryCode, a.Id, a.Email
)
,

CTE_MaxTripsByCountry AS
(
	SELECT
		AccountId,
		Email,
		CountryCode,
		MAX(TripsCount) AS [MaxTripsCount],
		ROW_NUMBER() OVER
		(
			PARTITION BY CountryCode
			ORDER BY MAX(TripsCount) DESC
		) AS [MaxTripsRank]
	FROM  CTE_TripsByCountry
	WHERE TripsRank = 1
	GROUP BY CountryCode, AccountId, Email
)

SELECT
	AccountId,
	Email,
	CountryCode,
	MaxTripsCount AS [Trips]
FROM CTE_MaxTripsByCountry
WHERE MaxTripsRank = 1
ORDER BY [Trips] DESC, AccountId
