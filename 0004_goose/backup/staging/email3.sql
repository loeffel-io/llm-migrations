-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: earth-email-service
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
-- Dumping data for table `email_configs`
--

LOCK TABLES `email_configs` WRITE;
/*!40000 ALTER TABLE `email_configs` DISABLE KEYS */;
INSERT  IGNORE INTO `email_configs` (`id`, `project_rid`, `email_local_part`, `created_at`, `updated_at`) VALUES (1,'mindful','noreply','2026-06-09 10:16:28.735','2026-06-09 10:16:28.735');
/*!40000 ALTER TABLE `email_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `email_send_email_outboxes`
--

LOCK TABLES `email_send_email_outboxes` WRITE;
/*!40000 ALTER TABLE `email_send_email_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_send_email_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT  IGNORE INTO `email_templates` (`id`, `email_id`, `rid`, `display_name`, `language_rid`, `subject`, `body`, `created_at`, `updated_at`) VALUES (1,1,'email-login-en','Email login english','en','Login',_binary '\nprojectConfig {{ .projectConfig }}<br>\nlogin {{ .login }}\n			','2026-06-09 10:16:29.001','2026-06-09 10:16:29.001'),(2,2,'welcome-en','Welcome english','en','Hello {{ .user.displayName }}',_binary '\nHallo {{ .user }}\n			','2026-06-09 10:16:29.017','2026-06-09 10:16:29.017'),(3,3,'membership-invitation-en','Membership invitation english','en','Invitation',_binary '\nOrganization {{ .organization }}<br>\nMembershipInvitation <strong>{{ .membershipInvitation }}</strong>\n			','2026-06-09 10:16:29.105','2026-06-09 10:16:29.105');
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT  IGNORE INTO `emails` (`id`, `project_rid`, `rid`, `display_name`, `created_at`, `updated_at`) VALUES (1,'mindful','email-login','Email login','2026-06-09 10:16:28.759','2026-06-09 10:16:28.759'),(2,'mindful','welcome','Welcome','2026-06-09 10:16:28.904','2026-06-09 10:16:28.904'),(3,'mindful','membership-invitation','Membership invitation','2026-06-09 10:16:28.915','2026-06-09 10:16:28.915');
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `goose_db_version`
--

LOCK TABLES `goose_db_version` WRITE;
/*!40000 ALTER TABLE `goose_db_version` DISABLE KEYS */;
INSERT  IGNORE INTO `goose_db_version` (`id`, `version_id`, `is_applied`, `tstamp`) VALUES (1,0,1,'2026-06-09 10:16:27'),(2,20260525115743,1,'2026-06-09 10:16:28'),(3,20260525115744,1,'2026-06-09 10:16:28'),(4,20260525115745,1,'2026-06-09 10:16:28'),(5,20260525115746,1,'2026-06-09 10:16:28'),(6,20260525115747,1,'2026-06-09 10:16:28'),(7,20260525115748,1,'2026-06-09 10:16:28');
/*!40000 ALTER TABLE `goose_db_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `operation_subscriptions`
--

LOCK TABLES `operation_subscriptions` WRITE;
/*!40000 ALTER TABLE `operation_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `operation_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09 13:11:16
