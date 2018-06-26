USE Bank
GO

CREATE TABLE NotificationEmails
(
	Id INT IDENTITY
		CONSTRAINT PK__Email_Id
		PRIMARY KEY (Id),
	Recipient INT NOT NULL
		CONSTRAINT FK__Emails_Recipient__Logs_AccountId
		FOREIGN KEY (Recipient) REFERENCES Accounts(Id),
	[Subject] VARCHAR(42) NOT NULL,
	Body VARCHAR(108)
)
GO

CREATE TRIGGER tr_LogsInsert ON Logs
FOR INSERT AS
BEGIN
	INSERT INTO NotificationEmails (Recipient, [Subject], Body)
	SELECT
		AccountId,
		'Balance change for account: ' + CAST(AccountId AS VARCHAR(26)),
		'On ' + CAST(GETDATE() AS VARCHAR(19)) 
		+ ' your balance was changed from ' + CAST(OldSum AS VARCHAR(18)) 
		+ ' to ' + CAST(NewSum AS VARCHAR(18))'.'
	FROM inserted
END
GO

UPDATE Accounts
SET Balance += 2000
WHERE Id = 1
GO

UPDATE Accounts
SET Balance -= 2000
WHERE Id = 1
GO
