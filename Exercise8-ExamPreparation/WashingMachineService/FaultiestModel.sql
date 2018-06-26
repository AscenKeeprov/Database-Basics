USE WMS

WITH CTE_ModelsJobs AS
(
SELECT
	m.ModelId,
	m.[Name] AS [Model],
	COUNT(j.JobId) AS [JobsCount]
FROM Models AS m
JOIN Jobs AS j
ON j.ModelId = m.ModelId
GROUP BY m.ModelId, m.[Name]
)

SELECT
	mj.Model,
	mj.JobsCount AS [TimesServiced],
	ISNULL(SUM(p.Price * op.Quantity), 0) AS [Parts Total]
FROM CTE_ModelsJobs AS mj
JOIN Jobs AS j
ON j.ModelId = mj.ModelId
LEFT JOIN Orders AS o
ON o.JobId = j.JobId
LEFT JOIN OrderParts AS op
ON op.OrderId = o.OrderId
LEFT JOIN Parts AS p
ON p.PartId = op.PartId
WHERE mj.JobsCount = 
(
	SELECT MAX(JobsCount)
	FROM CTE_ModelsJobs
)
GROUP BY mj.Model, mj.JobsCount

--Alternative solution
SELECT TOP(1) WITH TIES
	m.[Name] AS [Model],
	COUNT(j.JobId) AS [Times Serviced],
	(
		SELECT ISNULL(SUM(p.Price * op.Quantity), 0)
		FROM Jobs AS j
		JOIN Orders AS o
		ON o.JobId = j.JobId
		JOIN OrderParts AS op
		ON op.OrderId = o.OrderId
		JOIN Parts AS p
		ON p.PartId = op.PartId
		WHERE j.ModelId = m.ModelId
	) AS [Parts Total]
FROM Models AS m
JOIN Jobs AS j
ON j.ModelId = m.ModelId
GROUP BY m.[Name], m.ModelId
ORDER BY [Times Serviced] DESC
