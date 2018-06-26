USE Bank
GO

CREATE PROCEDURE dbo.usp_DepositMoney
 (@AccountId INT, @MoneyAmount DECIMAL(18,4))
AS
BEGIN
	--BEGIN TRANSACTION [Deposit]

	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id = @AccountId

	--IF (@@ROWCOUNT <> 1)
	--BEGIN
	--	RAISERROR
	--	(
	--		'Error processing transaction. Please try again.',	--Message
	--		16,	--Severity
	--		1	--State.
	--	)
	--	ROLLBACK
	--	RETURN
	--END

	--COMMIT TRANSACTION [Deposit]
END
GO

EXECUTE usp_DepositMoney @AccountId = 1, @MoneyAmount = 10
GO

UPDATE Accounts
SET Balance -= 10
WHERE Id = 1
GO
