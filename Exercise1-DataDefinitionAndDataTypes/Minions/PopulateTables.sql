INSERT INTO Towns (Id, [Name]) VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions (Id, [Name], Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

INSERT INTO People ([Name], Height, [Weight], Gender, Birthdate) VALUES
('Person1', 1.71, 71, 'm', CONVERT(DATETIME2,'19710701',4)),
('Person2', 1.72, 72, 'f', CONVERT(DATETIME2,'19710702',4)),
('Person3', 1.73, 73, 'm', CONVERT(DATETIME2,'19710703',4)),
('Person4', 1.74, 74, 'f', CONVERT(DATETIME2,'19710704',4)),
('Person5', 1.75, 75, 'm', CONVERT(DATETIME2,'19710705',4))

INSERT INTO Users (Username, [Password], LastLoginTime) VALUES
('User1', HASHBYTES('SHA2_256', 'Pass1'), CONVERT(DATETIME2,'2018-05-26 09:34:17',20)),
('User2', HASHBYTES('SHA2_256', 'Pass2'), NULL),
('User3', HASHBYTES('SHA2_256', 'Pass3'), CONVERT(DATETIME2,'2018-05-26 11:56:39',20)),
('User4', HASHBYTES('SHA2_256', 'Pass4'), NULL),
('User5', HASHBYTES('SHA2_256', 'Pass5'), CONVERT(DATETIME2,'2018-05-26 13:18:01',20))
