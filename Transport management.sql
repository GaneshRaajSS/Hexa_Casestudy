CREATE DATABASE TransportManagement

use TransportManagement

CREATE TABLE Vehicles(
VehicleID INT PRIMARY KEY IDENTITY(1,1),
Model VARCHAR(255), 
Capacity DECIMAL(10,2),
Type VARCHAR(50),
Status VARCHAR(50)
)

CREATE TABLE Routes(
RouteID INT PRIMARY KEY IDENTITY(100,1),
StartDestination VARCHAR(255),
EndDestination VARCHAR(255),
Distance DECIMAL(10,2)
)

CREATE TABLE Trips(
TripID INT PRIMARY KEY IDENTITY(200,1),
VehicleID INT FOREIGN KEY (VehicleID) 
REFERENCES Vehicles(VehicleID) ON DELETE CASCADE,
RouteID INT FOREIGN KEY (RouteID) 
REFERENCES Routes(RouteID) ON DELETE CASCADE,
DepartureDate DATETIME,
Arrival DATETIME,
Status VARCHAR(50),
TripType VARCHAR(50) DEFAULT 'Freight',
MaxPassengers INT
)

CREATE TABLE Passengers(
PassengerID INT PRIMARY KEY IDENTITY(300,1),
FirstName VARCHAR(255),
Gender VARCHAR(255),
age INT,
Email VARCHAR(255) UNIQUE,
PhoneNumber VARCHAR(50)
)

CREATE TABLE Bookings(
BookingID INT PRIMARY KEY IDENTITY(400,1),
TripID INT FOREIGN KEY (TripID) 
REFERENCES Trips(TripID) ON DELETE CASCADE,
PassengerID INT FOREIGN KEY (PassengerID) 
REFERENCES Passengers(PassengerID) ON DELETE CASCADE,
BookingDate DATETIME,
Status VARCHAR(50)
)

INSERT INTO Vehicles VALUES('Toyota Camry', 5.0, 'Car', 'On Trip'),
('Ford F-150', 50.0, 'Truck', 'Available'),
('BMW X5', 7.0, 'Car', 'Maintenance'),
('Force Traveller 3050', 70.0, 'Van', 'Available')

SELECT * FROM Vehicles

INSERT INTO Routes VALUES ('Chennai', 'Salem', 340.00),
('Coimbatore', 'Tiruchirappalli', 210.00),
('Madurai', 'Erode', 260.00),
('Chennai', 'Kanyakumari', 705.8)

SELECT * FROM Routes

INSERT INTO Trips VALUES (1, 100, '2024-05-06 07:00:00', '2024-05-06 11:30:00', 'In Progress', 'Passenger', 4),
(2, 101, '2023-04-27 11:00:00', '2023-04-27 20:00:00', 'Scheduled', 'Freight', 8),
(3, 102, '2023-03-02 10:00:00', '2023-03-02 15:00:00', 'Cancelled', 'Passenger', 5),
(4, 103, '2024-10-01 21:00:00', '2024-10-01 07:45:00', 'Completed', 'Passenger', 24)

SELECT * FROM Trips

INSERT INTO Passengers VALUES ('Ganesh', 'Male', 22, 'ganesh@example.com', '1234567000'),
('Raaj', 'Male',30, 'raaj@example.com', '9876543210'),
('Raha', 'Male', 27, 'raha@example.com', '6372854639'),
('Vidhya', 'Female', 27, 'vidhya@example.com', '1235840663')

SELECT * FROM Passengers

INSERT INTO Bookings VALUES (200, 300, '2024-04-20 10:00:00', 'Confirmed'),
(201, 301, '2023-04-01 20:00:00', 'Completed'),
(202, 302, '2023-02-21 15:00:00', 'Cancelled'),
(203, 303,'2024-09-11 07:45:00', 'Completed')

SELECT * FROM Bookings


ALTER TABLE Bookings
ADD CONSTRAINT check_status CHECK(Status IN('Confirmed', 'Cancelled', 'Completed'))

ALTER TABLE Trips
ADD CONSTRAINT check_trip CHECK(Status IN('Scheduled', 'In Progress', 'Cancelled', 'Completed'))

--To Verify Check Constraint

INSERT INTO Trips VALUES (4, 104, '2024-05-06 07:00:00', '2024-05-06 11:30:00', 'Confirmed', 'Passenger', 4)

INSERT INTO Bookings VALUES (204, 304, '2024-04-20 10:00:00', 'Scheduled')
