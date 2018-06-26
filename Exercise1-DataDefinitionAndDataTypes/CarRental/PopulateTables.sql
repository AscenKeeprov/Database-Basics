INSERT INTO Categories (CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) VALUES
('Exotic', 4, 14.5, 51.33, 7.9),
('Off-Road', 3.1, 13, 49.6, 5.8),
('SUV', 2.45, 11.85, 47, 4.7)

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Condition, Available) VALUES
('TK61368J', 'Subaru', 'Forester', 1997, 3, 4, '20389km', 1),
('SG-8137-AF', 'Porsche', '718 Cayman', 2016, 1, 2, 'Brand new', 1),
('0FFR04D', 'Suzuki', 'Grand Vitara', 2015, 2, 3, 'Rear axle under repair', 0)

INSERT INTO Employees (FirstName, LastName, Title, Notes) VALUES
('FirstName1', 'LastName1', 'Title1', NULL),
('FirstName2', 'LastName2', 'Title2', 'Notes'),
('FirstName3', 'LastName3', 'Title3', NULL)

INSERT INTO Customers (DriverLicenceNumber, FullName, [Address], City, ZIPCode, Notes) VALUES
('RO7315', 'FullName1', 'Address1', 'City1', 'F-4385', NULL),
('MI-39680', 'FullName2', NULL, NULL, NULL, 'Emergency'),
('V-DET-4955', 'FullName3', 'Address3', NULL, '2204', NULL)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, StartDate, EndDate, RateApplied, OrderStatus, Notes) VALUES
(2, 1, 3, 40, 61807, 62594, '2018-03-02 17:12:45', '2018-03-04 14:30:39', 5.8, 'Closed', 'Tax still due!'),
(3, 2, 1, 60, 20389, NULL, '2018-05-21 17:12:45', NULL, 11.85, 'Active', NULL),
(1, 3, 2, 70, 5227, 5227, '2018-04-01 11:11:11', NULL, 7.9, 'Cancel', 'Found a better offer.')
