USE WMS

SELECT
	CONCAT(m.FirstName, ' ', m.LastName) AS [Mechanic],
	AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate)) AS [Average Days]
FROM Mechanics AS m
JOIN Jobs AS j
ON j.MechanicId = m.MechanicId
WHERE j.[Status] = 'Finished'
GROUP BY CONCAT(m.FirstName, ' ', m.LastName), m.MechanicId
ORDER BY m.MechanicId

--WITH CTE_MechanicsJobDays (MechanicId, Mechanic, [JobDays]) AS
--(
--	SELECT
--		m.MechanicId,
--		CONCAT(m.FirstName, ' ', m.LastName) AS [Mechanic],
--		DATEDIFF(DAY, j.IssueDate, j.FinishDate) AS [JobDays]
--	FROM Mechanics AS m
--	JOIN Jobs AS j
--	ON j.MechanicId = m.MechanicId
--	WHERE j.[Status] = 'Finished'
--)

--SELECT
--	Mechanic,
--	AVG([JobDays]) AS [Average Days]
--FROM CTE_MechanicsJobDays
--GROUP BY MechanicId, Mechanic
