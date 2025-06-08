-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (arm64)
--
-- Host: localhost    Database: travelreservationsys
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aircrafts`
--

DROP TABLE IF EXISTS `aircrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircrafts` (
  `aircraft_id` varchar(10) NOT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircrafts`
--

LOCK TABLES `aircrafts` WRITE;
/*!40000 ALTER TABLE `aircrafts` DISABLE KEYS */;
INSERT INTO `aircrafts` VALUES ('9TJ7XK',162),('AZ1F6W',219),('B3J1QK',133),('D2L8RZ',156),('DZ6BQA',178),('K0N9PE',75),('L5XZQ1',396),('M3V0NB',186),('QR7L2D',500),('T9V6XZ',124),('U3N7GM',156),('W8CY3T',76),('WR4567',88),('YU6XPR',220);
/*!40000 ALTER TABLE `aircrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airlines`
--

DROP TABLE IF EXISTS `airlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airlines` (
  `airline_id` char(2) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airlines`
--

LOCK TABLES `airlines` WRITE;
/*!40000 ALTER TABLE `airlines` DISABLE KEYS */;
INSERT INTO `airlines` VALUES ('AA','American Airlines'),('AC','Air Canada'),('AF','Air France'),('AI','Air India'),('AS','Alaska Airlines'),('B6','JetBlue Airways'),('BA','British Airways'),('DL','Delta Air Lines'),('EK','Emirates'),('F9','Frontier Airlines'),('LH','Lufthansa'),('NK','Spirit Airlines'),('QR','Qatar Airways'),('SW','Southwest Airlines'),('UA','United Airlines');
/*!40000 ALTER TABLE `airlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `airport_id` char(3) NOT NULL,
  `name` varchar(70) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES ('ALH','Albany Airport','Albany','Australia'),('ATH','Athens International Airport','Athens','Greece'),('ATL','Hartsfield-Jackson Atlanta International Airport','Atlanta','United States'),('BOM','Chhatrapati Shivaji Maharaj International Airport','Mumbai','India'),('CDG','Charles de Gaulle Airport','Paris','France'),('DEL','Indira Gandhi International Airport','Delhi','India'),('DFW','Dallas/Fort Worth International Airport','Dallas/Fort Worth','United States'),('DXB','Dubai International Airport','Dubai','United Arab Emirates'),('EWR','Newark Liberty International Airport','Newark','United States'),('FRA','Frankfurt Airport','Frankfurt','Germany'),('JFK','John F. Kennedy International Airport','New York','United States'),('LAX','Los Angeles International Airport','Los Angeles','United States'),('LGA','LaGuardia Airport','New York','United States'),('LHR','London Heathrow Airport','London','United Kingdom'),('MIA','Miami International Airport','Miami','United States'),('NAS','Lynden Pindling International Airport','Nassau','Bahamas'),('ORD','O\'Hare International Airport','Chicago','United States'),('PEK','Beijing Capital International Airport','Beijing','China'),('SEA','Seattle-Tacoma International Airport','Seattle','United States'),('SFO','San Francisco International Airport','San Francisco','United States');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `user_id` int NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Nihali','Patel'),(2,'Sarah','Adams'),(3,'Billy','Joel'),(4,'Bob','Williams'),(5,'Peter','Parker'),(6,'Sneha','Augustine');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(6) DEFAULT NULL,
  `airline_id` char(2) DEFAULT NULL,
  `aircraft_id` varchar(10) DEFAULT NULL,
  `dep_airport` char(3) DEFAULT NULL,
  `arr_airport` char(3) DEFAULT NULL,
  `dep_time` time DEFAULT NULL,
  `arr_time` time DEFAULT NULL,
  `days_of_week` varchar(30) DEFAULT NULL,
  `isInternational` tinyint(1) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `num_stops` int DEFAULT '0',
  PRIMARY KEY (`flight_id`),
  KEY `airline_id` (`airline_id`),
  KEY `aircraft_id` (`aircraft_id`),
  KEY `dep_airport` (`dep_airport`),
  KEY `arr_airport` (`arr_airport`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'102','AA','9TJ7XK','ALH','EWR','10:30:00','16:15:00','mon,thurs',1,250.00,0),(2,'546','F9','DZ6BQA','DEL','BOM','09:00:00','15:30:00','tues,thurs,sun',0,250.00,0),(3,'898','UA','L5XZQ1','DXB','DEL','08:00:00','23:00:00','wed,fri',1,250.00,0),(4,'796','SW','U3N7GM','MIA','DXB','13:30:00','20:00:00','mon,sat',1,250.00,0),(5,'231','AI','YU6XPR','ORD','LGA','15:30:00','16:32:00','mon,wed,sat',0,250.00,0),(6,'102','AC','T9V6XZ','SFO','MIA','23:00:00','10:30:00','fri,tues',0,250.00,0),(7,'059','AF','9TJ7XK','EWR','SEA','20:45:00','09:00:00','thurs,tues',0,250.00,0),(8,'982','AI','M3V0NB','FRA','SFO','13:15:00','01:15:00','mon,wed,fri',1,250.00,0),(9,'654','BA','AZ1F6W','LAX','BOM','07:25:00','17:30:00','sat',1,250.00,0),(10,'111','DL','B3J1QK','NAS','JFK','09:00:00','17:00:00','sun,fri',1,250.00,0),(11,'032','EK','QR7L2D','PEK','CDG','16:32:00','23:59:00','mon,wed',1,250.00,0);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `question_text` text,
  `answer_text` text,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'demoUser','How many bags can I check in?','Most airlines allow 1 checked bag and 1 carry-on.'),(2,'demoUser','Can I change an economy class ticket?','Yes, with a fee.'),(3,'demoUser','Are meals included?','Yes, for long-haul flights.'),(4,'demoUser','How early should I arrive at the airport?','At least 2 hours before domestic flights.');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_flights`
--

DROP TABLE IF EXISTS `ticket_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_flights` (
  `ticket_id` varchar(20) NOT NULL,
  `flight_id` int DEFAULT NULL,
  `sequence_num` int NOT NULL,
  `seat_num` int DEFAULT NULL,
  PRIMARY KEY (`ticket_id`,`sequence_num`),
  KEY `flight_id` (`flight_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_flights`
--

LOCK TABLES `ticket_flights` WRITE;
/*!40000 ALTER TABLE `ticket_flights` DISABLE KEYS */;
INSERT INTO `ticket_flights` VALUES ('T1749393822794',1,1,NULL),('T1749394734567',2,1,NULL),('T1749399265068',5,1,NULL),('T1749402155401',7,1,NULL),('T1749411744442',2,1,2);
/*!40000 ALTER TABLE `ticket_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `ticket_id` varchar(20) NOT NULL,
  `user_id` int DEFAULT NULL,
  `class` enum('economy','business','first') DEFAULT NULL,
  `total_fare` decimal(10,2) DEFAULT NULL,
  `booking_fee` decimal(10,2) DEFAULT NULL,
  `purchase_datetime` datetime DEFAULT NULL,
  `is_cancelled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES ('T1749393822794',1,'economy',200.00,20.00,'2025-06-08 10:43:42',0),('T1749394734567',1,'economy',250.00,20.00,'2025-06-08 10:58:54',0),('T1749399265068',1,'economy',250.00,20.00,'2025-06-08 12:14:25',0),('T1749402155401',1,'first',620.00,20.00,'2025-06-08 13:02:35',1),('T1749411667300',2,'economy',270.00,20.00,'2025-06-08 15:41:07',0),('T1749411744442',2,'economy',270.00,20.00,'2025-06-08 15:42:24',0);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `role` enum('customer','rep','admin') NOT NULL DEFAULT 'customer',
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `user_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('customer','nihalipatel','qwe123',1),('customer','sarahadams','smile23',2),('customer','billyjoel','music54',3),('customer','bob99','abc123',4),('customer','peterparker','spiderman616',5),('customer','snehaaugustine','hearts100',6),('admin','billgates','apple123',7),('rep','rep1','rep123',9);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waitlist` (
  `waitlist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `flight_number` varchar(10) DEFAULT NULL,
  `request_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`waitlist_id`),
  UNIQUE KEY `user_id` (`user_id`,`flight_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
INSERT INTO `waitlist` VALUES (1,1,'102','2025-05-11 17:44:39'),(2,2,'546','2025-05-11 17:44:39'),(3,3,'796','2025-05-11 17:44:39');
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-08 17:28:28
