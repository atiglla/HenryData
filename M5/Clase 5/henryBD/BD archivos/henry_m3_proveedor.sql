CREATE DATABASE  IF NOT EXISTS `henry_m3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `henry_m3`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: henry_m3
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `IdProveedor` int NOT NULL,
  `Nombre` varchar(80) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `Domicilio` varchar(150) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `IdLocalidad` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdProveedor`),
  KEY `IdLocalidad` (`IdLocalidad`),
  CONSTRAINT `proveedor_fk_localidad` FOREIGN KEY (`IdLocalidad`) REFERENCES `localidad` (`IdLocalidad`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Sin Dato','Bereguestein 36',18),(2,'San Cirano','Alberti 965',73),(3,'Bell S.A.','Moreno 331',47),(4,'Rivero Insumos','Pte. Peron 3872',279),(5,'Laprida Computacion','Avda. Pedro Pereyra 1339',178),(6,'Importadora Mann Kloss','Lope De Vega 2102',55),(7,'Fletes Y Logistica','Santa Rosa 1564',346),(8,'Sin Dato','Santa Rosa 1564',346),(9,'Via Chile Containers','Juan B. Justo 415',443),(10,'Full Toner','Cordoba 246',443),(11,'Via Chile Containers','Vicealte O Connor 847',491),(12,'Central Rosario Srl','San Martin 4816',513),(13,'María Rivarola','Santiago Del Estero 1020',575),(14,'Río Full Net','Belgrano 244',565);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-22 14:07:23
