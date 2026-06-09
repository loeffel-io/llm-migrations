-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: loeffel-io
-- ------------------------------------------------------
-- Server version	8.0.44-google

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
-- Dumping data for table `object_batch_write_tuples_outboxes`
--

LOCK TABLES `object_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `object_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `object_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `object_policies`
--

LOCK TABLES `object_policies` WRITE;
/*!40000 ALTER TABLE `object_policies` DISABLE KEYS */;
INSERT  IGNORE INTO `object_policies` (`id`, `object_id`, `created_at`, `updated_at`) VALUES (2,3,'2025-12-19 09:44:56.113','2026-06-05 15:58:25.054');
/*!40000 ALTER TABLE `object_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `object_policy_batch_write_tuples_outboxes`
--

LOCK TABLES `object_policy_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `object_policy_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `object_policy_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `object_policy_binding_accounts`
--

LOCK TABLES `object_policy_binding_accounts` WRITE;
/*!40000 ALTER TABLE `object_policy_binding_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `object_policy_binding_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `object_policy_bindings`
--

LOCK TABLES `object_policy_bindings` WRITE;
/*!40000 ALTER TABLE `object_policy_bindings` DISABLE KEYS */;
INSERT  IGNORE INTO `object_policy_bindings` (`id`, `object_policy_id`, `role_rid`, `all_accounts`, `all_authenticated_accounts`, `order`, `created_at`, `updated_at`) VALUES (5,2,'storage-object-viewer',1,0,0,'2025-12-21 16:18:38.178','2025-12-21 16:20:45.705');
/*!40000 ALTER TABLE `object_policy_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT  IGNORE INTO `objects` (`id`, `project_rid`, `rid`, `display_name`, `storage_generation`, `storage_metageneration`, `storage_size`, `storage_content_type`, `storage_md5_hash`, `storage_created_at`, `storage_updated_at`, `storage_deleted_at`, `created_at`, `updated_at`) VALUES (3,'mindful','public/','Public',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-12-18 17:26:19.883','2026-06-05 15:58:24.841'),(6,'mindful','public/user/users/lucas/profile/image','Profile image lucas',1772991472310922,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-03-08 17:37:52.466','2026-03-08 17:37:52.466',NULL,'2025-12-19 17:01:20.834','2026-03-08 17:37:54.014'),(7,'mindful','test-video','Test video',1767687764623601,2,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-01-06 08:22:44.755','2026-02-06 14:14:30.538',NULL,'2026-01-06 08:21:41.917','2026-02-06 14:14:32.083'),(8,'mindful','public/content/instructors/lukas-mankow/images/test.jpg','Lukas Mankow Avatar',1767691757120741,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-01-06 09:29:17.229','2026-01-06 09:29:17.229',NULL,'2026-01-06 09:29:08.992','2026-01-06 09:29:17.705'),(9,'mindful','test','test',1767705190913573,2,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-01-06 13:13:10.962','2026-02-06 14:10:54.975',NULL,'2026-01-06 13:11:28.499','2026-02-06 14:10:56.319'),(10,'mindful','public/content/contents/yoga-123/images/test.jpg','Content Yoga 123 test image',1768460907140356,1,122623,'image/jpeg','j5UR+MGbrogo1T3Lb2rmxQ==','2026-01-15 07:08:27.290','2026-01-15 07:08:27.290',NULL,'2026-01-15 07:08:20.794','2026-01-15 07:08:29.256'),(11,'mindful','projects/mindful/objects/public/content/contents/yoga-123/videos/test.mp4','Content yoga 123 test video',1768587250418303,2,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-01-16 18:14:10.477','2026-02-16 06:56:32.601',NULL,'2026-01-16 18:13:12.436','2026-02-16 06:56:44.342'),(12,'mindful','public/content/contents/yoga-123/videos/test.mp4','test mp4',1768587652119282,2,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-01-16 18:20:52.180','2026-03-01 01:09:53.454',NULL,'2026-01-16 18:19:52.905','2026-03-01 01:09:54.765'),(13,'mindful','public/content/instructors/noah-loeffel/images/test.jpg','Noah Loeffel instructor image',1769365896765789,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-01-25 18:31:36.819','2026-01-25 18:31:36.819',NULL,'2026-01-25 18:31:26.826','2026-01-25 18:31:38.627'),(14,'mindful','objects/public/content/contents/yoga-123/audios/test.wav','Object yoga 123 test audio',1769775348527792,2,2104474,'audio/wav','ChzKuruGPm7Vxr2HmS9qIw==','2026-01-30 12:15:48.591','2026-03-06 22:40:44.738',NULL,'2026-01-30 12:08:03.687','2026-03-06 22:40:46.669'),(15,'mindful','public/content/contents/yoga-123/audios/test.wav','Content yoga 123 wav test',1769775431995673,2,2104474,'audio/wav','ChzKuruGPm7Vxr2HmS9qIw==','2026-01-30 12:17:12.028','2026-03-06 22:40:32.583',NULL,'2026-01-30 12:17:04.324','2026-03-06 22:40:54.199'),(16,'mindful','public/content/instructors/fanny-mielke/images/test.jpg','Fanny Mielke ',1769885291338213,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-01-31 18:48:11.382','2026-01-31 18:48:11.382',NULL,'2026-01-31 18:48:05.539','2026-01-31 18:48:59.090'),(17,'mindful','objects/public/content/contents/gurke-123/images/test.jpg','Content Gurke 123 Poster image',1769887090187436,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-01-31 19:18:10.313','2026-01-31 19:18:10.313',NULL,'2026-01-31 19:17:11.415','2026-01-31 19:18:12.050'),(18,'mindful','public/content/contents/gurke-123/images/test.jpg','Content Gurke 123 poster image 2 ',1769887110648087,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-01-31 19:18:30.680','2026-01-31 19:18:30.680',NULL,'2026-01-31 19:18:06.365','2026-01-31 19:18:32.032'),(19,'mindful','test.mp4','Gurke 123 video primary test',1770016615936522,2,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-02-02 07:16:55.982','2026-03-06 23:07:15.075',NULL,'2026-02-02 07:15:26.684','2026-03-06 23:07:16.403'),(20,'mindful','public/content/contents/gurke-123/videos/test.mp4','gurke 123 test video',1770016747886013,2,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-02-02 07:19:07.928','2026-03-06 23:47:27.744',NULL,'2026-02-02 07:17:51.697','2026-03-06 23:47:29.066'),(21,'mindful','content/contents/gurke-123/videos/test.mp4','Yoga Gurke 123 Primary Video ',1770546065966924,3,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-02-08 10:21:06.070','2026-05-13 14:31:48.632',NULL,'2026-02-08 10:19:46.773','2026-05-13 14:31:50.579');
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09  8:45:22
