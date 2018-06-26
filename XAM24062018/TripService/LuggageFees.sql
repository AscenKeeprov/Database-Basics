USE TripService

SELECT
	TripId,
	SumLuggage AS [Luggage],
	CASE
		WHEN SumLuggage > 5 THEN '$' + CAST(SumLuggage * 5 AS NVARCHAR(MAX))
		ELSE '$0'
	END AS [Fee]
FROM
(
	SELECT
		TripId,
		SUM(Luggage) AS [SumLuggage]
	FROM AccountsTrips
	WHERE Luggage > 0
	GROUP BY TripId
) AS LuggageFees
ORDER BY SumLuggage DESC
