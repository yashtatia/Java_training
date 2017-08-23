-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.19-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table sap_flight_v1_0.flt_airport
CREATE TABLE IF NOT EXISTS `flt_airport` (
  `airport_id` varchar(5) NOT NULL,
  `airport_name` varchar(200) NOT NULL,
  PRIMARY KEY (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table sap_flight_v1_0.flt_airport: ~15 rows (approximately)
/*!40000 ALTER TABLE `flt_airport` DISABLE KEYS */;
INSERT INTO `flt_airport` (`airport_id`, `airport_name`) VALUES
	('AGR', 'Agra'),
	('AMD', 'Ahmedabad'),
	('BHO', 'Bhopal'),
	('BLR', 'Bangalore'),
	('BOK', 'Bangkok'),
	('BOM', 'Mumbai'),
	('CJB', 'Coimbatore'),
	('COK', 'Cochin'),
	('DEL', 'Delhi'),
	('DUB', 'Dubai'),
	('GAU', 'Guwahati'),
	('GOI', 'Goa'),
	('HYD', 'Hyderabad'),
	('IXZ', 'Port Blair'),
	('PBD', 'Porbandar');
/*!40000 ALTER TABLE `flt_airport` ENABLE KEYS */;

-- Dumping structure for table sap_flight_v1_0.flt_booking
CREATE TABLE IF NOT EXISTS `flt_booking` (
  `booking_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `flight_id` int(10) unsigned NOT NULL,
  `class` enum('eco','bus','elt') NOT NULL,
  `seats` int(11) NOT NULL,
  `miles_used` int(11) DEFAULT NULL,
  `cc_number` varchar(100) DEFAULT NULL,
  `cc_expiry` varchar(100) DEFAULT NULL,
  `cc_cvv` varchar(10) DEFAULT NULL,
  `total_amount` float NOT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `FK_flt_booking_flt_users` (`user_id`),
  KEY `FK_flt_booking_flt_flight` (`flight_id`),
  CONSTRAINT `FK_flt_booking_flt_flight` FOREIGN KEY (`flight_id`) REFERENCES `flt_flight` (`flight_id`),
  CONSTRAINT `FK_flt_booking_flt_users` FOREIGN KEY (`user_id`) REFERENCES `flt_users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- Dumping data for table sap_flight_v1_0.flt_booking: ~34 rows (approximately)
/*!40000 ALTER TABLE `flt_booking` DISABLE KEYS */;
INSERT INTO `flt_booking` (`booking_id`, `user_id`, `flight_id`, `class`, `seats`, `miles_used`, `cc_number`, `cc_expiry`, `cc_cvv`, `total_amount`) VALUES
	(16, 6, 3, 'eco', 1, 500, NULL, NULL, NULL, 250),
	(17, 6, 2, 'eco', 1, 780, NULL, NULL, NULL, 110),
	(18, 5, 2, 'eco', 2, -780, NULL, NULL, NULL, 1390),
	(19, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(20, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(21, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(22, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(23, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(24, 6, 1, 'eco', 1, NULL, NULL, NULL, NULL, 798),
	(25, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(26, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(27, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(28, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(29, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(30, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(31, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(32, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(33, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(34, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(35, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(36, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(37, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(38, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(39, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(40, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(41, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(42, 6, 2, 'bus', 1, 0, NULL, NULL, NULL, 780),
	(43, 6, 3, 'eco', 1, 780, NULL, NULL, NULL, 110),
	(44, 6, 3, 'eco', 1, 1000, NULL, NULL, NULL, 0),
	(45, 6, 3, 'eco', 1, 0, NULL, NULL, NULL, 500),
	(46, 7, 5, 'eco', 1, 400, NULL, NULL, NULL, 0),
	(48, 11, 6, 'eco', 1, 0, NULL, NULL, NULL, 230),
	(49, 11, 6, 'eco', 1, 0, '123123', '123123', '123', 230),
	(50, 11, 6, 'eco', 1, 100, '17284712981', '8877', '321', 180);
/*!40000 ALTER TABLE `flt_booking` ENABLE KEYS */;

-- Dumping structure for table sap_flight_v1_0.flt_booking_passenger
CREATE TABLE IF NOT EXISTS `flt_booking_passenger` (
  `booking_id` int(10) unsigned NOT NULL,
  `passenger_name` varchar(50) NOT NULL,
  KEY `FK_flt_booking_passenger_flt_booking` (`booking_id`),
  CONSTRAINT `FK_flt_booking_passenger_flt_booking` FOREIGN KEY (`booking_id`) REFERENCES `flt_booking` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table sap_flight_v1_0.flt_booking_passenger: ~0 rows (approximately)
/*!40000 ALTER TABLE `flt_booking_passenger` DISABLE KEYS */;
/*!40000 ALTER TABLE `flt_booking_passenger` ENABLE KEYS */;

-- Dumping structure for table sap_flight_v1_0.flt_carrier
CREATE TABLE IF NOT EXISTS `flt_carrier` (
  `carrier_id` varchar(5) NOT NULL,
  `carrier_name` varchar(100) NOT NULL,
  `flight_type` varchar(5) NOT NULL,
  `total_seats_eco` int(10) unsigned NOT NULL,
  `total_seats_bus` int(10) unsigned NOT NULL,
  `total_seats_elt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`carrier_id`,`flight_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table sap_flight_v1_0.flt_carrier: ~7 rows (approximately)
/*!40000 ALTER TABLE `flt_carrier` DISABLE KEYS */;
INSERT INTO `flt_carrier` (`carrier_id`, `carrier_name`, `flight_type`, `total_seats_eco`, `total_seats_bus`, `total_seats_elt`) VALUES
	('AAS', 'AirAsia', 'md', 200, 80, 30),
	('AID', 'AirIndia', 'md', 180, 50, 20),
	('IND', 'Indigo', 'md', 200, 80, 30),
	('IND', 'Indigo', 'sm', 180, 50, 20),
	('QTR', 'QatarAirlines', 'md', 200, 80, 30),
	('SPJ', 'SpiceJet', 'lg', 300, 200, 100),
	('VST', 'Vistara', 'md', 200, 80, 30);
/*!40000 ALTER TABLE `flt_carrier` ENABLE KEYS */;

-- Dumping structure for table sap_flight_v1_0.flt_flight
CREATE TABLE IF NOT EXISTS `flt_flight` (
  `flight_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrier_id` varchar(5) NOT NULL,
  `flight_type` varchar(5) NOT NULL,
  `route_id` int(10) unsigned DEFAULT NULL,
  `flight_date` date NOT NULL,
  `flight_time` time(6) NOT NULL,
  `vacancy_eco` int(11) NOT NULL,
  `vacancy_bus` int(11) NOT NULL,
  `vacancy_elt` int(11) NOT NULL,
  `price_eco` int(11) NOT NULL,
  `price_bus` int(11) NOT NULL,
  `price_elt` int(11) NOT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `fk_carr_id_flt_carrier_idx` (`carrier_id`),
  KEY `fk_route_id_flt_route_idx` (`route_id`),
  KEY `FK_flt_flight_flt_carrier` (`flight_type`),
  KEY `FK_flt_flight_flt_carrier_1` (`carrier_id`,`flight_type`),
  CONSTRAINT `FK_flt_flight_flt_carrier_1` FOREIGN KEY (`carrier_id`, `flight_type`) REFERENCES `flt_carrier` (`carrier_id`, `flight_type`),
  CONSTRAINT `fk_route_id_flt_route` FOREIGN KEY (`route_id`) REFERENCES `flt_route` (`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- Dumping data for table sap_flight_v1_0.flt_flight: ~17 rows (approximately)
/*!40000 ALTER TABLE `flt_flight` DISABLE KEYS */;
INSERT INTO `flt_flight` (`flight_id`, `carrier_id`, `flight_type`, `route_id`, `flight_date`, `flight_time`, `vacancy_eco`, `vacancy_bus`, `vacancy_elt`, `price_eco`, `price_bus`, `price_elt`) VALUES
	(1, 'IND', 'sm', 2, '2017-08-13', '16:30:34.000000', 180, 50, 20, 500, 780, 1000),
	(2, 'IND', 'md', 4, '2017-08-13', '16:35:27.000000', 0, 47, 30, 500, 780, 1000),
	(3, 'IND', 'md', 4, '2017-08-13', '11:11:00.000000', 196, 80, 1, 500, 780, 1000),
	(4, 'IND', 'md', 4, '2017-08-13', '16:11:00.000000', 198, 80, 1, 500, 780, 1000),
	(5, 'SPJ', 'lg', 5, '2017-08-11', '11:56:45.000000', 99, 10, 10, 200, 500, 800),
	(6, 'VST', 'md', 7, '2017-08-11', '09:30:25.000000', 97, 20, 5, 230, 450, 800),
	(14, 'IND', 'md', 7, '2017-08-11', '12:31:22.000000', 100, 20, 5, 220, 550, 800),
	(15, 'IND', 'md', 7, '2017-08-11', '02:48:19.000000', 100, 20, 5, 225, 430, 800),
	(16, 'IND', 'md', 7, '2017-08-11', '18:18:32.000000', 100, 20, 5, 310, 510, 800),
	(17, 'IND', 'md', 7, '2017-08-11', '21:22:38.000000', 100, 20, 5, 370, 550, 800),
	(18, 'VST', 'md', 7, '2017-08-11', '25:39:10.000000', 100, 20, 5, 200, 470, 800),
	(28, 'IND', 'md', 7, '2017-08-11', '12:31:22.000000', 100, 20, 5, 220, 550, 800),
	(29, 'QTR', 'md', 11, '2017-08-11', '08:39:10.000000', 100, 20, 5, 320, 470, 800),
	(30, 'IND', 'md', 11, '2017-08-11', '23:39:10.000000', 100, 20, 5, 120, 470, 800),
	(31, 'AID', 'md', 11, '2017-08-11', '06:39:10.000000', 100, 20, 5, 420, 470, 800),
	(32, 'AID', 'md', 11, '2017-08-11', '24:39:10.000000', 100, 20, 5, 340, 234, 800),
	(33, 'VST', 'md', 11, '2017-08-11', '08:39:10.000000', 100, 20, 5, 230, 470, 800);
/*!40000 ALTER TABLE `flt_flight` ENABLE KEYS */;

-- Dumping structure for table sap_flight_v1_0.flt_route
CREATE TABLE IF NOT EXISTS `flt_route` (
  `route_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` varchar(5) NOT NULL,
  `destination_id` varchar(5) NOT NULL,
  `miles` int(11) NOT NULL,
  PRIMARY KEY (`route_id`),
  UNIQUE KEY `source_id_destination_id` (`source_id`,`destination_id`),
  KEY `FK_flt_route_flt_airport_2` (`destination_id`),
  CONSTRAINT `FK_flt_route_flt_airport` FOREIGN KEY (`source_id`) REFERENCES `flt_airport` (`airport_id`),
  CONSTRAINT `FK_flt_route_flt_airport_2` FOREIGN KEY (`destination_id`) REFERENCES `flt_airport` (`airport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- Dumping data for table sap_flight_v1_0.flt_route: ~17 rows (approximately)
/*!40000 ALTER TABLE `flt_route` DISABLE KEYS */;
INSERT INTO `flt_route` (`route_id`, `source_id`, `destination_id`, `miles`) VALUES
	(2, 'DEL', 'GOI', 450),
	(3, 'GOI', 'BLR', 320),
	(4, 'GAU', 'BLR', 780),
	(5, 'IXZ', 'PBD', 100),
	(6, 'AGR', 'AMD', 320),
	(7, 'AGR', 'BLR', 670),
	(11, 'AGR', 'BOK', 930),
	(12, 'AGR', 'BHO', 232),
	(13, 'AGR', 'COK', 1100),
	(14, 'AGR', 'CJB', 850),
	(15, 'AGR', 'DEL', 60),
	(16, 'AGR', 'GOI', 780),
	(17, 'COK', 'AMD', 234),
	(18, 'AMD', 'BLR', 534),
	(19, 'DEL', 'AGR', 60),
	(20, 'IXZ', 'COK', 5345),
	(23, 'IXZ', 'DEL', 324);
/*!40000 ALTER TABLE `flt_route` ENABLE KEYS */;

-- Dumping structure for table sap_flight_v1_0.flt_users
CREATE TABLE IF NOT EXISTS `flt_users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `password` varchar(500) NOT NULL,
  `fname` varchar(200) NOT NULL,
  `lname` varchar(200) NOT NULL,
  `air_miles` int(11) NOT NULL,
  `billing_address` mediumtext NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Dumping data for table sap_flight_v1_0.flt_users: ~10 rows (approximately)
/*!40000 ALTER TABLE `flt_users` DISABLE KEYS */;
INSERT INTO `flt_users` (`user_id`, `email`, `contact`, `password`, `fname`, `lname`, `air_miles`, `billing_address`) VALUES
	(1, 'c.sritej@gmail.com', NULL, 'sritej1$', 'sritej', 'c', 1000, 'c-33,bdl township'),
	(2, 'kavih@gmail.com', NULL, 'kavish1$', 'kavish', 'dahekar', 1000, 'maharashtra'),
	(3, 'c.sriteju@gmail.com', '9506729692', 'sritej1$', 'sri', 'tej', 500, 'heaven'),
	(4, 'ram.johani@gmail.com', '9506764692', 'sri54j1$', 'ram', 'tej', 500, 'hell'),
	(5, 'qwe@qwe.com', '123123', 'qweqwe', 'Babu', 'Moshai', 780, 'purgatory'),
	(6, 'asd@asd.com', '123123', 'qweqwe', 'Gabbar ', 'Singh', 49780, 'qwrasf'),
	(7, 'kavishdahekar@gmail.com', '123123123', 'qweqwe', 'Kavish', 'Dahekar', 200, 'Whtiefield'),
	(10, 'yash.tatia@gmail.com', '123', 'efe6398127928f1b2e9ef3207fb82663', 'yash', 'Tatia', 0, 'Whitefield'),
	(11, 'test@test.com', '123123', 'efe6398127928f1b2e9ef3207fb82663', 'Michael', 'Mastana', 670, 'Whitefield'),
	(12, 'newuser@test.com', '123123', 'efe6398127928f1b2e9ef3207fb82663', 'New', 'User', 3000, 'qweqwe');
/*!40000 ALTER TABLE `flt_users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
