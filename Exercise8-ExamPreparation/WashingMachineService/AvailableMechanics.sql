USE WMS

SELECT CONCAT(FirstName, ' ', LastName) AS [Available]
FROM Mechanics
WHERE MechanicId NOT IN
(
	SELECT DISTINCT MechanicId
	FROM Jobs
	WHERE MechanicId IS NOT NULL
	AND [Status] <> 'Finished'
)
ORDER BY MechanicId
