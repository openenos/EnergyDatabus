-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: EnergyDatabus_development
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.12.04.1

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_reference` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_keys`
--

LOCK TABLES `api_keys` WRITE;
/*!40000 ALTER TABLE `api_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circuits`
--

DROP TABLE IF EXISTS `circuits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circuits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT NULL,
  `input` tinyint(1) DEFAULT NULL,
  `breaker_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `double_breaker` tinyint(1) DEFAULT NULL,
  `breaker_size` int(11) DEFAULT NULL,
  `display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `elec_load_type_id` int(11) DEFAULT NULL,
  `panel_id` int(11) DEFAULT NULL,
  `ct_sensor_type` int(11) DEFAULT NULL,
  `double_ct` tinyint(1) DEFAULT NULL,
  `channel_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_producing` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circuits`
--

LOCK TABLES `circuits` WRITE;
/*!40000 ALTER TABLE `circuits` DISABLE KEYS */;
INSERT INTO `circuits` VALUES (1,1,1,NULL,1,150,'Main Power',11,1,NULL,1,'1,2',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(2,1,0,NULL,1,50,'Geothermal Heat Pump',1,1,NULL,0,'3',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(3,0,0,NULL,NULL,NULL,'Unused',NULL,1,NULL,0,'4',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(4,1,0,NULL,0,20,'Water Heater',2,1,NULL,0,'5',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(5,1,0,NULL,0,15,'North, east and west',6,1,NULL,0,'6',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(6,1,0,NULL,0,15,'Bathroom outlets',6,1,NULL,0,'7',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(7,1,0,NULL,0,20,'Kitchen outlets',6,1,NULL,0,'8',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(8,1,0,NULL,0,15,'Soffit outlets',6,1,NULL,0,'9',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(9,1,0,NULL,0,15,'Emon outlet',6,1,NULL,0,'10',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(10,1,0,NULL,0,15,'NE, SW Room',3,1,NULL,0,'11',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(11,1,0,NULL,0,15,'Hall, SW Room, Kitch',3,1,NULL,0,'12',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(12,1,1,NULL,1,150,'Main Power',11,2,NULL,1,'1,2',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(13,1,0,NULL,1,50,'A/C - E',1,2,NULL,0,'3',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(14,1,0,NULL,0,20,'Refigerator',9,2,NULL,0,'4',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(15,1,0,NULL,1,50,'A/C - W',1,2,NULL,0,'5',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(16,1,0,NULL,0,15,'Ceiling Fan',1,2,NULL,0,'6',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(17,1,0,NULL,1,30,'Bunn Coffee Machine',5,2,NULL,0,'7',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(18,1,0,NULL,1,30,'Bunn Coffee Machine',5,2,NULL,0,'8',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(19,1,0,NULL,1,30,'Aux. Water Heater',2,2,NULL,0,'9',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(20,1,0,NULL,1,30,'Grille',5,2,NULL,0,'10',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(21,1,0,NULL,1,30,'Display Refrigerator',9,2,NULL,1,'11, 12',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(22,1,0,NULL,0,20,'Bathroom lights',3,2,NULL,0,'13',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(23,1,0,NULL,0,20,'Dishwasher',5,2,NULL,0,'14',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(24,1,0,NULL,0,20,'Exhaust Fan+UC Fridg',9,2,NULL,0,'15',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(25,1,0,NULL,0,20,'Ice Machine',9,2,NULL,0,'16',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(26,1,0,NULL,0,20,'Flood Lights, Emon',3,2,NULL,0,'17',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(27,1,0,NULL,0,15,'Track Lights',3,2,NULL,0,'18',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(28,1,0,NULL,0,20,'Dining Room R',8,2,NULL,0,'19',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(29,1,0,NULL,0,20,'Freezer',9,2,NULL,0,'20',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(30,1,0,NULL,1,30,'Espresso Machine',5,2,NULL,0,'21',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(31,1,0,NULL,0,20,'Unknown Load',8,2,NULL,0,'22',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(32,1,0,NULL,0,15,'Cash Register',5,2,NULL,0,'23',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(33,1,0,NULL,1,20,'Phone Data  ?',8,2,NULL,0,'24',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(34,1,1,NULL,1,150,'Main Power',11,3,NULL,1,'1,2',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(35,1,0,NULL,1,20,'A/C -1',1,3,NULL,0,'3',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(36,1,0,NULL,1,40,'A/C-2',1,3,NULL,0,'4',0,'2014-06-24 06:21:30','2014-06-24 06:21:30',NULL),(37,1,0,NULL,0,20,'Show Room',3,3,NULL,0,'5',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(38,1,0,NULL,0,20,'EWH-1',2,3,NULL,0,'6',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(39,1,0,NULL,0,20,'EWH-1',2,3,NULL,0,'7',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(40,0,0,NULL,0,NULL,'Unused',NULL,3,NULL,0,'8',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(41,0,0,NULL,0,NULL,'Unused',NULL,3,NULL,0,'9',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(42,0,0,NULL,0,NULL,'Unused',NULL,3,NULL,0,'10',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(43,0,0,NULL,0,NULL,'Unused',NULL,3,NULL,0,'11',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(44,0,0,NULL,0,NULL,'Unused',NULL,3,NULL,0,'12',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(45,1,0,NULL,0,20,'Channel 13',8,3,NULL,0,'13',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(46,1,0,NULL,0,20,'Channel 14',8,3,NULL,0,'14',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(47,1,0,NULL,0,20,'Channel 15',8,3,NULL,0,'15',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(48,1,0,NULL,0,20,'Channel 16',8,3,NULL,0,'16',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(49,1,0,NULL,0,20,'Channel 17',8,3,NULL,0,'17',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(50,1,0,NULL,0,20,'Channel 18',8,3,NULL,0,'18',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(51,1,0,NULL,0,20,'Channel 19',8,3,NULL,0,'19',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(52,1,0,NULL,0,20,'Channel 20',8,3,NULL,0,'20',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(53,1,0,NULL,0,20,'Channel 21',8,3,NULL,0,'21',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(54,1,0,NULL,0,20,'Channel 22',8,3,NULL,0,'22',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(55,1,0,NULL,0,20,'Channel 23',8,3,NULL,0,'23',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(56,1,0,NULL,0,20,'Channel 24',8,3,NULL,0,'24',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(57,1,1,NULL,1,150,'Main Power',11,4,NULL,1,'1,2',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(58,1,0,NULL,0,20,'Dishwasher',5,4,NULL,0,'3',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(59,1,0,NULL,0,20,'Computer',5,4,NULL,0,'4',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(60,1,0,NULL,1,20,'Solar Hot Water',2,4,NULL,0,'5',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(61,1,0,NULL,1,50,'Range',5,4,NULL,1,'6,7',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(62,1,0,NULL,0,20,'Lighting',3,4,NULL,0,'8',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(63,1,0,NULL,0,20,'Disposal',5,4,NULL,0,'9',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(64,1,0,NULL,1,40,'WSHP-3',1,4,NULL,0,'10',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(65,1,0,NULL,0,20,'Dryer',5,4,NULL,0,'11',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(66,1,0,NULL,0,20,'Fridge',9,4,NULL,0,'12',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(67,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'13',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(68,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'14',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(69,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'15',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(70,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'16',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(71,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'17',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(72,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'18',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(73,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'19',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(74,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'20',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(75,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'21',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(76,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'22',0,'2014-06-24 06:21:31','2014-06-24 06:21:31',NULL),(77,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'23',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(78,0,0,NULL,0,NULL,'Unused',NULL,4,NULL,0,'24',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(79,1,1,NULL,1,150,'Main Power',11,5,NULL,1,'1,2',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(80,1,1,NULL,1,20,'Solar Input',7,5,NULL,0,'3',1,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(81,1,0,NULL,0,15,'No CT',8,5,NULL,0,'4',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(82,1,0,NULL,1,60,'WSHP',1,5,NULL,0,'5',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(83,1,0,NULL,1,60,'Range',5,5,NULL,1,'6,7',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(84,1,0,NULL,0,20,'Microwave',5,5,NULL,0,'8',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(85,1,0,NULL,0,20,'Dishwasher',5,5,NULL,0,'9',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(86,1,0,NULL,0,20,'Mixer',5,5,NULL,0,'10',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(87,1,0,NULL,0,20,'Fridge in Back',9,5,NULL,0,'11',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(88,1,0,NULL,0,20,'Front Display Case',9,5,NULL,0,'12',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(89,1,0,NULL,0,20,'Back Middle Freezer',9,5,NULL,0,'13',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(90,1,0,NULL,0,20,'Back Freezer near Wa',9,5,NULL,0,'14',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(91,1,0,NULL,0,20,'Lighting{1}',3,5,NULL,0,'15',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(92,1,0,NULL,0,20,'Gas Water Heater',2,5,NULL,0,'16',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(93,1,0,NULL,0,20,'Gas Convection Oven',5,5,NULL,0,'17',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(94,1,0,NULL,0,20,'Receptacle 1',6,5,NULL,0,'18',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(95,1,0,NULL,0,20,'Receptacle 2',6,5,NULL,0,'19',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(96,1,0,NULL,0,20,'Receptacle 3',6,5,NULL,0,'20',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(97,1,0,NULL,0,20,'Front Small Fridge',9,5,NULL,0,'21',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(98,1,0,NULL,0,20,'Bath/Mechanical Room',3,5,NULL,0,'22',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(99,1,0,NULL,0,20,'Outdoor Receptacle',6,5,NULL,0,'23',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(100,1,0,NULL,0,20,'Lighting Outdoor',3,5,NULL,0,'24',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(101,1,1,NULL,1,150,'Main Power',11,6,NULL,1,'1,2',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(102,1,0,NULL,1,30,'A/C',1,6,NULL,0,'3',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(103,1,0,NULL,0,20,'Show Window',3,6,NULL,0,'4',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(104,1,0,NULL,0,20,'Receptacles',6,6,NULL,0,'5',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(105,1,0,NULL,0,20,'Lighting',3,6,NULL,0,'6',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(106,1,0,NULL,0,20,'Receptacles',6,6,NULL,0,'7',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(107,1,0,NULL,0,20,'Show Window',3,6,NULL,0,'8',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(108,1,0,NULL,0,20,'Roof Receptacle',6,6,NULL,0,'9',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(109,1,0,NULL,0,20,'Restroom/Corridor',3,6,NULL,0,'10',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(110,1,0,NULL,0,20,'Closet',3,6,NULL,0,'11',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(111,1,0,NULL,0,15,'No CT',8,6,NULL,0,'12',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(112,1,1,NULL,1,150,'Main Power',11,7,NULL,1,'1,2',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(113,1,1,NULL,1,30,'Solar input 1',7,7,NULL,0,'3',1,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(114,1,1,NULL,1,30,'Solar input 2',7,7,NULL,0,'4',1,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(115,1,0,NULL,1,20,'WSHP-1',1,7,NULL,0,'5',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(116,1,0,NULL,0,20,'EWH-1',2,7,NULL,0,'6',0,'2014-06-24 06:21:32','2014-06-24 06:21:32',NULL),(117,1,0,NULL,0,20,'Fridge',9,7,NULL,0,'7',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(118,1,0,NULL,0,20,'Receptacles{1}',6,7,NULL,0,'8',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(119,1,0,NULL,0,20,'Receptacles',6,7,NULL,0,'9',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(120,1,0,NULL,0,20,'Emon, Receptacles',5,7,NULL,0,'10',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(121,1,0,NULL,0,20,'Lighting, Condensate',3,7,NULL,0,'11',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(122,1,0,NULL,0,20,'Lighting, Receptacle',3,7,NULL,0,'12',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(123,0,0,NULL,0,NULL,'Channel 13',NULL,7,NULL,0,'13',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(124,0,0,NULL,0,NULL,'Channel 14',NULL,7,NULL,0,'14',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(125,0,0,NULL,0,NULL,'Channel 15',NULL,7,NULL,0,'15',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(126,0,0,NULL,0,NULL,'Channel 16',NULL,7,NULL,0,'16',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(127,0,0,NULL,0,NULL,'Channel 17',NULL,7,NULL,0,'17',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(128,0,0,NULL,0,NULL,'Channel 18',NULL,7,NULL,0,'18',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(129,0,0,NULL,0,NULL,'Channel 19',NULL,7,NULL,0,'19',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(130,0,0,NULL,0,NULL,'Channel 20',NULL,7,NULL,0,'20',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(131,0,0,NULL,0,NULL,'Channel 21',NULL,7,NULL,0,'21',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(132,0,0,NULL,0,NULL,'Channel 22',NULL,7,NULL,0,'22',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(133,0,0,NULL,0,NULL,'Channel 23',NULL,7,NULL,0,'23',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(134,0,0,NULL,0,NULL,'Channel 24',NULL,7,NULL,0,'24',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(135,1,1,NULL,1,150,'Main Power',11,8,NULL,1,'1,2',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(136,1,0,NULL,1,50,'Range',5,8,NULL,1,'3,4',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(137,1,0,NULL,1,30,'Dryer',5,8,NULL,0,'5',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(138,1,0,NULL,1,30,'Dryer',5,8,NULL,0,'6',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(139,1,0,NULL,1,30,'GSHP',1,8,NULL,0,'7',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(140,1,0,NULL,0,20,'Attic Pump (A/C)',1,8,NULL,0,'8',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(141,1,0,NULL,1,30,'SHW Backup',2,8,NULL,0,'9',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(142,1,0,NULL,0,20,'Fridge',9,8,NULL,0,'10',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(143,1,0,NULL,0,20,'Washer',5,8,NULL,0,'11',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(144,1,0,NULL,0,20,'Receptacle',6,8,NULL,0,'12',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(145,1,0,NULL,0,20,'Receptacle{2}',6,8,NULL,0,'13',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(146,1,0,NULL,0,20,'Dishwasher',5,8,NULL,0,'14',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(147,1,0,NULL,0,20,'DEH-1',2,8,NULL,0,'15',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(148,1,0,NULL,0,20,'CWP-2',8,8,NULL,0,'16',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(149,1,0,NULL,0,20,'Receptacle{3}',6,8,NULL,0,'17',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(150,1,0,NULL,0,20,'Disposal',5,8,NULL,0,'18',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(151,1,0,NULL,0,20,'Receptacle{4}',6,8,NULL,0,'19',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(152,1,0,NULL,0,20,'Receptacle{5}',6,8,NULL,0,'20',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(153,1,0,NULL,0,20,'Receptacle{6}',6,8,NULL,0,'21',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(154,1,0,NULL,0,20,'Range Hood',5,8,NULL,0,'22',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(155,1,0,NULL,0,20,'Lighting',3,8,NULL,0,'23',0,'2014-06-24 06:21:33','2014-06-24 06:21:33',NULL),(156,1,0,NULL,0,20,'Lighting{7}',3,8,NULL,0,'24',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(157,1,1,NULL,1,150,'Main Power',11,9,NULL,1,'1,2',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(158,1,0,NULL,1,40,'Electric Car Charger',10,9,NULL,0,'3',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(159,1,0,NULL,0,20,'Irrigation Pump',4,9,NULL,0,'4',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(160,1,0,NULL,0,20,'Toilet (Rainwater) P',4,9,NULL,0,'5',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(161,1,0,NULL,1,20,'Well Pump',4,9,NULL,0,'6',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(162,1,0,NULL,0,15,'No CT',8,9,NULL,0,'7',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(163,1,0,NULL,0,20,'GFI Charger east ?',10,9,NULL,0,'8',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(164,1,0,NULL,0,20,'BRAC Pump',4,9,NULL,0,'9',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(165,1,0,NULL,0,20,'Emon outlet',6,9,NULL,0,'10',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(166,0,0,NULL,0,15,'Unused',8,9,NULL,0,'11',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(167,0,0,NULL,0,NULL,'Unused',NULL,9,NULL,0,'12',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(168,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'1',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(169,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'2',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(170,1,1,NULL,1,150,'PV Warehouse',7,10,NULL,0,'3',1,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(171,1,1,NULL,1,150,'PV Rosedale',7,10,NULL,0,'4',1,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(172,1,1,NULL,1,150,'PV Sears',7,10,NULL,0,'5',1,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(173,1,1,NULL,1,50,'North Carport',7,10,NULL,0,'6',1,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(174,1,1,NULL,1,50,'South Carport',7,10,NULL,0,'7',1,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(175,1,1,NULL,1,20,'Thelmas PV',7,10,NULL,0,'8',1,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(176,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'9',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(177,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'10',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(178,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'11',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(179,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'12',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(180,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'13',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(181,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'14',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(182,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'15',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(183,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'16',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(184,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'17',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(185,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'18',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(186,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'19',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(187,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'20',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(188,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'21',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(189,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'22',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(190,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'23',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL),(191,0,0,NULL,0,NULL,'Unused',NULL,10,NULL,0,'24',0,'2014-06-24 06:21:34','2014-06-24 06:21:34',NULL);
/*!40000 ALTER TABLE `circuits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elec_load_types`
--

DROP TABLE IF EXISTS `elec_load_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elec_load_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `load_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elec_load_types`
--

LOCK TABLES `elec_load_types` WRITE;
/*!40000 ALTER TABLE `elec_load_types` DISABLE KEYS */;
INSERT INTO `elec_load_types` VALUES (1,'HVAC','Heating & Cooling','2014-06-24 06:30:53','2014-06-24 06:30:53'),(2,'Hot Water','Domestic Hot Water','2014-06-24 06:30:53','2014-06-24 06:30:53'),(3,'Lighting','Lighting','2014-06-24 06:30:53','2014-06-24 06:30:53'),(4,'Motor','Motors & Pumps','2014-06-24 06:30:53','2014-06-24 06:30:53'),(5,'Appliance','Appliances','2014-06-24 06:30:53','2014-06-24 06:30:53'),(6,'Plug','Plug Loads','2014-06-24 06:30:53','2014-06-24 06:30:53'),(7,'PV','Energy Production','2014-06-24 06:30:53','2014-06-24 06:30:53'),(8,'Misc','Miscellaneous','2014-06-24 06:30:53','2014-06-24 06:30:53'),(9,'Refrigeration','Refrigeration','2014-06-24 06:30:53','2014-06-24 06:30:53'),(10,'EV Charge','Electric Vehicle Charger','2014-06-24 06:30:53','2014-06-24 06:30:53'),(11,'Mains','Mains','2015-08-15 15:03:48','2015-08-15 15:03:48');
/*!40000 ALTER TABLE `elec_load_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elec_meters`
--

DROP TABLE IF EXISTS `elec_meters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elec_meters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meter_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meter_main` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `meter_loc` int(11) DEFAULT NULL,
  `phase` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amp` int(11) DEFAULT NULL,
  `volt` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elec_meters`
--

LOCK TABLES `elec_meters` WRITE;
/*!40000 ALTER TABLE `elec_meters` DISABLE KEYS */;
/*!40000 ALTER TABLE `elec_meters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emon_daily_data`
--

DROP TABLE IF EXISTS `emon_daily_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emon_daily_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `circuit_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `as_of_day` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emon_daily_data`
--

LOCK TABLES `emon_daily_data` WRITE;
/*!40000 ALTER TABLE `emon_daily_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `emon_daily_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_addr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code_id` int(11) DEFAULT NULL,
  `geo_lat` decimal(10,0) DEFAULT NULL,
  `geo_lng` decimal(10,0) DEFAULT NULL,
  `utility_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'505 Pine Ave',1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(2,'503 Pine Ave',1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(3,'501 Pine Ave',1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(4,'501 Pine Ave',1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(5,'507B Pine Ave',1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(6,'507 Pine Ave',1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(7,NULL,1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(8,NULL,1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(9,NULL,1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL),(10,NULL,1,28,-83,1,'2014-06-24 06:07:12','2014-06-24 06:07:12',NULL);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `panels`
--

DROP TABLE IF EXISTS `panels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emon_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `equip_ref` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `panel_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_panel_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `no_of_circuits` int(11) DEFAULT NULL,
  `amp` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `panels`
--

LOCK TABLES `panels` WRITE;
/*!40000 ALTER TABLE `panels` DISABLE KEYS */;
INSERT INTO `panels` VALUES (1,'rosedale.homelinux.com:8086/status.xml','panel','sitePanel',0,1,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(2,'rosedale.homelinux.com:8081/status.xml','panel','sitePanel',0,2,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(3,'rosedale.homelinux.com:8089/status.xml','panel','sitePanel',0,3,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(4,'rosedale.homelinux.com:8088/status.xml','panel','sitePanel',0,4,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(5,'rosedale.homelinux.com:8085/status.xml','panel','sitePanel',0,5,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(6,'rosedale.homelinux.com:8084/status.xml','panel','sitePanel',0,6,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(7,'rosedale.homelinux.com:8090/status.xml','panel','sitePanel',0,7,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(8,'rosedale.homelinux.com:8087/status.xml','panel','sitePanel',0,8,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(9,'rosedale.homelinux.com:8082/status.xml','panel','sitePanel',0,9,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL),(10,'rosedale.homelinux.com:8083/status.xml','panel','sitePanel',0,10,24,NULL,'2014-06-24 06:16:39','2014-06-24 06:16:39',NULL);
/*!40000 ALTER TABLE `panels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postal_codes`
--

DROP TABLE IF EXISTS `postal_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postal_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geo_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geo_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geo_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tz` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weather_ref` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postal_codes`
--

LOCK TABLES `postal_codes` WRITE;
/*!40000 ALTER TABLE `postal_codes` DISABLE KEYS */;
INSERT INTO `postal_codes` VALUES (1,'34216','Anna Maria','FL','US','EDT','KFLPALME10','2014-06-24 06:09:05','2014-06-24 06:09:05',NULL);
/*!40000 ALTER TABLE `postal_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20150113144500'),('20150114053903'),('20150114070643'),('20150114071105'),('20150114071153'),('20150114071356'),('20150114071514'),('20150114071559'),('20150114071743'),('20150114071841'),('20150114084332'),('20150114084517'),('20150119071348'),('20150121102216'),('20150815055334'),('20150815060607');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_group_mappings`
--

DROP TABLE IF EXISTS `site_group_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_group_mappings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_group_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_group_mappings`
--

LOCK TABLES `site_group_mappings` WRITE;
/*!40000 ALTER TABLE `site_group_mappings` DISABLE KEYS */;
INSERT INTO `site_group_mappings` VALUES (1,1,1,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(2,1,2,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(3,1,3,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(4,1,4,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(5,1,5,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(6,1,6,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(7,1,7,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(8,1,8,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(9,1,9,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(10,1,10,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(11,2,1,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(12,2,2,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(13,2,3,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(14,2,5,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(15,2,6,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(16,2,7,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(17,3,4,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(18,3,8,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(19,4,1,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(20,4,3,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(21,5,2,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(22,5,5,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL),(23,6,7,'2014-06-24 06:11:46','2014-06-24 06:11:46',NULL);
/*!40000 ALTER TABLE `site_group_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_groups`
--

DROP TABLE IF EXISTS `site_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_groups`
--

LOCK TABLES `site_groups` WRITE;
/*!40000 ALTER TABLE `site_groups` DISABLE KEYS */;
INSERT INTO `site_groups` VALUES (1,'Historic Green Village','2014-06-24 06:10:20','2014-06-24 06:10:20',NULL),(2,'Commercial','2014-06-24 06:10:20','2014-06-24 06:10:20',NULL),(3,'Residential','2014-06-24 06:10:20','2014-06-24 06:10:20',NULL),(4,'Retail','2014-06-24 06:10:20','2014-06-24 06:10:20',NULL),(5,'Commercial Kitchen','2014-06-24 06:10:20','2014-06-24 06:10:20',NULL),(6,'Commercial Office','2014-06-24 06:10:20','2014-06-24 06:10:20',NULL);
/*!40000 ALTER TABLE `site_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_gross_square_foot` int(11) DEFAULT NULL,
  `site_ref` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `year_built` int(11) DEFAULT NULL,
  `area_cond_square_foot` int(11) DEFAULT NULL,
  `operating_hours` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1088,'HGV1','AMI Outfitters - Sears Cottage',1935,1088,NULL,1,'2015-02-06 13:30:00','2015-02-06 13:30:00',NULL),(2,2805,'HGV2','Rosedale Café',1913,2805,NULL,2,'2015-02-06 13:30:00','2015-02-06 13:30:00',NULL),(3,1600,'HGV3','Libby\'s Island Jewelry - Thelmas-by-the-Sea',1913,1600,NULL,3,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL),(4,1200,'HGV4','Thelmas-by-the-Sea Residence',1913,1200,NULL,4,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL),(5,1000,'HGV5','Hometown Desserts',2013,1000,NULL,5,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL),(6,600,'HGV6','Bob Brown Art',2013,600,NULL,6,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL),(7,1000,'HGV7','Pilsbury Office',1915,1000,NULL,7,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL),(8,1000,'HGV8','Pilsbury Residence',1915,1000,NULL,8,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL),(9,0,'HGV9','HGV Campus',2012,0,NULL,9,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL),(10,0,'HGV10','HGV Solar PV',2012,0,NULL,10,'2015-02-06 13:30:01','2015-02-06 13:30:01',NULL);
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilities`
--

DROP TABLE IF EXISTS `utilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `utility_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `base_rate` float DEFAULT NULL,
  `demand` tinyint(1) DEFAULT NULL,
  `tier1_rate` float DEFAULT NULL,
  `tier2_rate` float DEFAULT NULL,
  `tier3_rate` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilities`
--

LOCK TABLES `utilities` WRITE;
/*!40000 ALTER TABLE `utilities` DISABLE KEYS */;
INSERT INTO `utilities` VALUES (1,'FP&L','IOU',0.102,NULL,NULL,NULL,NULL,'2014-06-24 06:12:48','2014-06-24 06:12:48');
/*!40000 ALTER TABLE `utilities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-15 23:55:39
