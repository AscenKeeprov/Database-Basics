USE WMS

SELECT
	pn.PartId,
	p.[Description],
	SUM(pn.Quantity) AS [Required],
	SUM(p.StockQty) AS [In Stock],
	ISNULL(SUM(op.Quantity), 0) AS [Ordered]
FROM Jobs AS j
JOIN PartsNeeded AS pn
ON pn.JobId = j.JobId
JOIN Parts AS p
ON p.PartId = pn.PartId
LEFT JOIN Orders AS o
ON o.JobId = pn.JobId
LEFT JOIN OrderParts AS op
ON op.OrderId = o.OrderId
WHERE j.[Status] <> 'Finished'
GROUP BY pn.PartId, p.[Description], pn.Quantity, p.StockQty, op.Quantity
HAVING SUM(p.StockQty) + ISNULL(SUM(op.Quantity), 0) < SUM(pn.Quantity)
ORDER BY PartId

--Alternative solution:
WITH CTE_PartsRequired AS
(
	SELECT
		pn.PartId,
		p.[Description],
		SUM(pn.Quantity) AS [Required],
		SUM(p.StockQty) AS [In Stock]
	FROM PartsNeeded AS pn
	JOIN Parts AS p
	ON p.PartId = pn.PartId
	WHERE pn.JobId IN
	(
		SELECT JobId
		FROM Jobs
		WHERE [Status] <> 'Finished'
	)
	GROUP BY pn.PartId, p.[Description], pn.Quantity, p.StockQty
)
,

CTE_PartsOrdered AS
(
	SELECT
		op.PartId,
		SUM(op.Quantity) AS [Ordered]
	FROM Orders AS o
	JOIN OrderParts AS op
	ON op.OrderId = o.OrderId
	WHERE o.JobId IN
	(
		SELECT JobId
		FROM Jobs
		WHERE [Status] <> 'Finished'
	)
	GROUP BY op.PartId
)

SELECT
	pr.PartId,
	pr.[Description],
	pr.[Required],
	pr.[In Stock],
	ISNULL(po.Ordered, 0) AS [Ordered]
FROM CTE_PartsRequired AS pr
LEFT JOIN CTE_PartsOrdered AS po
ON po.PartId = pr.PartId
WHERE pr.[In Stock] + ISNULL(po.Ordered, 0) < pr.[Required]
ORDER BY pr.PartId
