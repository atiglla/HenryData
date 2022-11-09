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
-- Table structure for table `sucursal`
--

DROP TABLE IF EXISTS `sucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursal` (
  `IdSucursal` int NOT NULL,
  `Sucursal` varchar(40) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `Domicilio` varchar(150) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `IdLocalidad` int NOT NULL DEFAULT '0',
  `Latitud` decimal(13,10) NOT NULL DEFAULT '0.0000000000',
  `Longitud` decimal(13,10) NOT NULL DEFAULT '0.0000000000',
  PRIMARY KEY (`IdSucursal`),
  KEY `IdLocalidad` (`IdLocalidad`),
  CONSTRAINT `sucursal_fk_localidad` FOREIGN KEY (`IdLocalidad`) REFERENCES `localidad` (`IdLocalidad`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursal`
--

LOCK TABLES `sucursal` WRITE;
/*!40000 ALTER TABLE `sucursal` DISABLE KEYS */;
INSERT INTO `sucursal` VALUES (1,'Cabildo','Av. Cabildo 1342',55,-34.5678060000,-58.4495720000),(2,'Palermo 1','Guatemala 5701',55,-34.5790350000,-58.4335660000),(3,'Palermo 2','Gral. Lucio Norberto Mansilla 2668',55,-34.5959660000,-58.4051500000),(4,'Corrientes','Av. Corrientes 2352',55,-34.6046850000,-58.3987640000),(5,'Almagro','Venezuela 3650',55,-34.6173080000,-58.4161790000),(6,'Caballito','Av. Rivadavia 4708',55,-34.6163030000,-58.4318490000),(7,'Flores','Av. Rivadavia 5746',55,-34.6228680000,-58.4464490000),(8,'Alberdi','Av. Juan Bautista Alberdi 1634',55,-34.6273060000,-58.4514980000),(9,'Deposito','Pedernera 530',55,-34.6351340000,-58.4615130000),(10,'Velez','Av. Juan Bautista Justo 7738',55,-34.6312570000,-58.4980630000),(11,'Vicente Lopez','Av. Maipú 829',281,-34.5301030000,-58.4800660000),(12,'San Isidro','Av. Sta Fe 2552',213,-34.4944020000,-58.4979510000),(13,'Caseros','Justo José De Urquiza 4770',61,-34.6059480000,-58.5633190000),(14,'Moron','Salta 250',220,-34.6458960000,-58.6211490000),(15,'Castelar','Sta Rosa 1845',62,-34.6393040000,-58.6556710000),(16,'San Justo','Av. Dr. Ignacio Arieta 3451',260,-34.6813890000,-58.5569190000),(17,'Lanus','Pres. Tte. Gral. Juan Domingo Perón 3270',175,-34.6698050000,-58.4113120000),(18,'Avellaneda','Av. Bartolomé Mitre 612',18,-34.6610600000,-58.3665150000),(19,'Quilmes','Peatonal Rivadavia 185',237,-34.7222530000,-58.2575760000),(20,'La Plata','Calle 48 974',170,-34.9207770000,-57.9588890000),(21,'Mdq1','San Martín 2544',207,-37.9996910000,-57.5463900000),(22,'Mdq2','Belgrano 2847',207,-37.9997630000,-57.5505770000),(23,'Rosario1','Av. Pellegrini 1138',513,-32.9570300000,-60.6413540000),(24,'Rosario2','Rueda 6349',513,-32.9627480000,-60.7076290000),(25,'Córdoba Centro','Av Colón 251',346,-31.4127470000,-64.1864580000),(26,'Córdoba Quiroz','Av Duarte Quirós 2910',346,-31.4075380000,-64.2217380000),(27,'Cerro De Las Rosas','Av. Rafael Núñez 4764',346,-31.3612540000,-64.2378170000),(28,'Tucumán','Av. Sarmiento 525',575,-26.8180450000,-65.2040710000),(29,'Mendoza1','Gutiérrez 349',443,-32.8875310000,-68.8433080000),(30,'Mendoza2','Av. Colón 255',443,-32.8942920000,-68.8438020000),(31,'Bariloche','Mitre 252',491,-41.1338280000,-71.3063650000);
/*!40000 ALTER TABLE `sucursal` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-22 14:07:24
