-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: earth-user-service
-- ------------------------------------------------------
-- Server version	8.4.8-google

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
-- Dumping data for table `goose_db_version`
--

LOCK TABLES `goose_db_version` WRITE;
/*!40000 ALTER TABLE `goose_db_version` DISABLE KEYS */;
INSERT  IGNORE INTO `goose_db_version` (`id`, `version_id`, `is_applied`, `tstamp`) VALUES (1,0,1,'2026-06-09 11:33:14'),(2,20260527055214,1,'2026-06-09 11:33:14'),(3,20260527055215,1,'2026-06-09 11:33:14'),(4,20260527055216,1,'2026-06-09 11:33:15'),(5,20260527055217,1,'2026-06-09 11:33:15'),(6,20260527055218,1,'2026-06-09 11:33:15'),(7,20260527055219,1,'2026-06-09 11:33:15'),(8,20260527055220,1,'2026-06-09 11:33:15'),(9,20260527055221,1,'2026-06-09 11:33:15'),(10,20260527055222,1,'2026-06-09 11:33:15'),(11,20260527055223,1,'2026-06-09 11:33:15'),(12,20260527055224,1,'2026-06-09 11:33:15'),(13,20260527055225,1,'2026-06-09 11:33:15'),(14,20260527055226,1,'2026-06-09 11:33:15'),(15,20260527055227,1,'2026-06-09 11:33:15');
/*!40000 ALTER TABLE `goose_db_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT  IGNORE INTO `languages` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'de','2026-06-09 11:33:16.016','2026-06-09 11:33:16.016'),(2,'en','2025-11-26 11:07:04.021','2025-11-26 11:07:04.021');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `membership_batch_write_tuples_outboxes`
--

LOCK TABLES `membership_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `membership_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `membership_invitation_batch_write_tuples_outboxes`
--

LOCK TABLES `membership_invitation_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `membership_invitation_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_invitation_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `membership_invitation_send_email_outboxes`
--

LOCK TABLES `membership_invitation_send_email_outboxes` WRITE;
/*!40000 ALTER TABLE `membership_invitation_send_email_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_invitation_send_email_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `membership_invitations`
--

LOCK TABLES `membership_invitations` WRITE;
/*!40000 ALTER TABLE `membership_invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
/*!40000 ALTER TABLE `memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organization_batch_write_tuples_outboxes`
--

LOCK TABLES `organization_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `organization_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT  IGNORE INTO `profiles` (`id`, `user_id`, `username`, `biography`, `location`, `image`, `created_at`, `updated_at`) VALUES (1,1,'loeffel-io',NULL,NULL,0,'2026-06-09 11:36:25.156','2026-06-09 11:36:25.156'),(3,3,'ThuyNguyen','cooking - travelling - reading',NULL,0,'2025-11-28 11:25:07.658','2025-12-05 15:07:21.440'),(4,4,'thanhbinh84','Love to be loved by you ',NULL,0,'2025-12-01 12:36:53.058','2025-12-02 15:34:14.577'),(5,5,NULL,NULL,NULL,0,'2025-12-02 16:16:57.150','2025-12-02 16:16:57.150'),(6,9,'thanhbinh','Love to be loved ',NULL,0,'2025-12-04 10:05:40.998','2025-12-04 10:05:58.084'),(7,10,'thanhbinh',NULL,NULL,0,'2025-12-04 10:36:28.422','2025-12-04 10:36:39.377'),(9,25,'Binh',NULL,NULL,0,'2026-01-20 08:58:33.316','2026-01-20 08:58:51.851'),(12,29,'Thea','This demonstrates the case that user has location and over 2 finished program',NULL,1,'2026-01-23 10:10:59.485','2026-02-06 09:54:36.480'),(13,30,'Thea','This demonstrates the case that user has location and over 2 finished program',NULL,0,'2026-01-23 10:17:00.314','2026-02-06 16:09:30.393'),(14,31,'Thuy041',NULL,NULL,0,'2026-01-23 14:30:23.854','2026-01-23 14:30:33.191'),(15,32,'thuy0501',NULL,NULL,0,'2026-01-23 14:33:02.464','2026-01-23 14:33:15.862'),(16,33,'Thuy08',NULL,NULL,0,'2026-01-26 11:13:13.493','2026-01-26 11:13:26.563'),(17,34,'Thuy09',NULL,NULL,0,'2026-01-26 11:34:42.711','2026-01-26 11:34:56.100'),(19,36,'Thea',NULL,NULL,0,'2026-01-27 09:31:04.368','2026-01-27 09:31:14.851'),(20,37,'Thea',NULL,NULL,0,'2026-01-27 15:22:03.758','2026-01-27 15:22:12.511'),(21,38,'Thea',NULL,NULL,0,'2026-01-27 15:29:46.463','2026-01-27 15:30:01.787'),(22,39,'Thea',NULL,NULL,0,'2026-01-27 16:08:44.456','2026-01-27 16:08:53.330'),(23,40,'Thea',NULL,NULL,0,'2026-01-27 16:17:44.123','2026-01-27 16:17:47.790'),(24,41,'Thea',NULL,NULL,0,'2026-01-27 16:22:56.136','2026-01-27 16:23:03.379'),(25,42,'lukasmankow',NULL,NULL,1,'2026-01-28 09:28:08.456','2026-06-01 21:26:15.639'),(27,45,'Thea',NULL,NULL,0,'2026-01-30 09:19:08.731','2026-01-30 09:19:17.904'),(28,46,'lukasmankowndb','hallo ',NULL,0,'2026-01-30 12:38:28.356','2026-01-30 12:39:19.115'),(29,47,'Thea',NULL,NULL,0,'2026-02-02 10:28:03.964','2026-02-02 10:28:11.981'),(30,48,'Thea',NULL,NULL,0,'2026-02-02 10:31:05.924','2026-02-02 10:31:17.767'),(31,49,'Thea',NULL,NULL,0,'2026-02-06 09:44:25.578','2026-02-06 09:44:34.859'),(32,50,'Thea','This demonstrates the case that user has location and over 2 finished program',NULL,0,'2026-02-06 15:55:08.821','2026-02-06 15:57:46.120'),(35,53,NULL,NULL,NULL,0,'2026-02-09 12:09:15.245','2026-02-09 12:09:52.583'),(37,55,NULL,'This demonstrates the case that user has location and over 2 finished program',NULL,1,'2026-02-09 15:35:05.803','2026-02-10 11:02:30.768'),(38,56,'thea',NULL,NULL,1,'2026-02-10 11:04:17.838','2026-02-10 11:07:10.088'),(39,57,'Thea',NULL,NULL,1,'2026-02-10 11:11:49.263','2026-02-10 11:18:56.595'),(40,58,'Thea',NULL,NULL,1,'2026-02-10 11:43:34.323','2026-02-10 11:44:26.246'),(41,59,'Thea',NULL,NULL,1,'2026-02-10 11:50:08.757','2026-02-10 14:15:04.861'),(42,60,'Thea',NULL,NULL,1,'2026-02-10 14:20:37.190','2026-02-10 14:21:28.025'),(43,61,'thea',NULL,NULL,1,'2026-02-10 14:27:08.524','2026-02-10 14:28:09.034'),(44,62,'Thea',NULL,NULL,1,'2026-02-10 14:34:21.633','2026-02-10 14:35:36.777'),(46,64,'Thea',NULL,NULL,1,'2026-02-10 14:40:37.979','2026-02-10 14:41:26.078'),(47,65,'Thea',NULL,NULL,1,'2026-02-10 14:43:55.502','2026-02-10 14:44:45.759'),(48,66,'Thea',NULL,NULL,1,'2026-02-10 15:09:10.656','2026-02-10 15:09:48.647'),(49,67,'Thea',NULL,NULL,1,'2026-02-10 15:16:57.281','2026-02-10 15:18:27.777'),(50,68,'Thea',NULL,NULL,1,'2026-02-10 15:22:05.735','2026-02-10 15:22:41.774'),(51,69,'Thea',NULL,NULL,1,'2026-02-10 15:25:35.729','2026-02-10 15:26:16.175'),(52,70,'Thea',NULL,NULL,1,'2026-02-10 15:33:30.532','2026-02-10 15:33:48.037'),(53,71,'Thea',NULL,NULL,1,'2026-02-10 15:37:15.918','2026-02-10 15:38:18.276'),(54,72,'Thea',NULL,NULL,1,'2026-02-10 15:44:36.454','2026-02-10 15:45:36.007'),(55,73,'Thea','This demonstrates the case that user has location and over 2 finished program',NULL,1,'2026-02-10 15:48:26.060','2026-02-10 15:49:41.010'),(56,74,'Thea',NULL,NULL,1,'2026-02-10 15:51:50.390','2026-02-10 15:53:08.811'),(57,75,'Thea',NULL,NULL,1,'2026-02-10 15:55:00.925','2026-02-10 15:56:16.925'),(58,76,'Thea',NULL,NULL,1,'2026-02-10 15:57:52.833','2026-02-10 15:58:13.849'),(59,77,'Thea',NULL,NULL,0,'2026-02-10 16:00:25.760','2026-02-10 16:00:29.533'),(60,78,'Thea',NULL,NULL,0,'2026-02-10 16:03:26.485','2026-02-10 16:03:30.488'),(61,79,'Thea',NULL,NULL,0,'2026-02-10 16:05:37.247','2026-02-10 16:05:41.137'),(62,80,'Thea',NULL,NULL,1,'2026-02-10 16:09:47.535','2026-02-11 08:21:45.819'),(63,81,'Thea1',NULL,NULL,1,'2026-02-11 08:24:11.836','2026-02-11 08:27:06.798'),(64,82,'Thelisa',NULL,NULL,1,'2026-02-11 08:32:31.519','2026-02-13 16:37:57.309'),(65,83,'The',NULL,NULL,1,'2026-02-11 11:21:12.016','2026-02-11 12:13:32.371'),(66,84,'1',NULL,NULL,1,'2026-02-11 12:16:11.927','2026-02-11 12:21:21.840'),(69,87,'Anna',NULL,NULL,1,'2026-02-11 14:39:19.965','2026-02-11 14:42:43.780'),(70,88,'Na',NULL,NULL,1,'2026-02-11 14:45:37.902','2026-02-11 14:47:09.525'),(71,89,'2',NULL,NULL,1,'2026-02-11 15:10:54.813','2026-02-11 15:12:46.581'),(72,90,'3',NULL,NULL,1,'2026-02-11 15:14:07.037','2026-02-11 15:16:12.713'),(73,91,'Bean',NULL,NULL,1,'2026-02-11 15:20:24.235','2026-02-11 15:21:26.676'),(76,94,'Thea2',NULL,NULL,1,'2026-02-13 14:22:51.522','2026-02-13 14:28:08.849'),(77,95,'Thea3',NULL,NULL,1,'2026-02-13 14:29:33.970','2026-02-13 14:31:16.541'),(78,96,'Thea4',NULL,NULL,1,'2026-02-13 14:34:11.891','2026-02-13 14:34:53.890'),(79,97,'Thea5',NULL,NULL,1,'2026-02-13 14:46:34.658','2026-02-13 14:59:01.735'),(80,98,'Thea6',NULL,NULL,1,'2026-02-13 14:59:52.512','2026-02-13 15:09:07.439'),(81,99,'Thea7',NULL,NULL,1,'2026-02-13 15:13:30.140','2026-02-13 15:14:52.517'),(82,100,'Thea8',NULL,NULL,1,'2026-02-13 15:17:14.948','2026-02-13 15:18:09.409'),(83,101,'Thea9',NULL,NULL,1,'2026-02-13 15:19:34.845','2026-02-13 15:20:03.485'),(88,106,'10',NULL,NULL,1,'2026-02-20 16:30:08.804','2026-03-06 15:45:37.790'),(89,107,NULL,NULL,NULL,0,'2026-02-24 10:41:54.374','2026-02-24 10:41:54.374'),(92,110,NULL,NULL,NULL,0,'2026-03-06 15:48:06.313','2026-03-06 15:48:06.313'),(93,111,NULL,NULL,NULL,0,'2026-03-06 16:01:20.979','2026-03-06 16:01:20.979'),(94,112,'Thea0304',NULL,NULL,1,'2026-03-06 16:06:05.654','2026-03-06 16:47:17.568'),(95,113,'0503',NULL,NULL,1,'2026-03-12 07:48:28.445','2026-03-12 07:49:24.390'),(96,114,'Thea0604',NULL,NULL,1,'2026-03-12 07:57:57.130','2026-03-12 07:58:53.801'),(97,115,'bbvf',NULL,NULL,1,'2026-03-27 13:54:37.037','2026-05-06 14:25:43.499'),(102,120,'thanhbinh1984',NULL,NULL,0,'2026-04-28 14:02:30.178','2026-04-28 14:03:04.757'),(104,122,'thanhbinh11984',NULL,NULL,1,'2026-05-04 11:27:07.598','2026-05-04 11:47:44.293'),(105,123,NULL,NULL,NULL,0,'2026-05-05 16:26:13.500','2026-05-05 16:26:13.500'),(106,124,NULL,NULL,NULL,0,'2026-05-06 20:23:01.962','2026-05-06 20:23:01.962'),(107,125,NULL,NULL,NULL,0,'2026-05-08 23:50:52.902','2026-05-08 23:50:52.902'),(108,126,NULL,NULL,NULL,0,'2026-05-08 23:53:15.898','2026-05-08 23:53:15.898'),(109,127,NULL,NULL,NULL,0,'2026-05-08 23:55:25.108','2026-05-08 23:55:25.108'),(110,128,NULL,NULL,NULL,0,'2026-05-09 00:46:43.099','2026-05-09 00:46:43.099'),(111,129,NULL,NULL,NULL,0,'2026-05-09 15:20:56.590','2026-05-09 15:20:56.590'),(112,130,NULL,NULL,NULL,0,'2026-05-09 15:30:51.040','2026-05-09 15:30:51.040'),(113,131,NULL,NULL,NULL,0,'2026-06-03 19:52:43.696','2026-06-03 19:52:43.696'),(114,132,'dragana',NULL,NULL,0,'2026-06-04 09:51:58.606','2026-06-04 09:52:07.080'),(115,133,'draaagna',NULL,NULL,0,'2026-06-05 09:14:37.795','2026-06-05 09:15:01.233');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_batch_write_tuples_outboxes`
--

LOCK TABLES `user_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `user_batch_write_tuples_outboxes` DISABLE KEYS */;
INSERT  IGNORE INTO `user_batch_write_tuples_outboxes` (`id`, `project_rid`, `rid`, `request`, `fails`, `locked_at`, `created_at`, `updated_at`) VALUES (1,'mindful','lucas',_binary '\n#projects/mindful/authorizationModelC\naccount:lucas@mindful.comaccount\Zgroup:all-authenticated-users?\nrole:user-user-adminrole\Z!userBinding:lucas/user-user-adminG\naccount:lucas@mindful.comaccount\Z!userBinding:lucas/user-user-adminB\n!userBinding:lucas/user-user-adminuserBinding\ZuserPolicy:lucas*\nuserPolicy:lucas\nuserPolicy\Z\nuser:lucas#\n\nuser:lucasuser\Zproject:mindful',10,NULL,'2026-06-09 11:33:16.658','2026-06-09 11:33:39.889'),(6,'mindful','TEJo2MwxNsaIgTWvJGvahQ7BHB93',_binary '\n#projects/mindful/authorizationModelG\naccount:thanhbinh84@yahoo.comaccount\Zgroup:all-authenticated-usersV\nrole:user-user-adminrole\Z8userBinding:TEJo2MwxNsaIgTWvJGvahQ7BHB93/user-user-adminb\naccount:thanhbinh84@yahoo.comaccount\Z8userBinding:TEJo2MwxNsaIgTWvJGvahQ7BHB93/user-user-adminp\n8userBinding:TEJo2MwxNsaIgTWvJGvahQ7BHB93/user-user-adminuserBinding\Z\'userPolicy:TEJo2MwxNsaIgTWvJGvahQ7BHB93X\n\'userPolicy:TEJo2MwxNsaIgTWvJGvahQ7BHB93\nuserPolicy\Z!user:TEJo2MwxNsaIgTWvJGvahQ7BHB93:\n!user:TEJo2MwxNsaIgTWvJGvahQ7BHB93user\Zproject:mindful',10,NULL,'2025-12-02 16:16:58.131','2025-12-02 16:17:09.016');
/*!40000 ALTER TABLE `user_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_languages`
--

LOCK TABLES `user_languages` WRITE;
/*!40000 ALTER TABLE `user_languages` DISABLE KEYS */;
INSERT  IGNORE INTO `user_languages` (`user_id`, `language_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2026-06-09 11:33:16.018','2026-06-09 11:33:16.018'),(3,2,0,'2025-11-28 11:25:08.664','2025-11-28 11:25:08.664'),(4,2,0,'2025-12-01 12:36:53.365','2025-12-01 12:36:53.365'),(5,2,0,'2025-12-02 16:16:57.371','2025-12-02 16:16:57.371'),(9,2,0,'2025-12-04 10:05:41.412','2025-12-04 10:05:41.412'),(10,2,0,'2025-12-04 10:36:29.039','2025-12-04 10:36:29.039'),(25,2,0,'2026-01-20 08:58:33.658','2026-01-20 08:58:33.658'),(29,2,0,'2026-01-23 10:10:59.503','2026-01-23 10:10:59.503'),(30,2,0,'2026-01-23 10:17:00.361','2026-01-23 10:17:00.361'),(31,2,0,'2026-01-23 14:30:24.184','2026-01-23 14:30:24.184'),(32,2,0,'2026-01-23 14:33:02.566','2026-01-23 14:33:02.566'),(33,2,0,'2026-01-26 11:13:13.677','2026-01-26 11:13:13.677'),(34,2,0,'2026-01-26 11:34:43.108','2026-01-26 11:34:43.108'),(36,2,0,'2026-01-27 09:31:04.488','2026-01-27 09:31:04.488'),(37,2,0,'2026-01-27 15:22:04.126','2026-01-27 15:22:04.126'),(38,2,0,'2026-01-27 15:29:46.783','2026-01-27 15:29:46.783'),(39,2,0,'2026-01-27 16:08:44.796','2026-01-27 16:08:44.796'),(40,2,0,'2026-01-27 16:17:44.138','2026-01-27 16:17:44.138'),(41,2,0,'2026-01-27 16:22:56.168','2026-01-27 16:22:56.168'),(42,1,0,'2026-05-22 08:18:02.559','2026-05-22 08:18:02.559'),(45,2,0,'2026-01-30 09:19:09.056','2026-01-30 09:19:09.056'),(46,2,0,'2026-01-30 12:38:28.762','2026-01-30 12:38:28.762'),(47,2,0,'2026-02-02 10:28:04.208','2026-02-02 10:28:04.208'),(48,2,0,'2026-02-02 10:31:05.960','2026-02-02 10:31:05.960'),(49,2,0,'2026-02-06 09:44:25.728','2026-02-06 09:44:25.728'),(50,2,0,'2026-02-06 15:55:09.031','2026-02-06 15:55:09.031'),(53,2,0,'2026-02-09 12:09:15.259','2026-02-09 12:09:15.259'),(55,2,0,'2026-02-09 15:35:06.211','2026-02-09 15:35:06.211'),(56,2,0,'2026-02-10 11:04:17.943','2026-02-10 11:04:17.943'),(57,2,0,'2026-02-10 11:11:50.133','2026-02-10 11:11:50.133'),(58,2,0,'2026-02-10 11:43:34.388','2026-02-10 11:43:34.388'),(59,2,0,'2026-02-10 11:50:08.770','2026-02-10 11:50:08.770'),(60,2,0,'2026-02-10 14:20:37.214','2026-02-10 14:20:37.214'),(61,2,0,'2026-02-10 14:27:08.537','2026-02-10 14:27:08.537'),(62,2,0,'2026-02-10 14:34:21.838','2026-02-10 14:34:21.838'),(64,2,0,'2026-02-10 14:40:38.035','2026-02-10 14:40:38.035'),(65,2,0,'2026-02-10 14:43:55.536','2026-02-10 14:43:55.536'),(66,2,0,'2026-02-10 15:09:10.685','2026-02-10 15:09:10.685'),(67,2,0,'2026-02-10 15:16:57.294','2026-02-10 15:16:57.294'),(68,2,0,'2026-02-10 15:22:05.835','2026-02-10 15:22:05.835'),(69,2,0,'2026-02-10 15:25:35.742','2026-02-10 15:25:35.742'),(70,2,0,'2026-02-10 15:33:30.547','2026-02-10 15:33:30.547'),(71,2,0,'2026-02-10 15:37:15.937','2026-02-10 15:37:15.937'),(72,2,0,'2026-02-10 15:44:36.480','2026-02-10 15:44:36.480'),(73,2,0,'2026-02-10 15:48:26.075','2026-02-10 15:48:26.075'),(74,2,0,'2026-02-10 15:51:50.465','2026-02-10 15:51:50.465'),(75,2,0,'2026-02-10 15:55:00.939','2026-02-10 15:55:00.939'),(76,2,0,'2026-02-10 15:57:52.845','2026-02-10 15:57:52.845'),(77,2,0,'2026-02-10 16:00:25.784','2026-02-10 16:00:25.784'),(78,2,0,'2026-02-10 16:03:26.566','2026-02-10 16:03:26.566'),(79,2,0,'2026-02-10 16:05:37.260','2026-02-10 16:05:37.260'),(80,2,0,'2026-02-10 16:09:47.551','2026-02-10 16:09:47.551'),(81,2,0,'2026-02-11 08:24:12.197','2026-02-11 08:24:12.197'),(82,2,0,'2026-02-11 08:32:31.531','2026-02-11 08:32:31.531'),(83,2,0,'2026-02-11 11:21:12.071','2026-02-11 11:21:12.071'),(84,2,0,'2026-02-11 12:16:11.941','2026-02-11 12:16:11.941'),(87,2,0,'2026-02-11 14:39:19.984','2026-02-11 14:39:19.984'),(88,2,0,'2026-02-11 14:45:37.914','2026-02-11 14:45:37.914'),(89,2,0,'2026-02-11 15:10:54.841','2026-02-11 15:10:54.841'),(90,2,0,'2026-02-11 15:14:07.051','2026-02-11 15:14:07.051'),(91,2,0,'2026-02-11 15:20:24.272','2026-02-11 15:20:24.272'),(94,2,0,'2026-02-13 14:22:51.754','2026-02-13 14:22:51.754'),(95,2,0,'2026-02-13 14:29:34.542','2026-02-13 14:29:34.542'),(96,2,0,'2026-02-13 14:34:11.904','2026-02-13 14:34:11.904'),(97,2,0,'2026-02-13 14:46:34.687','2026-02-13 14:46:34.687'),(98,2,0,'2026-02-13 14:59:52.529','2026-02-13 14:59:52.529'),(99,2,0,'2026-02-13 15:13:30.188','2026-02-13 15:13:30.188'),(100,2,0,'2026-02-13 15:17:14.969','2026-02-13 15:17:14.969'),(101,2,0,'2026-02-13 15:19:34.857','2026-02-13 15:19:34.857'),(106,2,0,'2026-02-20 16:30:09.064','2026-02-20 16:30:09.064'),(107,2,0,'2026-02-24 10:41:54.731','2026-02-24 10:41:54.731'),(110,1,1,'2026-03-06 15:48:06.947','2026-03-06 15:48:06.947'),(110,2,0,'2026-03-06 15:48:06.958','2026-03-06 15:48:06.958'),(111,1,1,'2026-03-06 16:01:21.060','2026-03-06 16:01:21.060'),(111,2,0,'2026-03-06 16:01:21.053','2026-03-06 16:01:21.053'),(112,1,1,'2026-03-06 16:06:05.756','2026-03-06 16:06:05.756'),(112,2,0,'2026-03-06 16:06:05.749','2026-03-06 16:06:05.749'),(113,1,1,'2026-03-12 07:48:28.806','2026-03-12 07:48:28.806'),(113,2,0,'2026-03-12 07:48:28.711','2026-03-12 07:48:28.711'),(114,1,1,'2026-03-12 07:57:57.313','2026-03-12 07:57:57.313'),(114,2,0,'2026-03-12 07:57:57.307','2026-03-12 07:57:57.307'),(115,1,0,'2026-05-13 16:45:15.385','2026-05-13 16:45:15.385'),(120,2,0,'2026-05-06 15:05:29.906','2026-05-06 15:05:29.906'),(122,1,0,'2026-05-07 10:49:17.530','2026-05-07 10:49:17.530'),(123,1,0,'2026-05-05 16:26:13.900','2026-05-05 16:26:13.900'),(123,2,1,'2026-05-05 16:26:14.000','2026-05-05 16:26:14.000'),(124,1,0,'2026-05-06 20:23:02.113','2026-05-06 20:23:02.113'),(125,1,0,'2026-05-08 23:50:53.240','2026-05-08 23:50:53.240'),(126,1,0,'2026-05-08 23:53:15.942','2026-05-08 23:53:15.942'),(127,1,0,'2026-05-08 23:55:25.124','2026-05-08 23:55:25.124'),(128,1,0,'2026-05-09 00:46:43.543','2026-05-09 00:46:43.543'),(129,2,0,'2026-05-09 15:20:57.045','2026-05-09 15:20:57.045'),(130,2,0,'2026-05-09 15:30:51.445','2026-05-09 15:30:51.445'),(131,2,0,'2026-06-03 19:52:44.223','2026-06-03 19:52:44.223'),(132,1,0,'2026-06-04 09:51:58.766','2026-06-04 09:51:58.766'),(133,1,0,'2026-06-05 09:14:37.929','2026-06-05 09:14:37.929');
/*!40000 ALTER TABLE `user_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_send_email_outboxes`
--

LOCK TABLES `user_send_email_outboxes` WRITE;
/*!40000 ALTER TABLE `user_send_email_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_send_email_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_update_account_outboxes`
--

LOCK TABLES `user_update_account_outboxes` WRITE;
/*!40000 ALTER TABLE `user_update_account_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_update_account_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT  IGNORE INTO `users` (`id`, `project_rid`, `rid`, `display_name`, `email`, `created_at`, `updated_at`) VALUES (1,'mindful','lucas','Lucas Loeffel','lucas@mindful.com','2026-06-09 11:33:16.012','2026-06-09 11:36:25.119'),(3,'mindful','QQmZeb4XeFbyaLnbdZ1m0kLLoXG2','Thuy Nguyen Berlin','banmaisom2002@yahoo.com','2025-11-28 11:25:07.608','2025-12-05 15:07:20.796'),(4,'mindful','hHKa5qI3XiUGZvoxhz22A1JZiRU2','Binh ','nguyenthanhbinh1984@gmail.com','2025-12-01 12:36:53.049','2025-12-02 15:34:14.202'),(5,'mindful','TEJo2MwxNsaIgTWvJGvahQ7BHB93','Binh','thanhbinh84@yahoo.com','2025-12-02 16:16:57.128','2025-12-02 16:16:57.128'),(9,'mindful','XKmalG3kqWT2m4HEyVhcsLTDQSA3','Binh','binh@mindful.com','2025-12-04 10:05:40.971','2025-12-04 10:05:40.971'),(10,'mindful','mRiNPpXa9WhgJXXHZIRisjLb6Qw2','Binh','nguyenthanhbinh1984+a@gmail.com','2025-12-04 10:36:28.393','2025-12-04 10:36:28.393'),(25,'mindful','1DONWj4h48WlIlJ0kMzQCi8z38H2','binh','banmaisom2002+germany@gmail.com','2026-01-20 08:58:33.261','2026-01-20 08:58:33.261'),(29,'mindful','4BHA5J62KjYRlkPuSrUrHtmf1Nt1','Thea','banmaisom2002+2201@gmail.com','2026-01-23 10:10:59.430','2026-02-06 09:56:16.094'),(30,'mindful','aIhoaRv6nSbRfN5f2DGafaWzMvN2','Thea','banmaisom2002+0102@gmail.com','2026-01-23 10:17:00.292','2026-02-06 16:09:29.778'),(31,'mindful','wbC91ABxpfX5EivvmVOkSMwA8zv1','Thuy0401','banmaisom2002+0401@gmail.com','2026-01-23 14:30:23.783','2026-01-23 14:30:23.783'),(32,'mindful','KBEU1E2j8kXhyFnMDYd6WveYJvA3','thuy0501','banmaisom2002+0501@gmail.com','2026-01-23 14:33:02.457','2026-01-23 14:33:02.457'),(33,'mindful','gUh2hPsaoeMInoKacdGAqqKlWQ52','Thuy','banmaisom2002+0801@gmail.com','2026-01-26 11:13:13.438','2026-01-26 11:13:13.438'),(34,'mindful','MaOU0KoDlCbwgBQ3cwnjureywnY2','Thuy','banmaisom2002+0901@gmail.com','2026-01-26 11:34:42.678','2026-01-26 11:34:42.678'),(36,'mindful','sMhJsdEmrlZXWD2p87EQXeBLImW2','Thea','banmaisom2002+1001@gmail.com','2026-01-27 09:31:04.318','2026-01-27 09:31:04.318'),(37,'mindful','zKTMa0QP3sbp6D9f7XPk0doppon1','Thea','banmaisom2002+1101@gmail.com','2026-01-27 15:22:03.671','2026-01-27 15:22:03.671'),(38,'mindful','FCSaEx0mfKepudKRslFy8joCDeb2','Thea','banmaisom2002+1201@gmail.com','2026-01-27 15:29:46.458','2026-01-27 15:29:46.458'),(39,'mindful','YYX0Y99s8CYZVDuBRUA6ZjfihBE2','Thea','banmaisom2002+1301@gmail.com','2026-01-27 16:08:44.391','2026-01-27 16:08:44.391'),(40,'mindful','xF8xO0vJQMdZMjAMMwyjK0wLuAK2','Thea','banmaisom2002+1401@gmail.com','2026-01-27 16:17:44.118','2026-01-27 16:17:44.118'),(41,'mindful','pRnzoL8PZqRfZFFWVwIndLHeH8G2','Thea','banmaisom2002+1601@gmail.com','2026-01-27 16:22:56.111','2026-01-27 16:22:56.111'),(42,'mindful','9jZonvifEedjuBbQvyTN7Z4mtbv2','Lukas','lk.mankow@gmail.com','2026-01-28 09:28:08.402','2026-05-29 07:28:36.877'),(45,'mindful','2bDXjzmlWGcfHahGaAyMEDSCSif2','Thea','banmaisom2002+1901@gmail.com','2026-01-30 09:19:08.693','2026-01-30 09:19:08.693'),(46,'mindful','MgrCE4gVIlSBY915QTccM0qWFS43','Lukas','mankow96@gmail.com','2026-01-30 12:38:28.257','2026-01-30 12:38:28.257'),(47,'mindful','A3gT1xfyc4YmwyLSu47HA9y7NGY2','Thea','banmaisom2002+2002@gmail.com','2026-02-02 10:28:03.858','2026-02-10 15:30:10.535'),(48,'mindful','8syBR9wNA8gE2KaiJXRlRXocB4k2','Thea','banmaisom2002+2102@gmail.com','2026-02-02 10:31:05.915','2026-02-10 15:31:50.648'),(49,'mindful','B7FrswppZDNVhkYc1LMxA4ci6o82','Thea','banmaisom2002+2101@gmail.com','2026-02-06 09:44:25.385','2026-02-06 09:44:25.385'),(50,'mindful','XyjwbvCGi1hYX7GTcPNyeCNqVOu1','Thea','banmaisom2002+3001@gmail.com','2026-02-06 15:55:08.737','2026-02-06 15:57:45.591'),(53,'mindful','7d5Lmfj4ycWqhrVD2yPWeVuCQRS2','Thea','banmaisom2002+0202@gmail.com','2026-02-09 12:09:15.239','2026-02-09 12:09:15.239'),(55,'mindful','ZltZyQb00SN57VqNj2kv849z0Fu2','Thea','banmaisom2002+0302@gmail.com','2026-02-09 15:35:05.748','2026-02-10 11:02:44.472'),(56,'mindful','xKD28qSHkqhkEA52vPMBrJrrqil2','thea','banmaisom2002+0402@gmail.com','2026-02-10 11:04:17.832','2026-02-10 11:09:35.641'),(57,'mindful','mkgkyWcv9bVfGE4hCFh5Jzf6y872','Thea','banmaisom2002+0502@gmail.com','2026-02-10 11:11:49.257','2026-02-10 11:19:18.664'),(58,'mindful','LcOvrFnbu1ToW3s1EQPkXTHBpI73','Thea','banmaisom2002+0602@gmail.com','2026-02-10 11:43:34.304','2026-02-10 11:46:37.434'),(59,'mindful','ob1hMDOo3IhOIKjlTmNheJXQX7N2','Thea','banmaisom2002+0702@gmail.com','2026-02-10 11:50:08.752','2026-02-10 14:18:31.572'),(60,'mindful','q2MNmeom5rYzNly5ZJcVx2Uj5b93','Thea','banmaisom2002+0802@gmail.com','2026-02-10 14:20:37.186','2026-02-10 14:22:20.041'),(61,'mindful','zA3k2ADpqndr69PNMyzC5Xd2nWL2','thea','banmaisom2002+1002@gmail.com','2026-02-10 14:27:08.520','2026-02-10 14:27:08.520'),(62,'mindful','71DHpTs3fZYHnr7HsU9V5LRxZor2','Thea','banmaisom2002+1102@gmail.com','2026-02-10 14:34:21.534','2026-02-10 14:34:21.534'),(64,'mindful','15IkBcIMfXQAbc0lpwqhsIaD5ei1','Thea','banmaisom2002+1302@gmail.com','2026-02-10 14:40:37.975','2026-02-10 14:42:03.833'),(65,'mindful','lpL80QI0YneewsFb8qBbySlOMUt1','Thea','banmaisom2002+1402@gmail.com','2026-02-10 14:43:55.498','2026-02-10 14:45:08.549'),(66,'mindful','IjLdnpuCGwUe7Ro1fBleeJYKob92','Thea','banmaisom2002+1502@gmail.com','2026-02-10 15:09:10.631','2026-02-10 15:09:10.631'),(67,'mindful','0i2n59Jjt0TWrrwfoUomTEtZruX2','Thea','banmaisom2002+1602@gmail.com','2026-02-10 15:16:57.276','2026-02-10 15:16:57.276'),(68,'mindful','Ai4yUuK9ydUIGmSRc4Y4fpq6Ik22','Thea','banmaisom2002+1802@gmail.com','2026-02-10 15:22:05.730','2026-02-10 15:22:05.730'),(69,'mindful','zTlw4gJUd0cHR3juQHIa61bFNb82','Thea','banmaisom2002+1902@gmail.com','2026-02-10 15:25:35.722','2026-02-10 15:25:35.722'),(70,'mindful','w5bAd8zCB1U5FOutgeOhAMOFLbD3','Thea','banmaisom2002+0103@gmail.com','2026-02-10 15:33:30.527','2026-02-10 15:34:13.940'),(71,'mindful','VrqBeT2sptTVgKZG9HDdsIfmlq83','Thea','banmaisom2002+0203@gmail.com','2026-02-10 15:37:15.913','2026-02-10 15:39:55.940'),(72,'mindful','kCXTpBJcQMTKeFb13jaKOwXIkWU2','Thea','banmaisom2002+0303@gmail.com','2026-02-10 15:44:36.450','2026-02-10 15:44:36.450'),(73,'mindful','bU3EvfMODKafQ61H15mhxlqG8Vl2','Thea','banmaisom2002+0403@gmail.com','2026-02-10 15:48:26.056','2026-02-10 15:49:53.844'),(74,'mindful','PwgAbiKfE3SEOmZmzPzMpgjK7op2','Thea','banmaisom2002+0503@gmail.com','2026-02-10 15:51:50.386','2026-02-10 15:51:50.386'),(75,'mindful','OzSTvuibe9MUEiJQyS0jfo2PRYp2','Thea','banmaisom2002+0603@gmail.com','2026-02-10 15:55:00.919','2026-02-10 15:55:00.919'),(76,'mindful','SaiuAIPbYlMEhxOlBQ9VHWx2SBW2','Thea','banmaisom2002+0703@gmail.com','2026-02-10 15:57:52.828','2026-02-10 15:57:52.828'),(77,'mindful','LwaIyiobeQdnHwXQy3r5QEu4MFu2','Thea','banmaisom2002+0803@gmail.com','2026-02-10 16:00:25.756','2026-02-10 16:00:25.756'),(78,'mindful','l0C5epXTLahHdD288E1TbUFcbos1','Thea','banmaisom2002+0903@gmail.com','2026-02-10 16:03:26.482','2026-02-10 16:03:26.482'),(79,'mindful','kboqaEeXp1h8JteMqWH4MOng7wl1','Thea','banmaisom2002+1003@gmail.com','2026-02-10 16:05:37.243','2026-02-10 16:05:37.243'),(80,'mindful','38udt0wmIqNfqiFiVN25irFRwVG3','Thea','banmaisom2002+1103@gmail.com','2026-02-10 16:09:47.517','2026-02-10 16:09:47.517'),(81,'mindful','gc7zrt0mqOW0bVdLRCzkqO0pwMR2','Thea','banmaisom2002+1203@gmail.com','2026-02-11 08:24:11.824','2026-02-11 08:24:11.824'),(82,'mindful','K3ozRy8dqSOhSLnMIyBwlr4lYnh1','Thelisa','banmaisom2002+1303@gmail.com','2026-02-11 08:32:31.515','2026-02-11 08:32:58.996'),(83,'mindful','3H0DIAYtCGPl69dQVaC3hNHcUbj2','Thea','banmaisom2002+1403@gmail.com','2026-02-11 11:21:12.010','2026-02-11 12:13:52.924'),(84,'mindful','hKgfUIyy70YbzIeCoCvMMbObO5Z2','Thea','banmaisom2002+1503@gmail.com','2026-02-11 12:16:11.922','2026-02-11 12:33:38.553'),(87,'mindful','4rl83cDYKdguHgqIVXknk6cFwhh2','Anna','banmaisom2002+1603@gmail.com','2026-02-11 14:39:19.942','2026-02-11 14:43:22.981'),(88,'mindful','g5CeBS8s7bRA4oIXnrUSVJ0YVv62','Na','banmaisom2002+1703@gmail.com','2026-02-11 14:45:37.898','2026-02-11 14:46:39.180'),(89,'mindful','qHrJSrpjFUPMEFPNVv4NlV3qgWK2','2','banmaisom2002+1803@gmail.com','2026-02-11 15:10:54.791','2026-02-11 15:11:12.266'),(90,'mindful','UYAhQVvFxmUMEDsAyeXa6imv6xL2','3','banmaisom2002+1903@gmail.com','2026-02-11 15:14:07.032','2026-02-11 15:14:07.032'),(91,'mindful','rNCN9JwVa1cGKMVc3y09Mviad913','Bean','banmaisom2002+2003@gmail.com','2026-02-11 15:20:24.231','2026-02-11 15:21:53.913'),(94,'mindful','D894FMifyRZQWr8Bld15JKMBuqZ2','Thea','banmaisom2002+2103@gmail.com','2026-02-13 14:22:51.490','2026-02-13 14:22:51.490'),(95,'mindful','USoUoB4a6uZBydNe2AkcHNWDYy02','Thea','banmaisom2002+2203@gmail.com','2026-02-13 14:29:33.944','2026-02-13 14:30:01.544'),(96,'mindful','oDwRsaHKusTJ04LoDWEgWHjhvmx1','Thea','banmaisom2002+2403@gmail.com','2026-02-13 14:34:11.887','2026-02-13 14:34:11.887'),(97,'mindful','ssVyGdwFh3PIicjaf573uGWtKJC3','Thea','banmaisom2002+2303@gmail.com','2026-02-13 14:46:34.634','2026-02-13 14:46:34.634'),(98,'mindful','xtmqPsHPsdczzVIlLY0lwHvP27b2','Thea','banmaisom2002+2503@gmail.com','2026-02-13 14:59:52.503','2026-02-13 14:59:52.503'),(99,'mindful','6gNnn27snQTUmyVn77nSth7qPuY2','Thea','banmaisom2002+2703@gmail.com','2026-02-13 15:13:30.133','2026-02-13 15:13:30.133'),(100,'mindful','FM76Ns8JuNh03naItlZAhoXko5w2','Thea','banmaisom2002+2803@gmail.com','2026-02-13 15:17:14.923','2026-02-13 15:17:14.923'),(101,'mindful','e8PihPVuIUPj6iDiLBxtZGrOJs23','Thea','banmaisom2002+2903@gmail.com','2026-02-13 15:19:34.841','2026-02-13 15:19:34.841'),(106,'mindful','RpvbReniNuh4FCH1XkisgrAmkVG3','Thea','banmaisom2002+3003@gmail.com','2026-02-20 16:30:08.764','2026-02-20 16:30:08.764'),(107,'mindful','Kw966PoXknMx8BrGTSUfjGtZSUG3','Binh Stag +3','nguyenthanhbinh1984+3@gmail.com','2026-02-24 10:41:54.338','2026-02-24 10:41:54.338'),(110,'mindful','3hqKagFVBqNFnGpWErZa1ErD5fS2','0104','banmaisom2002+0104@gmail.com','2026-03-06 15:48:06.300','2026-03-06 15:48:06.300'),(111,'mindful','oKq9hcBxdETg5OpCZcRX469xSKI2','0204','banmaisom2002+0204@gmail.com','2026-03-06 16:01:20.950','2026-03-06 16:01:20.950'),(112,'mindful','20LDZiDhfjSXNYVICCpN9QB5Izj2','Thea0304','banmaisom2002+0304@gmail.com','2026-03-06 16:06:05.644','2026-03-06 16:06:39.453'),(113,'mindful','kfakmOZLIHRnc8hfIYseg1BbQ1O2','0504','banmaisom2002+0504@gmail.com','2026-03-12 07:48:28.312','2026-03-12 07:48:28.312'),(114,'mindful','6prfPQz0lKcSSZtXVZTAM6adPvz1','Thea0604','banmaisom2002+0604@gmail.com','2026-03-12 07:57:57.114','2026-03-12 07:57:57.114'),(115,'mindful','ieRgzUQrs6bjgLPLz4NFzs31uF22','Thea 1','banmaisom2002+0704@gmail.com','2026-03-27 13:54:37.005','2026-05-13 18:23:55.943'),(120,'mindful','zLC75CkV64NCUYFAK5NqXnDh8k12','Binh','nguyenthanhbinh1984+germany@gmail.com','2026-04-28 14:02:30.142','2026-05-06 15:05:29.897'),(122,'mindful','b2ahgAMa7KXCx5dhVcBzRUNCO3t1','Binh Nguyen','nguyenthanhbinh1984+germany1@gmail.com','2026-05-04 11:27:07.560','2026-06-02 15:27:06.830'),(123,'mindful','PjC0ykycuGXejL68dJt1igxEfQ52','Lukas','lukas@mindful.com','2026-05-05 16:26:13.257','2026-05-05 16:26:13.257'),(124,'mindful','CBueeYpB52PXMRRiCuJ1eLDHnpl1','Noah Löffel','noah@mindful.com','2026-05-06 20:23:01.880','2026-05-06 20:23:01.880'),(125,'mindful','rrbn7JYbfEMr3i96T90lslE3ys82','Noah Löffel','loeffel.noah+mindful-test-11@gmail.com','2026-05-08 23:50:52.840','2026-05-08 23:50:52.840'),(126,'mindful','YXfg19ThXhbe9zRDN5evWnJYyCP2','Noah','loeffel.noah+mindful-test-12@gmail.com','2026-05-08 23:53:15.892','2026-05-08 23:53:15.892'),(127,'mindful','T2xwRg9JJUVddmXDLKkrPOFggo53','Noah','loeffel.noah+mindful-test-13@gmail.com','2026-05-08 23:55:25.101','2026-05-08 23:55:25.101'),(128,'mindful','4uvXHIowa4XPAD7UZNnyiTHjPjw2','Noah','loeffel.noah+mindful-test-2@gmail.com','2026-05-09 00:46:42.992','2026-05-09 00:46:42.992'),(129,'mindful','pF8muGcHN6ND5kPHpcg2UI0xtkM2','XXX','loeffel.noah+mindful-test-16@gmail.com','2026-05-09 15:20:56.443','2026-05-09 15:20:56.443'),(130,'mindful','0rwgp2U73ZWBCK3A47y2XYeE4rm1','XXX','loeffel.noah+mindful-test-17@gmail.com','2026-05-09 15:30:50.902','2026-05-09 15:30:50.902'),(131,'mindful','QbRwzSZQczUNxcXR2CzAP4b6YVc2','XXX','lucas.loeffel@gmail.com','2026-06-03 19:52:43.661','2026-06-03 19:52:43.661'),(132,'mindful','RA71cgcX0GQ96zKIWmFh6FPFY4c2','dragana','nguyenthanhbinh1984+dragana@gmail.com','2026-06-04 09:51:58.565','2026-06-04 09:51:58.565'),(133,'mindful','jwO7P49Vw5axh7eHkLnQr9zJ8pg1','Dragana','sayhi@dragana.xyz','2026-06-05 09:14:37.761','2026-06-05 09:14:37.761');
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

-- Dump completed on 2026-06-09 13:42:33
