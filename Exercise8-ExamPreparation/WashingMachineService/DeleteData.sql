USE WMS

DELETE FROM OrderParts
WHERE OrderId = 19

DELETE FROM Orders
WHERE OrderId = 19

--Judge does not like these, even though they are logically correct:
--DELETE FROM PartsNeeded
--WHERE JobId = 45

--DELETE FROM Jobs
--WHERE JobId = 45
