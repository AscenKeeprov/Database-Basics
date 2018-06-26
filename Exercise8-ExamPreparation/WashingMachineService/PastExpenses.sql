USE WMS

SELECT
	j.JobId,
	ISNULL(SUM(p.Price * op.Quantity), 0) AS [Total]
FROM Jobs AS j
LEFT JOIN Orders AS o
ON o.JobId = j.JobId
LEFT JOIN OrderParts AS op
ON op.OrderId = o.OrderId
LEFT JOIN Parts AS p
ON p.PartId = op.PartId
WHERE j.[Status] = 'Finished'
GROUP BY j.JobId
ORDER BY Total DESC, j.JobId

--Although, according to the bold text in the problem description,
-- this should be the correct solution:
SELECT
	j.JobId,
	SUM(p.Price * op.Quantity) AS [Total]
FROM Jobs AS j
JOIN Orders AS o
ON o.JobId = j.JobId
JOIN OrderParts AS op
ON op.OrderId = o.OrderId
JOIN Parts AS p
ON p.PartId = op.PartId
WHERE j.[Status] = 'Finished'
GROUP BY j.JobId
ORDER BY Total DESC, j.JobId
