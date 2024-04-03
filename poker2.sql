CREATE DATABASE  IF NOT EXISTS `poker1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `poker1`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: poker1
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `gameinfo`
--

DROP TABLE IF EXISTS `gameinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` varchar(10) NOT NULL,
  `status` enum('waiting','in_progress','finished') DEFAULT 'waiting',
  `num_players` int DEFAULT '0',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameinfo`
--

LOCK TABLES `gameinfo` WRITE;
/*!40000 ALTER TABLE `gameinfo` DISABLE KEYS */;
INSERT INTO `gameinfo` VALUES (1,'ABC123','waiting',2,'2024-03-15 09:25:27'),(3,'GHI789','waiting',4,'2024-03-16 15:20:38'),(7,'JKL012','waiting',1,'2024-03-23 07:40:18');
/*!40000 ALTER TABLE `gameinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` varchar(10) NOT NULL,
  `status` enum('waiting','in_progress','finished') DEFAULT 'waiting',
  PRIMARY KEY (`id`),
  UNIQUE KEY `game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,'ABC123','waiting'),(2,'DEF456','waiting'),(3,'GHI789','waiting'),(4,'JKL012','waiting'),(5,'MNO345','waiting');
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL,
  `user_id` int NOT NULL,
  `player_state` enum('active','folded','checked','raised') DEFAULT 'active',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `game_id` (`game_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `players_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userbets`
--

DROP TABLE IF EXISTS `userbets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userbets` (
  `bet_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `game_id` int DEFAULT NULL,
  `round_number` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `bet_type` enum('fold','check','call','raise') DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bet_id`),
  KEY `user_id` (`user_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `userbets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `userbets_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userbets`
--

LOCK TABLES `userbets` WRITE;
/*!40000 ALTER TABLE `userbets` DISABLE KEYS */;
INSERT INTO `userbets` VALUES (1,6,3,1,0.00,'fold','2024-03-16 15:45:03'),(2,9,4,1,200.00,'raise','2024-03-23 07:40:57'),(3,9,4,2,0.00,'fold','2024-03-23 07:41:13');
/*!40000 ALTER TABLE `userbets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergames`
--

DROP TABLE IF EXISTS `usergames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usergames` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `game_id` int NOT NULL,
  `player_state` enum('active','folded','checked','raised') DEFAULT 'active',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `usergames_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `usergames_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergames`
--

LOCK TABLES `usergames` WRITE;
/*!40000 ALTER TABLE `usergames` DISABLE KEYS */;
INSERT INTO `usergames` VALUES (1,6,3,'folded',0),(2,7,3,'folded',0),(3,6,3,'folded',0),(4,9,4,'active',1);
/*!40000 ALTER TABLE `usergames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `active_game_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_active_game_id` (`active_game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jayTest','test@jay.com','nothashed',NULL),(2,'test2','againtest@hashed.com','hashed',NULL),(3,'test3','demo@hashed.com','$2y$10$oUO/zcO2v5VTfbr/XY88U.d9jXmBRYcv1LnDEZqGFJCy96ldycZlq',NULL),(4,'jayPatel','jay@patel.com','$2y$10$5x8Tgq0VEhJUD2DkhHsHm.19SusYakiIAepwoxealgJoKMvw71BfK',NULL),(6,'jay2','jay2@patel.com','$2y$10$olVoVdfdYJESYXN7YlMFCe8bFPrKyBEifK7pOQHdUkzJBn6W/DuOm',NULL),(7,'jay3','jay3@patel.com','$2y$10$w8kXnTlIKAU6SDWwWO8nNO6oiVPGFhOZ7PQFiErcVE0tVsRhBQUBq',NULL),(8,'jay4','jay4@patel.com','$2y$10$ywrU2j1/1mglbKaWQuAxPeaZV4wSQyi8LF0s8ZDyHEAlk5e130ubC',NULL),(9,'jay5','jay5@patel.com','$2y$10$Y9rhs/6dCqqJSfszQLOug.qO8Q8wyiIF259Gw6ZJIXcs..ewm8kAy',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-31 12:49:28
