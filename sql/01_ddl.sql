CREATE DATABASE  IF NOT EXISTS `stock` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `stock`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: node1.nicolairader.de    Database: stock
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `config_id` int NOT NULL AUTO_INCREMENT,
  `parameter` varchar(45) DEFAULT NULL,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `parameter_UNIQUE` (`parameter`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `symbol` varchar(45) NOT NULL,
  `company` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`stock_id`),
  UNIQUE KEY `isin_UNIQUE` (`symbol`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_value`
--

DROP TABLE IF EXISTS `stock_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_value` (
  `stock_value_id` int NOT NULL AUTO_INCREMENT,
  `stock_id` int DEFAULT NULL,
  `value` float DEFAULT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stock_value_id`),
  UNIQUE KEY `idx_stock_value_added_at_stock_id` (`added_at`,`stock_id`),
  KEY `FK_stock_value_stock_idx` (`stock_id`),
  CONSTRAINT `FK_stock_value_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_profit`
--

DROP TABLE IF EXISTS `v_profit`;
/*!50001 DROP VIEW IF EXISTS `v_profit`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_profit` AS SELECT
 1 AS `company`,
 1 AS `diff`,
 1 AS `perc`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_stock_value`
--

DROP TABLE IF EXISTS `v_stock_value`;
/*!50001 DROP VIEW IF EXISTS `v_stock_value`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_stock_value` AS SELECT
 1 AS `symbol`,
 1 AS `company`,
 1 AS `value`,
 1 AS `added_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'stock'
--

--
-- Final view structure for view `v_profit`
--

/*!50001 DROP VIEW IF EXISTS `v_profit`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_profit` AS select `s`.`company` AS `company`,round((`new`.`value` - `old`.`value`),2) AS `diff`,round(((`new`.`value` / `old`.`value`) - 1),4) AS `perc` from (((select `so`.`stock_id` AS `stock_id`,`jo`.`value` AS `value` from ((select `stock_value`.`stock_id` AS `stock_id`,min(`stock_value`.`stock_value_id`) AS `stock_value_id` from `stock_value` group by `stock_value`.`stock_id`) `so` join `stock_value` `jo` on(((`so`.`stock_id` = `jo`.`stock_id`) and (`so`.`stock_value_id` = `jo`.`stock_value_id`))))) `old` join (select `sn`.`stock_id` AS `stock_id`,`jn`.`value` AS `value` from ((select `stock_value`.`stock_id` AS `stock_id`,max(`stock_value`.`stock_value_id`) AS `stock_value_id` from `stock_value` group by `stock_value`.`stock_id`) `sn` join `stock_value` `jn` on(((`sn`.`stock_id` = `jn`.`stock_id`) and (`sn`.`stock_value_id` = `jn`.`stock_value_id`))))) `new`) join `stock` `s`) where ((`old`.`stock_id` = `new`.`stock_id`) and (`s`.`stock_id` = `new`.`stock_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_stock_value`
--

/*!50001 DROP VIEW IF EXISTS `v_stock_value`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_stock_value` AS select `s`.`symbol` AS `symbol`,`s`.`company` AS `company`,`sv`.`value` AS `value`,`sv`.`added_at` AS `added_at` from (`stock_value` `sv` join `stock` `s` on((`sv`.`stock_id` = `s`.`stock_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-04 22:55:30
