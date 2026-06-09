-- MySQL dump 10.13  Distrib 8.4.9, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: loeffel-io
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
INSERT  IGNORE INTO `languages` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'de','2025-11-22 13:41:47.804','2025-11-22 13:41:47.804'),(2,'en','2026-03-02 09:38:16.423','2026-03-02 09:38:16.423');
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
INSERT  IGNORE INTO `organizations` (`id`, `project_rid`, `rid`, `display_name`, `created_at`, `updated_at`) VALUES (1,'mindful','google','Google','2026-01-06 12:21:29.128','2026-01-06 12:21:29.128');
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT  IGNORE INTO `profiles` (`id`, `user_id`, `username`, `biography`, `location`, `created_at`, `updated_at`, `image`) VALUES (1,1,'loeffel-io',NULL,NULL,'2025-11-22 13:41:49.313','2026-06-05 15:51:04.910',1),(2,2,'test125',NULL,NULL,'2025-11-22 16:41:47.888','2026-03-31 13:32:06.441',0),(3,28,' nnvv',NULL,NULL,'2026-03-02 09:38:15.910','2026-03-02 09:38:23.277',0),(4,29,NULL,NULL,NULL,'2026-05-05 14:35:26.472','2026-05-05 14:35:26.472',0),(5,30,NULL,NULL,NULL,'2026-05-07 15:17:22.826','2026-05-07 15:17:22.826',0),(6,31,NULL,NULL,NULL,'2026-05-08 15:35:07.152','2026-05-08 15:35:07.152',0),(7,32,NULL,NULL,NULL,'2026-05-08 16:03:47.388','2026-05-08 16:03:47.388',0),(8,33,NULL,NULL,NULL,'2026-05-08 16:23:11.852','2026-05-08 16:23:11.852',0),(9,34,NULL,NULL,NULL,'2026-05-08 18:14:03.151','2026-05-08 18:14:03.151',0),(10,35,NULL,NULL,NULL,'2026-05-08 19:00:00.185','2026-05-08 19:00:00.185',0),(11,36,NULL,NULL,NULL,'2026-05-08 19:02:49.558','2026-05-08 19:02:49.558',0),(12,37,NULL,NULL,NULL,'2026-05-08 20:58:57.029','2026-05-08 20:58:57.029',0),(13,38,NULL,NULL,NULL,'2026-05-08 21:33:28.396','2026-05-08 21:33:28.396',0),(14,39,NULL,NULL,NULL,'2026-05-09 00:06:25.288','2026-05-09 00:06:25.288',0),(15,40,NULL,NULL,NULL,'2026-05-09 15:17:34.152','2026-05-09 15:17:34.152',0),(16,41,NULL,NULL,NULL,'2026-05-09 15:37:05.035','2026-05-09 15:37:05.035',0),(17,42,NULL,NULL,NULL,'2026-05-09 20:04:29.323','2026-05-09 20:04:29.323',0),(18,43,NULL,NULL,NULL,'2026-05-10 13:57:48.552','2026-05-10 13:57:48.552',0),(19,44,NULL,NULL,NULL,'2026-05-10 18:22:40.017','2026-05-10 18:22:40.017',0),(20,45,NULL,NULL,NULL,'2026-05-11 13:41:31.669','2026-05-11 13:41:31.669',0),(21,46,NULL,NULL,NULL,'2026-05-12 05:49:06.445','2026-05-12 05:49:06.445',0),(22,47,NULL,NULL,NULL,'2026-05-12 06:32:40.630','2026-05-12 06:32:40.630',0),(23,48,NULL,NULL,NULL,'2026-05-12 12:19:05.109','2026-05-12 12:19:05.109',0),(24,49,NULL,NULL,NULL,'2026-05-12 12:33:31.264','2026-05-12 12:33:31.264',0),(25,50,NULL,NULL,NULL,'2026-05-12 13:13:14.541','2026-05-12 13:13:14.541',0),(26,51,NULL,NULL,NULL,'2026-05-12 13:35:42.962','2026-05-12 13:35:42.962',0),(27,52,NULL,NULL,NULL,'2026-05-12 13:59:22.660','2026-05-12 13:59:22.660',0),(28,53,NULL,NULL,NULL,'2026-05-12 14:02:30.108','2026-05-12 14:02:30.108',0),(29,54,NULL,NULL,NULL,'2026-05-18 06:33:23.709','2026-05-18 06:33:23.709',0),(30,55,'binh.nguyen',NULL,NULL,'2026-05-28 07:42:30.942','2026-05-28 07:42:35.321',0);
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
INSERT  IGNORE INTO `user_languages` (`user_id`, `language_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2025-11-22 13:41:47.810','2025-11-22 13:41:47.810'),(2,1,0,'2025-11-22 16:41:47.888','2025-11-22 16:41:47.888'),(28,2,0,'2026-03-02 09:38:16.430','2026-03-02 09:38:16.430'),(29,1,0,'2026-05-05 14:35:26.954','2026-05-05 14:35:26.954'),(29,2,1,'2026-05-05 14:35:27.197','2026-05-05 14:35:27.197'),(30,1,0,'2026-05-07 15:17:23.856','2026-05-07 15:17:23.856'),(31,1,0,'2026-05-08 15:35:07.560','2026-05-08 15:35:07.560'),(32,1,0,'2026-05-08 16:03:47.524','2026-05-08 16:03:47.524'),(33,1,0,'2026-05-08 16:23:12.363','2026-05-08 16:23:12.363'),(34,1,0,'2026-05-08 18:14:03.455','2026-05-08 18:14:03.455'),(35,1,0,'2026-05-08 19:00:00.509','2026-05-08 19:00:00.509'),(36,1,0,'2026-05-08 19:02:49.579','2026-05-08 19:02:49.579'),(37,1,0,'2026-05-08 20:58:57.558','2026-05-08 20:58:57.558'),(38,1,0,'2026-05-08 21:33:28.791','2026-05-08 21:33:28.791'),(39,1,0,'2026-05-09 00:06:25.657','2026-05-09 00:06:25.657'),(40,2,0,'2026-05-09 15:17:34.557','2026-05-09 15:17:34.557'),(41,2,0,'2026-05-09 15:37:05.080','2026-05-09 15:37:05.080'),(42,2,0,'2026-05-09 20:04:29.857','2026-05-09 20:04:29.857'),(43,1,0,'2026-05-10 13:57:49.052','2026-05-10 13:57:49.052'),(43,2,1,'2026-05-10 13:57:49.073','2026-05-10 13:57:49.073'),(44,1,0,'2026-05-10 18:22:40.428','2026-05-10 18:22:40.428'),(44,2,1,'2026-05-10 18:22:40.417','2026-05-10 18:22:40.417'),(45,1,0,'2026-05-11 13:41:31.949','2026-05-11 13:41:31.949'),(45,2,1,'2026-05-11 13:41:32.009','2026-05-11 13:41:32.009'),(46,1,0,'2026-05-12 05:49:06.718','2026-05-12 05:49:06.718'),(46,2,1,'2026-05-12 05:49:06.728','2026-05-12 05:49:06.728'),(47,1,0,'2026-05-12 06:32:40.947','2026-05-12 06:32:40.947'),(47,2,1,'2026-05-12 06:32:40.960','2026-05-12 06:32:40.960'),(48,1,0,'2026-05-12 12:19:06.010','2026-05-12 12:19:06.010'),(48,2,1,'2026-05-12 12:19:06.309','2026-05-12 12:19:06.309'),(49,1,0,'2026-05-12 12:33:31.304','2026-05-12 12:33:31.304'),(49,2,1,'2026-05-12 12:33:31.317','2026-05-12 12:33:31.317'),(50,1,0,'2026-05-12 13:13:14.914','2026-05-12 13:13:14.914'),(50,2,1,'2026-05-12 13:13:14.871','2026-05-12 13:13:14.871'),(51,1,0,'2026-05-12 13:35:43.019','2026-05-12 13:35:43.019'),(51,2,1,'2026-05-12 13:35:43.115','2026-05-12 13:35:43.115'),(52,1,0,'2026-05-12 13:59:22.707','2026-05-12 13:59:22.707'),(52,2,1,'2026-05-12 13:59:22.720','2026-05-12 13:59:22.720'),(53,1,0,'2026-05-12 14:02:30.126','2026-05-12 14:02:30.126'),(53,2,1,'2026-05-12 14:02:30.214','2026-05-12 14:02:30.214'),(54,2,0,'2026-05-18 06:33:24.015','2026-05-18 06:33:24.015'),(55,1,0,'2026-05-28 07:42:31.409','2026-05-28 07:42:31.409');
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
INSERT  IGNORE INTO `users` (`id`, `project_rid`, `rid`, `display_name`, `email`, `created_at`, `updated_at`) VALUES (1,'mindful','lucas','Lucas Loeffel','lucas@mindful.com','2025-11-22 13:41:47.785','2026-06-05 15:51:04.809'),(2,'mindful','test','Test Loeffel','test@mindful.com','2025-11-22 16:41:47.888','2025-11-22 16:41:47.888'),(28,'mindful','NWJvu2dARka5p03czR8rz785F6G2','jkk','lk.mankow@gmail.com','2026-03-02 09:38:15.874','2026-03-02 09:38:15.874'),(29,'mindful','NqzqUXD5F1VQkdkmjIcbIk2WADH3','Noah Löffel','noah@mindful.com','2026-05-05 14:35:26.195','2026-05-05 14:35:26.195'),(30,'mindful','Gmy2XRNGR4h7P45KDZ47KArAK1g1','Noah Löffel','loeffel.noah@live.de','2026-05-07 15:17:22.752','2026-05-07 15:17:22.752'),(31,'mindful','9B2VeYygPAX7PE32FmFG4I7pf7t2','Noah Löffel','loeffel.noah+mindful-test-2@gmail.com','2026-05-08 15:35:06.954','2026-05-08 15:35:06.954'),(32,'mindful','WN7IodOVwebODNVw2zb7v7Azw6I2','Noah Löffel','loeffel.noah+mindful-test-3@gmail.com','2026-05-08 16:03:47.343','2026-05-08 16:03:47.343'),(33,'mindful','ItmhSeLHWbTYDOVVDibnHOTOJjY2','Noah Löffel','loeffel.noah+mindful-test-4@gmail.com','2026-05-08 16:23:11.723','2026-05-08 16:23:11.723'),(34,'mindful','xkHx2bzhJChWRok6CDLYunn5VWE3','Noah Löffel','loeffel.noah+mindful-test-5@gmail.com','2026-05-08 18:14:03.093','2026-05-08 18:14:03.093'),(35,'mindful','JuKQaMMbZ7gYRmcLjCJBn44IvDw1','Noah Löffel','loeffel.noah+mindful-test-6@gmail.com','2026-05-08 19:00:00.098','2026-05-08 19:00:00.098'),(36,'mindful','h2sAgefPpyQIAK2dJoMnWoyMWbF2','Noah Löffel','loeffel.noah+mindful-test-7@gmail.com','2026-05-08 19:02:49.528','2026-05-08 19:02:49.528'),(37,'mindful','tXgNtBVxPScbmoKI4tRYOA1NSJV2','XXX','loeffel.noah+mindful-test-8@gmail.com','2026-05-08 20:58:56.988','2026-05-08 20:58:56.988'),(38,'mindful','aAyGlpaSRjaEA5ZgjgHPKSlKJX62','XXX','loeffel.noah+mindful-test-9@gmail.com','2026-05-08 21:33:28.320','2026-05-08 21:33:28.320'),(39,'mindful','0G40yoy1AGe6OBQUO01LFB73cIy2','XXX','loeffel.noah+mindful-test-14@gmail.com','2026-05-09 00:06:25.252','2026-05-09 00:06:25.252'),(40,'mindful','B69vlQq1HpN56UyhpLQvN9JcCUv1','Noah','loeffel.noah+mindful-test-15@gmail.com','2026-05-09 15:17:34.054','2026-05-09 15:17:34.054'),(41,'mindful','bx0PLQj8WddwJey4ahZQC2etT4k1','XXX','loeffel.noah@gmail.com','2026-05-09 15:37:04.991','2026-05-09 15:37:04.991'),(42,'mindful','tLp5nCBYPSZs6ISsrhK7V1wlSgH2','XXX','noah@loeffel.io','2026-05-09 20:04:29.296','2026-05-09 20:04:29.296'),(43,'mindful','szgq3khtE2b1AjMX8222lO3tZdZ2','XXX','robin@irmer.io','2026-05-10 13:57:48.486','2026-05-10 13:57:48.486'),(44,'mindful','BRFxBnP4GPZoTOEje2ojHbYf5gJ2','XXX','robin.irmer@googlemail.com','2026-05-10 18:22:39.990','2026-05-10 18:22:39.990'),(45,'mindful','FjiX5KzFvjMAYGZ83sJ9hzDG48z1','XXX','lucas.loeffel+mindful-test-1234@gmail.com','2026-05-11 13:41:31.609','2026-05-11 13:41:31.609'),(46,'mindful','MdGUS5z07ORHjRfZWCLy2rBRaXD2','XXX','lucas.loeffel+mindful-test-1234-a@gmail.com','2026-05-12 05:49:06.409','2026-05-12 05:49:06.409'),(47,'mindful','GeoXLKwtvHSZX7KXG1ZSelfZDD72','XXX','lucas.loeffel+mindful-test-1234-b@gmail.com','2026-05-12 06:32:40.577','2026-05-12 06:32:40.577'),(48,'mindful','98FIMcQEgVQgSwSANlN9HF9d9t03','XXX','lucas.loeffel+mindful-test-1234_c@gmail.com','2026-05-12 12:19:05.016','2026-05-12 12:19:05.016'),(49,'mindful','MgSnHo4smBU6JiQyNMXb9515AjJ2','XXX','lucas.loeffel+mindful-test-1234_d@gmail.com','2026-05-12 12:33:31.219','2026-05-12 12:33:31.219'),(50,'mindful','Ncp7zykQX1VZkRfXtyibIMAuhaD2','XXX','lucas.loeffel+mindful-test-1234_e@gmail.com','2026-05-12 13:13:14.509','2026-05-12 13:13:14.509'),(51,'mindful','pPYuhTtjjVWnrK14KIngZneMFBO2','XXX','lucas.loeffel+mindful-test-1234_f@gmail.com','2026-05-12 13:35:42.914','2026-05-12 13:35:42.914'),(52,'mindful','GbxEBiSnOTTxCsK7rPAMevRbJwZ2','XXX','lucas.loeffel+mindful-test-1234_g@gmail.com','2026-05-12 13:59:22.609','2026-05-12 13:59:22.609'),(53,'mindful','2qTPreQt9TQxbTjOOOzxdUoJKXq2','XXX','lucas.loeffel+mindful-test-1234_h@gmail.com','2026-05-12 14:02:30.100','2026-05-12 14:02:30.100'),(54,'mindful','glhAYqOrzXSls0HambPgMCwsGNx1','XXX','sayhi@dragana.xyz','2026-05-18 06:33:23.643','2026-05-18 06:33:23.643'),(55,'mindful','Jfa6WnMibrhpIz0MkRdiIWNIyJa2','Binh','nguyenthanhbinh1984+germany1@gmail.com','2026-05-28 07:42:30.911','2026-05-28 07:42:30.911');
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

-- Dump completed on 2026-06-09  8:08:00
