USE WMS

SELECT TOP(3)
	CONCAT(m.FirstName, ' ', m.LastName) AS [Mechanic],
	COUNT(j.JobId) AS [Jobs]
FROM Mechanics AS m
JOIN Jobs AS j
ON j.MechanicId = m.MechanicId
WHERE j.[Status] <> 'Finished'
GROUP BY CONCAT(m.FirstName, ' ', m.LastName), m.MechanicId
HAVING COUNT(j.JobId) > 1
ORDER BY Jobs DESC, m.MechanicId

--WITH CTE_MechanicsUnfinishedJobs (MechanicId, Mechanic, JobId) AS
--(
--	SELECT
--		m.MechanicId,
--		CONCAT(m.FirstName, ' ', m.LastName) AS [Mechanic],
--		j.JobId
--	FROM Mechanics AS m
--	JOIN Jobs AS j
--	ON j.MechanicId = m.MechanicId
--	WHERE j.[Status] <> 'Finished'
--)
--,

--CTE_Mechanics1PlusActiveJobs (MechanicId, Mechanic, Jobs) AS
--(
--	SELECT
--		MechanicId,
--		Mechanic,
--		COUNT(JobId) AS [Jobs]
--	FROM CTE_MechanicsUnfinishedJobs
--	GROUP BY MechanicId, Mechanic
--	HAVING COUNT(JobId) > 1
--)

--SELECT TOP(3)
--	Mechanic,
--	Jobs
--FROM CTE_Mechanics1PlusActiveJobs
--ORDER BY Jobs DESC, MechanicId
