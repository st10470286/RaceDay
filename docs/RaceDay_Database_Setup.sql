create database RaceDayDb;

use RaceDayDb;

--Roles Table--
create table Roles(
RoleId Int Identity(1,1) Primary Key,
RoleName Varchar(50) Not Null Unique
);

--Users Table--
create table Users(
UserID Int Identity(1,1) Primary Key,
RoleID int Not Null,
FirstName Varchar(50) Not Null,
LastName Varchar(50) Not Null,
Email Varchar(100) Not Null Unique,
UserPassword Varchar(250) Not Null,
CreatedAt DATETIME Default GetDatE(),
Foreign key (RoleID) References Roles(RoleId)
);

--Events Table--
create table Events(
EventId Int Identity(1,1) Primary Key,
OrganisationId Int Not Null,
Title Varchar(100) Not Null,
EventType Varchar(50) Not Null Check (EventType IN ('Running', 'Walking', 'Cycling')),
Location Varchar(100) Not Null,
EventDate DATETIME NOT NULL,
Description Varchar(100) Not Null,
CreatedAt DATETIME Default GetDate(),
Foreign Key (OrganisationID) References Users(UserId) 
);

--EventCategories Table--
create table EventCategories (
    CategoryId Int Identity(1,1) Primary Key,
    EventId Int Not Null,
    CategoryName Varchar(100) Not Null,
    DistanceKm Decimal(5,2) Not Null CHECK (DistanceKm > 0),
    EntryFee Decimal(10,2) Not Null CHECK (EntryFee >= 0),
    MaxParticipants Int Not Null DEFAULT 500,
    Foreign Key (EventId) References Events(EventId) On DELETE CASCADE
);

--Enrolments Table--
CREATE TABLE EventEnrolments (
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL,
    CategoryId INT NOT NULL,
    EnrolmentDate DATETIME DEFAULT GETDATE(),
    PaymentStatus VARCHAR(20) NOT NULL DEFAULT 'Paid' CHECK (PaymentStatus IN ('Pending', 'Paid', 'Cancelled')),
    CONSTRAINT UQ_Participant_Category UNIQUE (ParticipantId, CategoryId),
    FOREIGN KEY (ParticipantId) REFERENCES Users(UserId),
    FOREIGN KEY (CategoryId) REFERENCES EventCategories(CategoryId) ON DELETE CASCADE
);

--Results Table--
CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL UNIQUE,
    FinishTime VARCHAR(20) NOT NULL,
    OverallPosition INT NOT NULL CHECK (OverallPosition > 0),
    CategoryPosition INT NOT NULL CHECK (CategoryPosition > 0),
    Status VARCHAR(20) NOT NULL DEFAULT 'Finished' CHECK (Status IN ('Finished', 'DNF', 'DNS', 'Disqualified')),
    FOREIGN KEY (EnrolmentId) REFERENCES EventEnrolments(EnrolmentId) ON DELETE CASCADE
);

INSERT INTO Roles (RoleName) VALUES ('Organiser'), ('Participant');

-- Seed Users (2 Organisers, 2 Participants)
INSERT INTO Users (RoleId, FirstName, LastName, Email, UserPassword) VALUES
(1, 'Sibusiso', 'Dlamini', 'organiser1@raceday.co.za', 'AQAAAAEAACcQAAAAEHashedPass1...'),
(1, 'Sarah', 'Van Der Merwe', 'organiser2@raceday.co.za', 'AQAAAAEAACcQAAAAEHashedPass2...'),
(2, 'Thabo', 'Mokoena', 'runner1@gmail.com', 'AQAAAAEAACcQAAAAEHashedPass3...'),
(2, 'Jessica', 'Smith', 'runner2@gmail.com', 'AQAAAAEAACcQAAAAEHashedPass4...');

-- Seed 3 Events
INSERT INTO Events (OrganisationId, Title, EventType, Location, EventDate, Description) VALUES
(1, 'Soweto Marathon 2026', 'Running', 'Soweto, Johannesburg', '2026-11-01 06:00:00', 'The People’s Race taking participants through historic landmarks of Soweto.'),
(1, 'Joburg City Cycling Challenge', 'Cycling', 'Braamfontein, Johannesburg', '2026-10-15 07:00:00', 'Fast-paced street cycling challenge through central Johannesburg.'),
(2, 'Cape Town Coastal Walk', 'Walking', 'Sea Point, Cape Town', '2026-12-05 08:00:00', 'Scenic fun walk along the Atlantic Seaboard promenade.');

-- Seed Categories for Events
INSERT INTO EventCategories (EventId, CategoryName, DistanceKm, EntryFee, MaxParticipants) VALUES
(1, 'Full Marathon', 42.20, 350.00, 5000),
(1, 'Half Marathon', 21.10, 250.00, 8000),
(2, 'Pro Race', 90.00, 450.00, 1500),
(3, '10km Community Walk', 10.00, 120.00, 3000);

-- Seed Sample Enrolments
INSERT INTO EventEnrolments (ParticipantId, CategoryId, PaymentStatus) VALUES
(3, 1, 'Paid'),
(4, 2, 'Paid'),
(3, 4, 'Paid');

-- Seed Sample Results
INSERT INTO Results (EnrolmentId, FinishTime, OverallPosition, CategoryPosition, Status) VALUES
(1, '03:15:42', 142, 38, 'Finished'),
(2, '01:45:10', 85, 12, 'Finished');

--Verification Queries--
SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM EventCategories;
SELECT * FROM EventEnrolments;
SELECT * FROM Results;
SELECT u.UserId, u.FirstName, u.LastName, u.Email, r.RoleName 
FROM Users u 
JOIN Roles r ON u.RoleId = r.RoleId;
