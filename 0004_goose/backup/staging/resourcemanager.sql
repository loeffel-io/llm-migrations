-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: earth-resourcemanager-service
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
INSERT  IGNORE INTO `languages` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'de','2025-11-22 14:18:45.459','2025-11-22 14:18:45.459'),(2,'en','2025-11-22 14:18:45.470','2025-11-22 14:18:45.470');
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
INSERT  IGNORE INTO `project_config_languages` (`project_config_id`, `language_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,1,'2025-11-22 14:18:45.463','2025-11-22 14:18:45.463'),(1,2,0,'2025-11-22 14:18:45.494','2025-11-22 14:18:45.494');
/*!40000 ALTER TABLE `project_config_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_configs`
--

LOCK TABLES `project_configs` WRITE;
/*!40000 ALTER TABLE `project_configs` DISABLE KEYS */;
INSERT  IGNORE INTO `project_configs` (`id`, `project_id`, `display_name`, `created_at`, `updated_at`) VALUES (1,1,'Mindful','2025-11-22 14:18:45.453','2026-06-08 05:41:04.107');
/*!40000 ALTER TABLE `project_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_policies`
--

LOCK TABLES `project_policies` WRITE;
/*!40000 ALTER TABLE `project_policies` DISABLE KEYS */;
INSERT  IGNORE INTO `project_policies` (`id`, `project_id`, `created_at`, `updated_at`) VALUES (1,1,'2025-11-22 14:18:45.516','2026-06-08 05:41:04.162');
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
INSERT  IGNORE INTO `project_policy_binding_accounts` (`id`, `project_policy_binding_id`, `account_email`, `order`, `created_at`, `updated_at`) VALUES (1,4,'lucas@mindful.com',0,'2025-12-17 16:04:33.889','2025-12-17 16:04:33.889'),(2,4,'noah@mindful.com',1,'2025-12-17 16:04:33.889','2025-12-17 16:04:33.889'),(3,4,'lukas@mindful.com',2,'2026-05-05 15:53:40.606','2026-05-05 15:53:40.606');
/*!40000 ALTER TABLE `project_policy_binding_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `project_policy_bindings`
--

LOCK TABLES `project_policy_bindings` WRITE;
/*!40000 ALTER TABLE `project_policy_bindings` DISABLE KEYS */;
INSERT  IGNORE INTO `project_policy_bindings` (`id`, `project_policy_id`, `role_rid`, `order`, `created_at`, `updated_at`, `all_accounts`, `all_authenticated_accounts`) VALUES (4,1,'admin',0,'2025-12-17 16:04:33.884','2025-12-17 16:04:33.884',0,0),(5,1,'customer',1,'2025-12-17 16:04:33.981','2025-12-17 16:04:33.981',0,1),(6,1,'guest',2,'2025-12-17 16:04:33.986','2025-12-17 16:04:33.986',1,0);
/*!40000 ALTER TABLE `project_policy_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT  IGNORE INTO `projects` (`id`, `rid`, `display_name`, `domain`, `tenant_id`, `created_at`, `updated_at`) VALUES (1,'mindful','Mindful','staging.mindful.com','mindful-i0u7b','2025-11-22 14:18:45.416','2026-06-08 05:41:04.016');
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

-- Dump completed on 2026-06-09 13:50:31
