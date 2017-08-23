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


-- Dumping database structure for flt_2
CREATE DATABASE IF NOT EXISTS `flt_2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `flt_2`;

-- Dumping structure for table flt_2.flt_airport
CREATE TABLE IF NOT EXISTS `flt_airport` (
  `airport_id` varchar(5) NOT NULL,
  `airport_name` varchar(200) NOT NULL,
  PRIMARY KEY (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table flt_2.flt_airport: ~15 rows (approximately)
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

-- Dumping structure for table flt_2.flt_carrier
CREATE TABLE IF NOT EXISTS `flt_carrier` (
  `carrier_id` varchar(50) NOT NULL,
  `carrier_name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`carrier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table flt_2.flt_carrier: ~2 rows (approximately)
/*!40000 ALTER TABLE `flt_carrier` DISABLE KEYS */;
INSERT INTO `flt_carrier` (`carrier_id`, `carrier_name`, `address`) VALUES
	('AIR', 'AirIndia', ''),
	('IND', 'Indigo', '');
/*!40000 ALTER TABLE `flt_carrier` ENABLE KEYS */;

-- Dumping structure for table flt_2.flt_fleet
CREATE TABLE IF NOT EXISTS `flt_fleet` (
  `plane_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manuf` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`plane_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table flt_2.flt_fleet: ~4 rows (approximately)
/*!40000 ALTER TABLE `flt_fleet` DISABLE KEYS */;
INSERT INTO `flt_fleet` (`plane_id`, `manuf`, `model`) VALUES
	(1, 'Airbus', 'A320'),
	(2, 'Boeing', '747'),
	(3, 'Airbus', 'A380'),
	(4, 'Boeing', '777');
/*!40000 ALTER TABLE `flt_fleet` ENABLE KEYS */;

-- Dumping structure for table flt_2.flt_path_flight
CREATE TABLE IF NOT EXISTS `flt_path_flight` (
  `path_id` int(10) unsigned NOT NULL,
  `flight_id` int(10) unsigned NOT NULL,
  `order` int(10) unsigned NOT NULL,
  KEY `FK__flt_sub_flight` (`flight_id`),
  CONSTRAINT `FK__flt_sub_flight` FOREIGN KEY (`flight_id`) REFERENCES `flt_sub_flight` (`flight_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table flt_2.flt_path_flight: ~0 rows (approximately)
/*!40000 ALTER TABLE `flt_path_flight` DISABLE KEYS */;
INSERT INTO `flt_path_flight` (`path_id`, `flight_id`, `order`) VALUES
	(1, 2, 1),
	(1, 3, 1),
	(1, 4, 2);
/*!40000 ALTER TABLE `flt_path_flight` ENABLE KEYS */;

-- Dumping structure for table flt_2.flt_route
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

-- Dumping data for table flt_2.flt_route: ~17 rows (approximately)
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

-- Dumping structure for table flt_2.flt_seat_matrix
CREATE TABLE IF NOT EXISTS `flt_seat_matrix` (
  `flight_id` int(11) unsigned NOT NULL,
  `seat_type` varchar(5) NOT NULL,
  `seats` int(11) NOT NULL,
  `vacant` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  UNIQUE KEY `flight_id_seat_type` (`flight_id`,`seat_type`),
  KEY `FK_flt_seat_matrix_flt_seat_type` (`seat_type`),
  CONSTRAINT `FK_flt_seat_matrix_flt_flight` FOREIGN KEY (`flight_id`) REFERENCES `flt_sub_flight` (`flight_id`),
  CONSTRAINT `FK_flt_seat_matrix_flt_seat_type` FOREIGN KEY (`seat_type`) REFERENCES `flt_seat_type` (`seat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table flt_2.flt_seat_matrix: ~2 rows (approximately)
/*!40000 ALTER TABLE `flt_seat_matrix` DISABLE KEYS */;
INSERT INTO `flt_seat_matrix` (`flight_id`, `seat_type`, `seats`, `vacant`, `price`) VALUES
	(1, 'bus', 50, 50, 34),
	(1, 'eco', 100, 100, 41);
/*!40000 ALTER TABLE `flt_seat_matrix` ENABLE KEYS */;

-- Dumping structure for table flt_2.flt_seat_type
CREATE TABLE IF NOT EXISTS `flt_seat_type` (
  `seat_type` varchar(10) NOT NULL,
  PRIMARY KEY (`seat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table flt_2.flt_seat_type: ~4 rows (approximately)
/*!40000 ALTER TABLE `flt_seat_type` DISABLE KEYS */;
INSERT INTO `flt_seat_type` (`seat_type`) VALUES
	('bus'),
	('cargo'),
	('eco'),
	('elt');
/*!40000 ALTER TABLE `flt_seat_type` ENABLE KEYS */;

-- Dumping structure for table flt_2.flt_sub_flight
CREATE TABLE IF NOT EXISTS `flt_sub_flight` (
  `flight_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrier_id` varchar(50) NOT NULL,
  `fleet_id` int(10) unsigned NOT NULL,
  `route_id` int(10) unsigned NOT NULL,
  `date` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `FK_flt_flight_flt_carrier` (`carrier_id`),
  KEY `FK_flt_flight_flt_fleet` (`fleet_id`),
  KEY `FK_flt_flight_flt_route` (`route_id`),
  CONSTRAINT `FK_flt_flight_flt_carrier` FOREIGN KEY (`carrier_id`) REFERENCES `flt_carrier` (`carrier_id`),
  CONSTRAINT `FK_flt_flight_flt_fleet` FOREIGN KEY (`fleet_id`) REFERENCES `flt_fleet` (`plane_id`),
  CONSTRAINT `FK_flt_flight_flt_route` FOREIGN KEY (`route_id`) REFERENCES `flt_route` (`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table flt_2.flt_sub_flight: ~4 rows (approximately)
/*!40000 ALTER TABLE `flt_sub_flight` DISABLE KEYS */;
INSERT INTO `flt_sub_flight` (`flight_id`, `carrier_id`, `fleet_id`, `route_id`, `date`, `time`) VALUES
	(1, 'AIR', 1, 5, 'qwe', 'qwe'),
	(2, 'IND', 3, 7, 'qwe', 'qwe'),
	(3, 'AIR', 1, 16, 'qwe', 'qwe'),
	(4, 'IND', 2, 3, 'qwe\r\n', 'qwe\r\n\r\n');
/*!40000 ALTER TABLE `flt_sub_flight` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
