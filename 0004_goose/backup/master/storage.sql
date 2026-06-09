-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: master
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
INSERT  IGNORE INTO `object_policies` (`id`, `object_id`, `created_at`, `updated_at`) VALUES (1,62,'2025-12-19 16:43:28.141','2026-06-05 15:51:00.454');
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
INSERT  IGNORE INTO `object_policy_bindings` (`id`, `object_policy_id`, `role_rid`, `all_accounts`, `all_authenticated_accounts`, `order`, `created_at`, `updated_at`) VALUES (1,1,'storage-object-viewer',1,0,0,'2025-12-19 16:43:28.214','2025-12-19 16:43:28.214');
/*!40000 ALTER TABLE `object_policy_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT  IGNORE INTO `objects` (`id`, `project_rid`, `rid`, `display_name`, `created_at`, `updated_at`, `storage_generation`, `storage_metageneration`, `storage_size`, `storage_content_type`, `storage_md5_hash`, `storage_created_at`, `storage_updated_at`, `storage_deleted_at`) VALUES (62,'mindful','public/','Public','2025-12-19 16:43:26.047','2026-06-05 15:51:00.347',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,'mindful','public/content/instructors/lukas-mankow/images/test.jpg','Lukas Mankow Avatar','2026-01-06 07:44:55.922','2026-01-06 07:46:12.212',1767685511561380,1,122623,'image/jpeg','j5UR+MGbrogo1T3Lb2rmxQ==','2026-01-06 07:45:11.595','2026-01-06 07:45:11.595',NULL),(66,'mindful','public/content/contents/yoga-123/images/test.jpg','Content Yoga 123 test image','2026-01-15 07:05:23.512','2026-01-15 07:05:37.589',1768460735538141,1,122623,'image/jpeg','j5UR+MGbrogo1T3Lb2rmxQ==','2026-01-15 07:05:35.586','2026-01-15 07:05:35.586',NULL),(67,'mindful','public/user/users/XjyTEeSXUjUQfgX8a44aPg4pgJp2/profile/image','Profile image XjyTEeSXUjUQfgX8a44aPg4pgJp2','2026-02-05 09:45:26.138','2026-05-05 18:03:40.209',1770290109609835,4,278401,'image/jpeg','Cu0FvCrq1G7UUesuRYu1Sw==','2026-02-05 11:15:09.718','2026-05-05 18:03:28.950',NULL),(68,'mindful','public/user/users/gKjwMtpDsXgXZ9rdQJuRqaQ6yp53/profile/image','Profile image gKjwMtpDsXgXZ9rdQJuRqaQ6yp53','2026-02-06 12:01:36.037','2026-05-05 18:02:55.720',1770379400019158,3,2666252,'image/jpeg','BTeXNaG8hZxgkHBsbS5MYA==','2026-02-06 12:03:20.141','2026-05-05 18:02:53.381',NULL),(69,'mindful','public/user/users/wUXjp8GQ6mSX3sbxPhWw95EZRFR2/profile/image','Profile image wUXjp8GQ6mSX3sbxPhWw95EZRFR2','2026-02-06 12:10:27.621','2026-05-05 18:03:47.557',1770387796916624,3,154990,'image/jpeg','MwVZM+yiS4lZZQaiN/kUCQ==','2026-02-06 14:23:17.048','2026-05-05 18:03:46.263',NULL),(70,'mindful','public/user/users/yNPSkz1LKFNQMLNlpoO6NOFCGbv1/profile/image','Profile image yNPSkz1LKFNQMLNlpoO6NOFCGbv1','2026-02-06 14:28:02.237','2026-05-05 18:02:47.154',1770388211853251,3,2661459,'image/jpeg','mBZgAvCUREwDv0xhgTA2TA==','2026-02-06 14:30:11.962','2026-05-05 18:02:45.481',NULL),(71,'mindful','public/user/users/Ffvxizat9IPHcPMdXW9U4tCsWTm2/profile/image','Profile image Ffvxizat9IPHcPMdXW9U4tCsWTm2','2026-02-06 14:35:30.680','2026-05-03 21:22:23.078',1770388723541283,4,2025697,'image/jpeg','eJ8XdIISe0gOBDrBNnPyLg==','2026-02-06 14:38:43.655','2026-05-03 21:22:21.086',NULL),(72,'mindful','public/user/users/UibTRPXPRVM8T24wQtouiNYp1Pv1/profile/image','Profile image UibTRPXPRVM8T24wQtouiNYp1Pv1','2026-02-06 14:42:57.797','2026-05-05 18:02:55.691',1770389151102647,3,2661459,'image/jpeg','mBZgAvCUREwDv0xhgTA2TA==','2026-02-06 14:45:51.219','2026-05-05 18:02:53.381',NULL),(73,'mindful','content/contents/gurke-123/videos','Yoga Gurke 123 Primary Video','2026-02-08 10:13:07.074','2026-04-05 11:52:57.830',1770545660719128,2,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-02-08 10:14:20.766','2026-04-05 11:52:56.591',NULL),(74,'mindful','content/contents/gurke-123/videos/test.mp4','Yoga Gurke 123 Primary Video Fix','2026-02-08 10:16:58.247','2026-02-08 10:18:16.568',1770545894655638,1,263052911,'video/mp4','LetA3LMDGWUnuusw6jN3Hg==','2026-02-08 10:18:14.709','2026-02-08 10:18:14.709',NULL),(78,'mindful','public/content/contents/instructor-noah-1/images/test.jpg','Instruktor Noah 1 Avatar Testo','2026-02-21 19:08:10.068','2026-02-21 19:08:53.308',1771700931984975,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-02-21 19:08:52.049','2026-02-21 19:08:52.049',NULL),(80,'mindful','public/content/instructors/instructor-noah-1/images/avatar.jpg','Instruktor Noah 1 Avatar 4','2026-02-25 16:45:19.684','2026-05-05 18:03:13.751',1772037935533479,4,411907,'image/jpeg','9tqMzQ8my75/0YBCTWxXCg==','2026-02-25 16:45:35.654','2026-05-05 18:02:53.381',NULL),(82,'mindful','public/content/instructors/instruktor-noah-2/images/avatar.jpg','Instruktor Noah 2 Avatar','2026-02-25 16:52:16.291','2026-02-25 16:58:53.939',1772038732503819,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-02-25 16:58:52.615','2026-02-25 16:58:52.615',NULL),(83,'mindful','public/content/instructors/instruktor-noah-2/images/test.jpg','Instruktor Noah 2 Avatar 2','2026-02-25 17:00:43.187','2026-02-25 17:00:55.616',1772038854305711,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-02-25 17:00:54.380','2026-02-25 17:00:54.380',NULL),(84,'mindful','public/user/users/lucas/profile/image','Profile image lucas','2026-02-28 08:50:11.726','2026-03-08 17:39:43.507',1772991581518665,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-03-08 17:39:41.658','2026-03-08 17:39:41.658',NULL),(88,'mindful','public/user/users/NqzqUXD5F1VQkdkmjIcbIk2WADH3/profile/image','Profile image NqzqUXD5F1VQkdkmjIcbIk2WADH3','2026-02-28 18:18:12.912','2026-04-29 08:23:30.736',1772470743406328,3,411907,'image/jpeg','9tqMzQ8my75/0YBCTWxXCg==','2026-03-02 16:59:03.515','2026-04-29 08:23:28.794',NULL),(89,'mindful','public/content/contents/content-noah-1/images/square','Content Noah 1 Square','2026-02-28 21:34:43.850','2026-02-28 21:35:09.462',1772314508019903,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-02-28 21:35:08.102','2026-02-28 21:35:08.102',NULL),(91,'mindful','public/content/contents/content-noah-1/images/square.jpg','Content Noah 1 Square 2','2026-02-28 21:41:29.894','2026-02-28 21:41:46.709',1772314895610789,1,29276,'image/jpeg','Lbx4IPMZBkDo0CFMxTxemg==','2026-02-28 21:41:35.672','2026-02-28 21:41:35.672',NULL),(94,'mindful','content/contents/content-noah-1/videos/primary','Content Noah 1 Primary','2026-03-01 18:46:31.841','2026-05-15 07:03:12.067',1772390807177995,3,1739471,'video/mp4','Gopmal3ctrOMJprDoie5Ug==','2026-03-01 18:46:47.276','2026-05-15 07:03:09.659',NULL),(97,'mindful','public/content/contents/content-noah-1/videos/teaser','Content Noah 1 Teaser','2026-03-01 18:51:25.614','2026-04-08 06:14:29.247',1772391096975649,2,1739471,'video/mp4','Gopmal3ctrOMJprDoie5Ug==','2026-03-01 18:51:37.038','2026-04-08 06:14:09.662',NULL),(98,'mindful','public/content/contents/content-noah-1/videos/trailer','Content Noah 1 Trailer','2026-03-01 18:52:10.435','2026-04-08 06:14:00.456',1772391140472714,2,1739471,'video/mp4','Gopmal3ctrOMJprDoie5Ug==','2026-03-01 18:52:20.534','2026-04-08 06:13:58.350',NULL),(99,'mindful','public/user/users/54OWQWXkTmU0K16ZANTG1PHr2uu2/profile/image','Profile image 54OWQWXkTmU0K16ZANTG1PHr2uu2','2026-03-04 08:26:16.984','2026-05-05 18:03:47.497',1772612778947476,4,320637,'image/png','+3ZVYV2mx2Z0Bci+aXITTQ==','2026-03-04 08:26:19.030','2026-05-05 18:03:46.263',NULL),(100,'mindful','public/user/users/Jfa6WnMibrhpIz0MkRdiIWNIyJa2/profile/image','Profile image Jfa6WnMibrhpIz0MkRdiIWNIyJa2','2026-05-28 07:35:32.501','2026-05-28 07:35:56.625',1779953744954862,1,43224,'image/jpeg','5Qj5xe5ymjbmMmE48HbT8A==','2026-05-28 07:35:45.080','2026-05-28 07:35:45.080',NULL);
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

-- Dump completed on 2026-06-09 11:23:11
