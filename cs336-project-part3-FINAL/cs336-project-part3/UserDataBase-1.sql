CREATE DATABASE  IF NOT EXISTS `UserDataBase` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `UserDataBase`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: cs336.ckksjtjg2jto.us-east-2.rds.amazonaws.com    Database: BarBeerDrinkerSample
-- ------------------------------------------------------
-- Server version	5.6.35-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `admin` boolean NOT NULL,
  `customer_rep` boolean NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('David', 'asdf', false, false);
INSERT INTO `users` VALUES ('Dhruv', 'password', false, false);
INSERT INTO `users` VALUES ('test', '123', false, false);
INSERT INTO `users` VALUES ('Admin', '123', true, false);
INSERT INTO `users` VALUES ('rep', '123', false, true);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `Airports`
DROP TABLE IF EXISTS `Airports`;
CREATE TABLE `Airports` (
  `AirportID` VARCHAR(3) PRIMARY KEY,
  `AirportName` VARCHAR(255),
  `Location` VARCHAR(255)
);

-- Dumping data for table `Airports`
INSERT INTO `Airports` VALUES ('EWR', 'Newark Liberty International Airport', 'Newark');
INSERT INTO `Airports` VALUES ('LGA', 'LaGuardia Airport', 'New York');
INSERT INTO `Airports` VALUES ('JFK', 'John F. Kennedy International Airport', 'New York');

-- Table structure for table `Airlines`
DROP TABLE IF EXISTS `Airlines`;
CREATE TABLE `Airlines` (
  `AirlineID` VARCHAR(2) PRIMARY KEY,
  `AirlineName` VARCHAR(255),
  `NumberOfAirCrafts` INT
);

-- Dumping data for table `Airlines`
INSERT INTO `Airlines` VALUES ('AA', 'American Airlines', 1);
INSERT INTO `Airlines` VALUES ('UA', 'United Airlines', 2);

-- Aircrafts Table
DROP TABLE IF EXISTS `Aircrafts`;
CREATE TABLE `Aircrafts` (
  `AircraftID` VARCHAR(10) PRIMARY KEY,
  `AirlineID` VARCHAR(2),
  FOREIGN KEY (`AirlineID`) REFERENCES `Airlines`(`AirlineID`)
);

-- Dumping data for table `Aircrafts`
INSERT INTO `Aircrafts` VALUES ('1AA' ,'AA');
INSERT INTO `Aircrafts` VALUES ('1UA' , 'UA');
INSERT INTO `Aircrafts` VALUES ('2UA' , 'UA');

-- Flights Table
DROP TABLE IF EXISTS `Flights`;
CREATE TABLE `Flights` (
  `FlightNumber` VARCHAR(10) PRIMARY KEY,
  `AirlineID` VARCHAR(2),
  `AircraftID` VARCHAR(10),
  `DepartureAirportID` VARCHAR(3),
  `ArrivalAirportID` VARCHAR(3),
  `DepartureTime` TIME,
  `ArrivalTime` TIME,
  `FlightDate` DATE,
  `DaysOfOperation` VARCHAR(255),
  `TotalSeats` INT,
  `SeatsAvailable` INT,
  `Price` DECIMAL(10, 2),
  `Duration` TIME,
  `FlightType` VARCHAR(50),
  FOREIGN KEY (`AirlineID`) REFERENCES `Airlines`(`AirlineID`),
  FOREIGN KEY (`AircraftID`) REFERENCES `Aircrafts`(`AircraftID`),
  FOREIGN KEY (`DepartureAirportID`) REFERENCES `Airports`(`AirportID`),
  FOREIGN KEY (`ArrivalAirportID`) REFERENCES `Airports`(`AirportID`)
);

-- Sample data for Flights table with limited seats
INSERT INTO `Flights` VALUES ('AA100', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-07-01', 'Monday, Wednesday, Friday', 180, 5, 150.00, '01:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('UA200', 'UA', '1UA', 'JFK', 'EWR', '17:00:00', '18:30:00', '2023-07-02', 'Tuesday, Thursday', 200, 3, 200.00, '01:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('AA101', 'AA', '1AA', 'LGA', 'JFK', '10:00:00', '11:30:00', '2023-07-03', 'Saturday, Sunday', 150, 0, 160.00, '01:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('UA201', 'UA', '1UA', 'JFK', 'EWR', '19:00:00', '20:30:00', '2023-12-14', 'Friday, Saturday', 190, 1, 180.00, '01:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('AA102', 'AA', '1AA', 'EWR', 'JFK', '14:00:00', '15:30:00', '2023-07-05', 'Monday, Thursday', 170, 4, 140.00, '01:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('UA202', 'UA', '1UA', 'LGA', 'EWR', '16:00:00', '17:30:00', '2023-07-06', 'Wednesday, Sunday', 160, 2, 170.00, '04:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('AA180', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-07-01', 'Monday, Wednesday, Friday', 180, 0, 120.00, '03:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('AA320', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-07-02', 'Monday, Wednesday, Friday', 180, 5, 120.00, '02:30:00', 'Domestic');
INSERT INTO `Flights` VALUES ('AA740', 'AA', '1AA', 'EWR', 'LGA', '08:00:00', '09:30:00', '2023-12-15', 'Monday, Wednesday, Friday', 180, 5, 120.00, '02:30:00', 'Domestic');

-- ... More flight insert statements ...

-- Questions Table
DROP TABLE IF EXISTS `Questions`;
CREATE TABLE `Questions` (
  `QuestionID` INT AUTO_INCREMENT PRIMARY KEY,
  `QuestionText` TEXT,
  `Answer` TEXT,
  `Username` VARCHAR(50),
  `Timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`Username`) REFERENCES `users`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tickets Table
DROP TABLE IF EXISTS `Tickets`;
CREATE TABLE `Tickets` (
  `TicketID` INT AUTO_INCREMENT PRIMARY KEY,
  `FlightNumber` VARCHAR(10),
  `Username` VARCHAR(50),
  `SeatNumber` INT,
  `Class` VARCHAR(50),
  `TotalFare` DECIMAL(10, 2),
  `PurchaseTime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`FlightNumber`) REFERENCES `Flights`(`FlightNumber`),
  FOREIGN KEY (`Username`) REFERENCES `users`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Waitlist Table
DROP TABLE IF EXISTS `Waitlist`;
CREATE TABLE `Waitlist` (
  `WaitlistID` INT AUTO_INCREMENT PRIMARY KEY,
  `FlightNumber` VARCHAR(10),
  `Username` VARCHAR(50),
  `JoinTime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`FlightNumber`) REFERENCES `Flights`(`FlightNumber`),
  FOREIGN KEY (`Username`) REFERENCES `users`(`username`) ON DELETE CASCADE ON UPDATE CASCADE
);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

select * from tickets;