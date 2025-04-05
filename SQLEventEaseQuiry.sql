USE MASTER
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'EventEase')
DROP DATABASE EventEase
CREATE DATABASE EventEase
GO


USE EventEase;
GO


IF OBJECT_ID('Booking', 'U') IS NOT NULL DROP TABLE Booking;
IF OBJECT_ID('Event', 'U') IS NOT NULL DROP TABLE Event;
IF OBJECT_ID('Venue', 'U') IS NOT NULL DROP TABLE Venue;
GO

CREATE TABLE Venue (
    VenueId INT IDENTITY(1,1) PRIMARY KEY, 
    VenueName NVARCHAR(255) NOT NULL,       
    Location NVARCHAR(500) NOT NULL,        
    Capacity INT NOT NULL,                 
    ImageUrl NVARCHAR(500)                  
);
GO

CREATE TABLE Event (
    EventId INT IDENTITY(1,1) PRIMARY KEY, 
    EventName NVARCHAR(255) NOT NULL,       
    EventDate DATETIME NOT NULL,            
    Description NVARCHAR(500),              
    VenueId INT NOT NULL,                   
    FOREIGN KEY (VenueId) REFERENCES Venue(VenueId) ON DELETE CASCADE
);
GO

CREATE TABLE Booking (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,  
    EventId INT NOT NULL,                     
    VenueId INT NOT NULL,                     
    BookingDate DATETIME NOT NULL,            

    
    FOREIGN KEY (EventId) REFERENCES Event(EventId) ON DELETE CASCADE,

   
    FOREIGN KEY (VenueId) REFERENCES Venue(VenueId) ON DELETE NO ACTION
);
GO


INSERT INTO Venue (VenueName, Location, Capacity, ImageUrl) 
VALUES ('Zanzou', 'Hartfield', 500, 'https://zanzou.co.za/'),
       ('Drama', 'Braamfontein', 1000, 'https://southafrica.tortoisepath.com/wp-content/uploads/2023/10/Drama-Bar-Lounge-Johannesburg-South-Africa-TortoisePathcom-1-jpeg.webp');
GO

INSERT INTO Event (EventName, EventDate, Description, VenueId) 
VALUES ('Ladies Love Zanzou', '2025-04-27 18:00:00', 'Semester Party', 1),
       ('Pizza Sundays', '2025-07-20 18:00:00', 'Student Nights', 2);
GO

INSERT INTO Booking (EventId, VenueId, BookingDate) 
VALUES (1, 1, '2025-03-01 12:00:00'),
       (2, 2, '2025-06-10 14:00:00');
GO

SELECT * FROM Venue;

SELECT e.EventId, e.EventName, e.EventDate, v.VenueName 
FROM Event e 
JOIN Venue v ON e.VenueId = v.VenueId;

SELECT b.BookingId, e.EventName, v.VenueName, b.BookingDate
FROM Booking b
JOIN Event e ON b.EventId = e.EventId
JOIN Venue v ON b.VenueId = v.VenueId;

DROP TABLE IF EXISTS Booking;
GO