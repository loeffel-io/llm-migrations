-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: master
-- ------------------------------------------------------
-- Server version	8.0.31-google

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT  IGNORE INTO `languages` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'en','2025-10-12 16:51:08.439','2025-10-12 16:51:08.439'),(2,'de','2025-10-12 16:51:08.451','2025-10-12 16:51:08.451'),(3,'af','2025-11-07 12:09:26.099','2025-11-07 12:09:26.099'),(4,'el','2025-11-07 12:09:26.115','2025-11-07 12:09:26.115'),(5,'am','2025-11-07 12:09:26.156','2025-11-07 12:09:26.156');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_batch_write_tuples_outboxes`
--

LOCK TABLES `project_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `project_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_config_languages`
--

LOCK TABLES `project_config_languages` WRITE;
/*!40000 ALTER TABLE `project_config_languages` DISABLE KEYS */;
INSERT  IGNORE INTO `project_config_languages` (`project_config_id`, `language_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2025-10-12 16:51:08.443','2026-03-14 22:02:18.771'),(1,2,1,'2025-10-12 16:51:08.504','2026-03-14 22:02:18.775');
/*!40000 ALTER TABLE `project_config_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_configs`
--

LOCK TABLES `project_configs` WRITE;
/*!40000 ALTER TABLE `project_configs` DISABLE KEYS */;
INSERT  IGNORE INTO `project_configs` (`id`, `project_id`, `display_name`, `created_at`, `updated_at`) VALUES (1,1,'Mindful','2025-10-12 16:51:08.433','2026-06-05 15:51:02.991');
/*!40000 ALTER TABLE `project_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_policies`
--

LOCK TABLES `project_policies` WRITE;
/*!40000 ALTER TABLE `project_policies` DISABLE KEYS */;
INSERT  IGNORE INTO `project_policies` (`id`, `project_id`, `created_at`, `updated_at`) VALUES (1,1,'2025-10-12 16:51:08.524','2026-06-05 15:51:03.168');
/*!40000 ALTER TABLE `project_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_policy_batch_write_tuples_outboxes`
--

LOCK TABLES `project_policy_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `project_policy_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_policy_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_policy_binding_accounts`
--

LOCK TABLES `project_policy_binding_accounts` WRITE;
/*!40000 ALTER TABLE `project_policy_binding_accounts` DISABLE KEYS */;
INSERT  IGNORE INTO `project_policy_binding_accounts` (`id`, `project_policy_binding_id`, `account_email`, `order`, `created_at`, `updated_at`) VALUES (1,19,'lucas@mindful.com',0,'2025-12-17 15:50:35.057','2025-12-17 15:50:35.057'),(2,19,'noah@mindful.com',1,'2025-12-17 15:50:35.057','2025-12-17 15:50:35.057'),(3,19,'lukas@mindful.com',2,'2026-05-05 15:52:29.415','2026-05-05 15:52:29.415');
/*!40000 ALTER TABLE `project_policy_binding_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_policy_bindings`
--

LOCK TABLES `project_policy_bindings` WRITE;
/*!40000 ALTER TABLE `project_policy_bindings` DISABLE KEYS */;
INSERT  IGNORE INTO `project_policy_bindings` (`id`, `project_policy_id`, `role_rid`, `order`, `created_at`, `updated_at`, `all_accounts`, `all_authenticated_accounts`) VALUES (19,1,'admin',0,'2025-12-17 15:50:35.053','2025-12-17 15:50:35.053',0,0),(20,1,'customer',1,'2025-12-17 15:50:35.065','2025-12-17 15:50:35.065',0,1),(21,1,'guest',2,'2025-12-17 15:50:35.070','2025-12-17 15:50:35.070',1,0);
/*!40000 ALTER TABLE `project_policy_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT  IGNORE INTO `projects` (`id`, `rid`, `display_name`, `domain`, `tenant_id`, `created_at`, `updated_at`) VALUES (1,'mindful','Mindful','dev.mindful.com','mindful-sijsm','2025-10-12 16:51:08.391','2026-06-05 15:51:02.940');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09 11:21:28
