USE Bank
GO

CREATE TABLE Logs
(
	LogId INT IDENTITY
		CONSTRAINT PK__Log_Id
		PRIMARY KEY (LogId),
	AccountId INT NOT NULL
		CONSTRAINT FK__Logs_AccountId__Accounts_Id
		FOREIGN KEY (AccountId) REFERENCES Accounts(Id),
	OldSum DECIMAL(15,2) NOT NULL,
	NewSum DECIMAL(15,2) NOT NULL
)
GO

CREATE TRIGGER tr_AccountsUpdate
ON Accounts FOR UPDATE
AS
BEGIN
	INSERT INTO Logs (AccountId, OldSum, NewSum)
	SELECT new.Id, old.Balance, new.Balance
	FROM inserted AS new
	JOIN deleted AS old
	ON old.Id = new.Id
END
GO

--Alternative solution:
--CREATE TRIGGER tr_Accounts
--ON Accounts AFTER UPDATE
--AS
--BEGIN
--	DECLARE @accountId INT = (SELECT Id FROM inserted)
--	DECLARE @oldSum DECIMAL(15,2) =	(SELECT Balance FROM deleted)
--	DECLARE @newSum DECIMAL(15,2) =	(SELECT Balance FROM inserted)

--	INSERT INTO Logs VALUES (@accountId, @oldSum, @newSum)
--END
--GO

UPDATE Accounts
SET Balance += 1000
WHERE Id = 1
GO

UPDATE Accounts
SET Balance -= 1000
WHERE Id = 1
GO
