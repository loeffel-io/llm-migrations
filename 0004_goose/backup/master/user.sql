-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: master
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
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT  IGNORE INTO `languages` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'de','2025-10-12 16:52:25.974','2025-10-12 16:52:25.974'),(2,'en','2025-10-14 07:43:40.456','2025-10-14 07:43:40.456'),(3,'am','2025-11-07 12:10:18.734','2025-11-07 12:10:18.734'),(4,'af','2025-11-07 12:28:13.419','2025-11-07 12:28:13.419');
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
INSERT  IGNORE INTO `membership_invitations` (`id`, `rid`, `email`, `accepted_at`, `expire_at`, `organization_id`, `role_rid`, `created_at`, `updated_at`) VALUES (1,'6cf3dc75-5ff5-4176-8e8a-e25eb0316f75','m40gaml@maillog.uk',NULL,'2025-11-05 17:10:50.773',2,'user-organization-admin','2025-11-04 17:10:51.467','2025-11-04 17:10:51.467'),(2,'b9b559a3-d211-4b6d-99f8-102cab3b74e4','robin@irmer.io',NULL,'2025-11-13 09:23:44.543',3,'email-email-admin','2025-11-06 09:23:45.435','2025-11-06 13:10:14.053'),(4,'ca2a0193-4626-40ab-8c17-2c1eb93e91d2','lucas@mindful.com',NULL,'2025-11-13 13:21:25.328',3,'user-organization-admin','2025-11-06 13:21:25.374','2025-11-06 13:21:25.374'),(6,'52529ab3-15e7-4829-b3fb-86509bb82178','lucas.loeffel@gmail.com',NULL,'2025-11-20 07:41:04.890',3,'user-organization-admin','2025-11-13 07:41:04.913','2025-11-13 07:41:04.913'),(7,'edd2b10d-9765-465c-97db-786913940d12','fischgeburt123@gmail.com',NULL,'2025-11-20 08:44:03.964',3,'user-organization-admin','2025-11-13 08:44:03.988','2025-11-13 08:44:03.988'),(8,'8137d004-3802-46e2-b734-c47d8622bdab','noah+11@mindful.com','2025-11-20 12:16:08.990','2025-11-27 10:37:49.417',3,'user-organization-admin','2025-11-20 10:37:49.490','2025-11-20 12:16:08.990'),(9,'296db401-e7a1-43a7-be67-155d048ed81f','noah+12@mindful.com','2025-11-20 12:24:04.721','2025-11-27 12:20:01.706',3,'admin','2025-11-20 12:20:02.160','2025-11-20 12:24:04.721'),(10,'14cbbdc6-5c87-40ce-b8d7-48c3572387fa','philip@mindful.com',NULL,'2025-11-27 17:14:43.281',3,'user-organization-admin','2025-11-20 17:14:43.437','2025-11-20 17:14:43.437'),(11,'e5626480-0325-4306-af8b-0aafdeb1fac7','m40gaml@maillog.uk',NULL,'2025-11-22 07:38:47.061',2,'user-organization-admin','2025-11-21 07:38:47.656','2025-11-21 07:38:47.656');
/*!40000 ALTER TABLE `membership_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
INSERT  IGNORE INTO `memberships` (`id`, `user_id`, `organization_id`, `role_rid`, `created_at`, `updated_at`) VALUES (1,9,3,'admin','2025-11-20 12:16:09.060','2025-12-03 13:10:30.018'),(2,10,3,'admin','2025-11-20 12:24:04.739','2025-11-20 12:24:04.739');
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
INSERT  IGNORE INTO `organizations` (`id`, `project_rid`, `rid`, `display_name`, `created_at`, `updated_at`) VALUES (2,'mindful','loeffels','Löffel Gmbhhh','2025-10-29 18:09:32.471','2025-11-21 11:21:36.283'),(3,'mindful','loeffe-2','Löffel Gmbh 2','2025-11-06 09:11:31.817','2025-11-06 09:11:31.817'),(4,'mindful','test-gmbh','Test GmbH','2025-11-25 15:16:44.127','2025-11-25 15:16:44.127'),(5,'mindful','fuss','Fuss','2025-12-02 12:06:35.888','2025-12-02 12:06:35.888'),(6,'mindful','testoooooooo','testo','2025-12-03 13:14:02.078','2025-12-03 13:21:16.448');
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT  IGNORE INTO `profiles` (`id`, `user_id`, `username`, `biography`, `location`, `created_at`, `updated_at`, `image`) VALUES (1,1,'loeffel-io',NULL,NULL,'2025-10-12 16:52:27.164','2026-06-08 12:42:26.373',1),(2,2,'loeffelrrr','skhljlj','lkjlkjl','2025-10-14 07:43:40.070','2026-03-02 16:59:04.286',1),(4,4,NULL,NULL,NULL,'2025-10-31 10:55:49.185','2025-10-31 10:55:49.185',0),(6,6,NULL,NULL,NULL,'2025-11-12 11:36:57.190','2025-11-12 11:36:57.190',0),(7,7,NULL,NULL,NULL,'2025-11-18 12:01:09.398','2025-11-18 12:01:09.398',0),(8,8,'thanhbinh',NULL,'Berlin','2025-11-19 11:32:43.110','2026-03-04 08:26:37.698',0),(9,9,NULL,NULL,NULL,'2025-11-20 12:06:06.572','2025-11-20 12:06:06.572',0),(10,10,NULL,NULL,NULL,'2025-11-20 12:22:17.925','2025-11-20 12:22:17.925',0),(12,13,'thanhbinh',NULL,NULL,'2025-11-25 11:58:20.787','2025-11-25 11:58:39.271',0),(18,21,'thanhbinh',NULL,NULL,'2026-02-05 11:39:11.014','2026-02-05 11:39:13.168',0),(24,27,'hab',NULL,NULL,'2026-03-02 08:09:55.814','2026-03-02 08:23:53.821',0),(25,28,'binh.nguyen',NULL,NULL,'2026-05-28 07:34:09.112','2026-05-28 07:34:20.086',0);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_batch_write_tuples_outboxes`
--

LOCK TABLES `user_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `user_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_languages`
--

LOCK TABLES `user_languages` WRITE;
/*!40000 ALTER TABLE `user_languages` DISABLE KEYS */;
INSERT  IGNORE INTO `user_languages` (`user_id`, `language_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2025-10-28 17:24:36.396','2025-10-28 17:24:36.396'),(2,1,0,'2026-03-15 21:24:48.477','2026-03-15 21:24:48.477'),(2,2,1,'2026-03-02 17:04:26.943','2026-03-15 21:24:48.467'),(4,1,0,'2025-10-31 10:55:50.907','2025-10-31 10:55:50.907'),(4,2,1,'2025-10-31 10:55:51.187','2025-10-31 10:55:51.187'),(6,1,0,'2025-11-12 11:36:57.590','2025-11-12 11:36:57.590'),(6,2,1,'2025-11-12 11:36:57.608','2025-11-12 11:36:57.608'),(7,2,0,'2025-11-18 12:01:09.902','2025-11-18 12:01:09.902'),(8,2,0,'2025-11-19 11:32:43.282','2025-11-19 11:32:43.282'),(9,1,0,'2025-11-20 12:06:06.796','2025-11-20 12:06:06.796'),(9,2,1,'2025-11-20 12:06:06.820','2025-11-20 12:06:06.820'),(10,1,0,'2025-11-20 12:22:18.161','2025-11-20 12:22:18.161'),(10,2,1,'2025-11-20 12:22:18.667','2025-11-20 12:22:18.667'),(13,2,0,'2025-11-25 11:58:21.287','2025-11-25 11:58:21.287'),(21,2,0,'2026-02-05 11:39:11.116','2026-02-05 11:39:11.116'),(27,2,0,'2026-03-02 08:09:56.024','2026-03-02 08:09:56.024'),(28,1,0,'2026-05-28 07:34:09.423','2026-05-28 07:34:09.423');
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
INSERT  IGNORE INTO `users` (`id`, `project_rid`, `rid`, `display_name`, `email`, `created_at`, `updated_at`) VALUES (1,'mindful','lucas','Lucas Loeffel','lucas@mindful.com','2025-10-12 16:52:25.966','2026-06-08 12:42:26.313'),(2,'mindful','NqzqUXD5F1VQkdkmjIcbIk2WADH3','Noah Löffel','noah@mindful.com','2025-10-14 07:43:40.044','2026-03-15 21:24:48.400'),(4,'mindful','IFE3q863ywUINeVakKHayxvy4983','Noah Löffel 9','noah+9@mindful.com','2025-10-31 10:55:47.909','2025-10-31 10:55:47.909'),(6,'mindful','GSZi9xCZVohAyTRh7oXIbx6oAV42','Noah Löffel 22','noah+22@mindful.com','2025-11-12 11:36:57.129','2025-11-12 11:36:57.129'),(7,'mindful','ry9gu3XHmBgOMKwAiUCWlNDA5dG3','Binh','nguyenthanhbinh1984@gmail.com','2025-11-18 12:01:08.867','2025-11-18 12:01:08.867'),(8,'mindful','54OWQWXkTmU0K16ZANTG1PHr2uu2','Binh','binh@mindful.com','2025-11-19 11:32:42.990','2025-11-20 16:08:12.119'),(9,'mindful','1ncm1mqssdS2Gldp4MugPOzaOc83','Noah','noah+11@mindful.com','2025-11-20 12:06:06.492','2025-11-20 12:06:06.492'),(10,'mindful','FfRKfT9afjTGhjTHsa4rtFHRZ5k2','Noah','noah+12@mindful.com','2025-11-20 12:22:17.907','2025-11-20 12:22:17.907'),(13,'mindful','4Pyp0q7UMXXOuZIGFnjZxcZmtZ93','Binh','thanhbinh84@yahoo.com','2025-11-25 11:58:20.775','2025-11-25 11:58:20.775'),(21,'mindful','XjyTEeSXUjUQfgX8a44aPg4pgJp2','Binh','nguyenthanhbinh1984+germany@gmail.com','2026-02-05 11:39:11.005','2026-02-05 11:39:11.005'),(27,'mindful','NWJvu2dARka5p03czR8rz785F6G2','kann','lk.mankow@gmail.com','2026-03-02 08:09:55.730','2026-03-02 08:09:55.730'),(28,'mindful','Jfa6WnMibrhpIz0MkRdiIWNIyJa2','Binh','nguyenthanhbinh1984+germany1@gmail.com','2026-05-28 07:34:08.969','2026-05-28 07:34:08.969');
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

-- Dump completed on 2026-06-09 11:17:45
