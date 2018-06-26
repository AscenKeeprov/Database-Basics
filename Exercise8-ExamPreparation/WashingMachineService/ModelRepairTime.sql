USE WMS

SELECT
	m.ModelId, m.[Name],
	CAST(AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate)) AS VARCHAR(MAX))
	 + ' days' AS [Average Service Time]
FROM Models AS m
JOIN Jobs AS j
ON j.ModelId = m.ModelId
WHERE j.[Status] = 'Finished'
GROUP BY m.ModelId, m.[Name]
ORDER BY AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate))
