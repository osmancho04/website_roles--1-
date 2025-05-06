CREATE TABLE passengers_tbl (
    passengerID VARCHAR(16) NOT NULL,
    passportNumber VARCHAR(35) NOT NULL,
    passengerFirstName VARCHAR(35) NOT NULL,
    passengerLastName VARCHAR(35),
    email VARCHAR(70) NOT NULL,
    username VARCHAR(35) NOT NULL,
    password VARCHAR(35) NOT NULL,
    
    CONSTRAINT passengerID_pk PRIMARY KEY(passengerID),
    CONSTRAINT passportNumber_fk FOREIGN KEY(passportNumber) REFERENCES passports_tbl(passportNumber)
);

CREATE TABLE passports_tbl (
    passportNumber VARCHAR(35) NOT NULL,
    DOB DATE NOT NULL,
    issueDate DATE NOT NULL,
    expiryDate DATE NOT NULL,
    
    CONSTRAINT passportNumber_pk PRIMARY KEY(passportNumber)
);

CREATE TABLE flights_tbl (
    flightID VARCHAR(16) NOT NULL,
    crewID VARCHAR(16) NOT NULL,
    flightDataID VARCHAR(16) NOT NULL,
    takeOffLocation VARCHAR(3) NOT NULL,
    landingLocation VARCHAR(3) NOT NULL,
    CRSdepTime DATETIME,
    CRSarrTime DATETIME,
    CRSFlightDuration TIME,
    depTime DATETIME,
    arrTime DATETIME,
    ActualDuration TIME,
    
    CONSTRAINT flightID_pk PRIMARY KEY(flightID),
    CONSTRAINT crewID_fk FOREIGN KEY(crewID) REFERENCES crew_tbl(crewID),
    CONSTRAINT flightDataID_fk FOREIGN KEY(flightDataID) REFERENCES flightData_tbl(flightDataID)
);

CREATE TABLE flightData_tbl (
    flightDataID VARCHAR(16) NOT NULL,
    flightDate DATE NOT NULL,
    cancelled BOOL NOT NULL, 
    cancellationCode INT, 
    diverted BOOL NOT NULL,
    originCountry VARCHAR(35) NOT NULL,
    destCountry VARCHAR(35) NOT NULL, 
    taxiOut DATETIME,
    wheelsOff DATETIME,
    depDelay INT,
    depTimeBlk INT, 
    taxiIn DATETIME,
    wheelsOn DATETIME, 
    arrDelay INT,
    arrTimeBlk INT,
    CRSelapsedTime INT,
    elapsedTime INT,
    airTime INT, 
    distance INT NOT NULL, 
    distanceGroup INT NOT NULL, 
    carrierDelay INT, 
    weatherDelay INT, 
    NASDelay INT,
    securityDelay INT,
    lateAircraftDelay INT,
    firstDepTime DATETIME, 
    totalAddGTime INT,
    LongestAddGTime INT,
    divAirportLandings INT,
    divReachedDest BOOL, 
    divActualElapsedTime INT, 
    divArrDelay INT, 
    divDistance INT,
    
    CONSTRAINT flightDataID_pk PRIMARY KEY(flightDataID)
);

CREATE TABLE baggage_tbl (
    baggageID VARCHAR(16) NOT NULL,
    baggageWeight FLOAT(2) DEFAULT 0.00,
    baggageSize ENUM('Carry', 'Small', 'Medium', 'Large'),

    CONSTRAINT baggageID_pk PRIMARY KEY(baggageID)
);

CREATE TABLE crew_tbl (
    crewID VARCHAR(16) NOT NULL,
    crewFirstName VARCHAR(35) NOT NULL,
    crewLastName VARCHAR(35),
    crewRole ENUM('cabin', 'pilot'),

    CONSTRAINT pilotID_pk PRIMARY KEY(crewID)
);

CREATE TABLE tickets_tbl (
    ticketID VARCHAR(16) NOT NULL,
    flightID VARCHAR(16) NOT NULL,
    baggageID VARCHAR(16),
    seat VARCHAR(4),
    gate INT,
    carousel INT,
    flightStatus ENUM('Cancelled', 'Delayed', 'On Time', 'Boarding', 'Boarded', 'Departed'),
    checkInStatus ENUM('24 Hour', 'Baggage', 'Metal', 'Passport', 'Ticket'),
    
    CONSTRAINT ticketID_pk PRIMARY KEY(ticketID),
    CONSTRAINT flightID_fk FOREIGN KEY(flightID) REFERENCES flight_tbl(flightID),
    CONSTRAINT baggageID_fk FOREIGN KEY(baggageID) REFERENCES baggage_tbl(baggageID)
);

CREATE TABLE passengers_lnk_tickets (
	passengerID VARCHAR(16) NOT NULL,
    ticketID VARCHAR(16) NOT NULL,
    
    CONSTRAINT passenger_lnk_tickets_pk PRIMARY KEY(passengerID, ticketID),
    CONSTRAINT passengerID_fk FOREIGN KEY(passengerID) REFERENCES passengers_tbl(passengerID),
    CONSTRAINT ticketID_fk FOREIGN KEY(ticketID) REFERENCES tickets_tbl(ticketID)
);

CREATE TABLE baggage_lnk_ticket (
    baggageID VARCHAR(16) NOT NULL,
	ticketID VARCHAR(16) NOT NULL,
    
    CONSTRAINT baggage_lnk_ticket_pk PRIMARY KEY(baggageID, ticketID),
    CONSTRAINT baggageID_fk FOREIGN KEY(ticketID) REFERENCES tickets_tbl(ticketID),
    CONSTRAINT ticketID_fk FOREIGN KEY(ticketID) REFERENCES tickets_tbl(ticketID),
    
);

CREATE TABLE crew_lnk_flights (
	crewID VARCHAR(16) NOT NULL,
	flightID VARCHAR(16) NOT NULL,
    
    CONSTRAINT crew_lnk_flights_pk PRIMARY KEY(passengerID, ticketID),
    CONSTRAINT crewID_fk FOREIGN KEY(crewID) REFERENCES crew_tbl(crewID),
    CONSTRAINT flightID_fk FOREIGN KEY(flightID) REFERENCES flights_tbl(flightID)
);