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
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT  IGNORE INTO `categories` (`id`, `project_rid`, `rid`, `display_name`, `parent_id`, `created_at`, `updated_at`) VALUES (1,'mindful','category-noah-1','Kategorie Noah 1',NULL,'2026-02-10 19:49:31.454','2026-02-24 17:00:00.001'),(2,'mindful','kategorie-noah-1-kind-1','Kategorie Noah 1 Kind 1',1,'2026-02-21 14:55:09.397','2026-03-15 20:53:45.550'),(3,'mindful','category-noah-2','Kategorie Noah 2',NULL,'2026-03-02 00:42:23.134','2026-03-02 00:42:59.829');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category_batch_write_tuples_outboxes`
--

LOCK TABLES `category_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `category_batch_write_tuples_outboxes` DISABLE KEYS */;
INSERT  IGNORE INTO `category_batch_write_tuples_outboxes` (`id`, `project_rid`, `rid`, `request`, `fails`, `locked_at`, `created_at`, `updated_at`) VALUES (1,'mindful','category-noah-1',_binary '\n#projects/mindful/authorizationModelJ\ncategoryPolicy:category-noah-1categoryPolicy\Zcategory:category-noah-15\ncategory:category-noah-1category\Zproject:mindful',10,NULL,'2026-02-10 19:49:31.469','2026-02-10 19:49:41.854'),(2,'mindful','kategorie-noah-1-kind-1',_binary '\n#projects/mindful/authorizationModelZ\n&categoryPolicy:kategorie-noah-1-kind-1categoryPolicy\Z category:kategorie-noah-1-kind-1=\n category:kategorie-noah-1-kind-1category\Zproject:mindful',10,NULL,'2026-02-21 14:55:09.406','2026-02-21 14:55:20.255'),(3,'mindful','category-noah-2',_binary '\n#projects/mindful/authorizationModelJ\ncategoryPolicy:category-noah-2categoryPolicy\Zcategory:category-noah-25\ncategory:category-noah-2category\Zproject:mindful',10,NULL,'2026-03-02 00:42:23.165','2026-03-02 00:42:34.296');
/*!40000 ALTER TABLE `category_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category_infos`
--

LOCK TABLES `category_infos` WRITE;
/*!40000 ALTER TABLE `category_infos` DISABLE KEYS */;
INSERT  IGNORE INTO `category_infos` (`id`, `category_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'kategorie-noah-1-info-german','Kategorie Noah 1 Info German','Kategorie Noah 1 Info German Beschreibung has to be long','Kategorie Noah 1 Info German Kurzbeschreibung has to be long','de','2026-02-20 17:01:21.802','2026-02-20 17:01:21.802'),(2,3,'category-noah-2-englisch','Kategorie Noah 2 Englisch','Kategorie Noah 2 Englisch has to be long enough for description','Kategorie Noah 2 Englisch has to be long enough for description','en','2026-03-02 00:42:54.179','2026-03-02 00:42:54.179'),(3,2,'kategorie-noah-1-kind-1-information-deutsch','Kategorie Noah 1 Kind 1 Information Deutsch','Kategorie Noah 1 Kind 1 Information Deutsch has to be long','Kategorie Noah 1 Kind 1 Information Deutsch has to be long','de','2026-03-15 20:53:39.479','2026-03-15 20:53:39.479');
/*!40000 ALTER TABLE `category_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category_publications`
--

LOCK TABLES `category_publications` WRITE;
/*!40000 ALTER TABLE `category_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `category_publications` (`id`, `category_id`, `parent_id`, `language_rid`, `category_info_id`, `created_at`, `updated_at`) VALUES (1,1,NULL,'de',1,'2026-02-20 22:23:08.085','2026-02-20 22:23:08.085'),(2,3,NULL,'en',2,'2026-03-02 00:42:59.835','2026-03-02 00:42:59.835'),(3,2,1,'de',3,'2026-03-15 20:53:45.562','2026-03-15 20:53:45.562');
/*!40000 ALTER TABLE `category_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_batch_write_tuples_outboxes`
--

LOCK TABLES `content_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `content_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_categories`
--

LOCK TABLES `content_categories` WRITE;
/*!40000 ALTER TABLE `content_categories` DISABLE KEYS */;
INSERT  IGNORE INTO `content_categories` (`content_id`, `category_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2026-02-25 20:49:10.410','2026-02-25 20:49:10.410'),(1,3,1,'2026-03-02 00:43:35.023','2026-03-02 00:43:35.023'),(2,1,0,'2026-03-01 15:07:25.106','2026-03-01 15:07:25.106');
/*!40000 ALTER TABLE `content_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_category_publications`
--

LOCK TABLES `content_category_publications` WRITE;
/*!40000 ALTER TABLE `content_category_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_category_publications` (`content_id`, `language_rid`, `category_id`, `order`, `created_at`, `updated_at`) VALUES (1,'de',1,0,'2026-03-01 18:56:07.639','2026-03-01 18:56:07.639');
/*!40000 ALTER TABLE `content_category_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_image_types`
--

LOCK TABLES `content_image_types` WRITE;
/*!40000 ALTER TABLE `content_image_types` DISABLE KEYS */;
INSERT  IGNORE INTO `content_image_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'poster-square','2026-02-02 10:06:25.172','2026-06-05 15:50:58.783'),(2,'poster-portrait','2026-02-02 10:06:25.180','2026-06-05 15:50:58.797'),(3,'poster-landscape','2026-02-02 10:06:25.187','2026-06-05 15:50:58.809');
/*!40000 ALTER TABLE `content_image_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_images`
--

LOCK TABLES `content_images` WRITE;
/*!40000 ALTER TABLE `content_images` DISABLE KEYS */;
INSERT  IGNORE INTO `content_images` (`id`, `content_id`, `rid`, `display_name`, `description`, `content_image_type_id`, `object_rid`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'content-noah-1-square-deutsch','Content Noah 1 Square Deutsch','Content Noah 1 Square Deutsch has to be long enough',1,'public/content/contents/content-noah-1/images/square','de','2026-03-01 12:19:05.320','2026-03-01 12:19:05.320'),(2,1,'content-noah-1-portrait-deutsch','Content Noah 1 Portrait Deutsch','Content Noah 1 Portrait Deutsch has to be long enough',2,'public/content/contents/content-noah-1/images/square','de','2026-03-01 18:55:32.695','2026-03-01 18:55:32.695'),(3,1,'content-noah-1-landscape-deutsch','Content Noah 1 Landscape Deutsch','Content Noah 1 Landscape Deutsch has to be long enough',3,'public/content/contents/content-noah-1/images/square','de','2026-03-01 18:56:00.635','2026-03-01 18:56:00.635');
/*!40000 ALTER TABLE `content_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_infos`
--

LOCK TABLES `content_infos` WRITE;
/*!40000 ALTER TABLE `content_infos` DISABLE KEYS */;
INSERT  IGNORE INTO `content_infos` (`id`, `content_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'content-noah-1-information-deutsch','Content Noah 1 Information Deutsch','Content Noah 1 Information Deutsch has to be long enough','Content Noah 1 Information Deutsch has to be long enough','de','2026-02-28 20:25:09.790','2026-02-28 20:25:09.790');
/*!40000 ALTER TABLE `content_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_instructor_publications`
--

LOCK TABLES `content_instructor_publications` WRITE;
/*!40000 ALTER TABLE `content_instructor_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_instructor_publications` (`content_id`, `language_rid`, `instructor_id`, `order`, `created_at`, `updated_at`) VALUES (1,'de',1,0,'2026-03-01 18:56:07.596','2026-03-01 18:56:07.596'),(1,'de',2,1,'2026-03-16 16:16:36.402','2026-03-16 16:16:36.402');
/*!40000 ALTER TABLE `content_instructor_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_instructors`
--

LOCK TABLES `content_instructors` WRITE;
/*!40000 ALTER TABLE `content_instructors` DISABLE KEYS */;
INSERT  IGNORE INTO `content_instructors` (`content_id`, `instructor_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2026-02-25 20:49:10.359','2026-02-25 20:49:10.359'),(1,2,1,'2026-03-08 17:08:48.826','2026-03-08 17:08:48.826'),(2,1,0,'2026-03-01 15:07:25.085','2026-03-01 15:07:25.085');
/*!40000 ALTER TABLE `content_instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_media_types`
--

LOCK TABLES `content_media_types` WRITE;
/*!40000 ALTER TABLE `content_media_types` DISABLE KEYS */;
INSERT  IGNORE INTO `content_media_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'video-teaser-portrait','2026-02-02 10:06:25.203','2026-06-05 15:50:58.837'),(2,'video-teaser-landscape','2026-02-02 10:06:25.212','2026-06-05 15:50:58.851'),(3,'video-trailer-portrait','2026-02-02 10:06:25.220','2026-06-05 15:50:58.862'),(4,'video-trailer-landscape','2026-02-02 10:06:25.269','2026-06-05 15:50:58.873'),(5,'video-primary','2026-02-02 10:06:25.277','2026-06-05 15:50:58.884'),(6,'audio-primary','2026-02-02 10:06:25.286','2026-06-05 15:50:58.896'),(7,'audio-teaser','2026-02-02 10:06:25.307','2026-06-05 15:50:58.907');
/*!40000 ALTER TABLE `content_media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_medias`
--

LOCK TABLES `content_medias` WRITE;
/*!40000 ALTER TABLE `content_medias` DISABLE KEYS */;
INSERT  IGNORE INTO `content_medias` (`id`, `content_id`, `rid`, `display_name`, `description`, `content_media_type_id`, `media_rid`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'content-noah-1-primary-deutsch','Content Noah 1 Primary Deutsch','Content Noah 1 Primary Deutsch has to be long enough',5,'content/contents/content-noah-1/videos/primary','de','2026-03-01 18:48:43.285','2026-03-01 18:48:43.285'),(2,1,'content-noah-1-teaser-deutsch','Content Noah 1 Teaser Deutsch','Content Noah 1 Teaser Deutsch has to be long enough',2,'public/content/contents/content-noah-1/videos/teaser','de','2026-03-01 18:53:07.446','2026-03-01 18:53:07.446'),(3,1,'content-noah-1-trailer-deutsch','Content Noah 1 Trailer Deutsch','Content Noah 1 Trailer Deutsch has to be long enough',4,'public/content/contents/content-noah-1/videos/trailer','de','2026-03-01 18:53:40.445','2026-03-01 18:53:40.445');
/*!40000 ALTER TABLE `content_medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_publications`
--

LOCK TABLES `content_publications` WRITE;
/*!40000 ALTER TABLE `content_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_publications` (`id`, `content_id`, `language_rid`, `content_info_id`, `content_image_poster_square_id`, `content_image_poster_portrait_id`, `content_image_poster_landscape_id`, `content_media_primary_id`, `content_media_video_teaser_portrait_id`, `content_media_video_teaser_landscape_id`, `content_media_video_trailer_portrait_id`, `content_media_video_trailer_landscape_id`, `content_media_audio_teaser_id`, `created_at`, `updated_at`) VALUES (1,1,'de',1,1,2,3,1,NULL,NULL,NULL,NULL,NULL,'2026-03-01 18:56:07.567','2026-03-01 18:56:07.567');
/*!40000 ALTER TABLE `content_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_tag_publications`
--

LOCK TABLES `content_tag_publications` WRITE;
/*!40000 ALTER TABLE `content_tag_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_tag_publications` (`content_id`, `language_rid`, `tag_id`, `order`, `created_at`, `updated_at`) VALUES (1,'de',1,0,'2026-03-01 18:56:07.619','2026-03-01 18:56:07.619');
/*!40000 ALTER TABLE `content_tag_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_tags`
--

LOCK TABLES `content_tags` WRITE;
/*!40000 ALTER TABLE `content_tags` DISABLE KEYS */;
INSERT  IGNORE INTO `content_tags` (`content_id`, `tag_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2026-02-25 20:49:10.386','2026-02-25 20:49:10.386'),(2,1,0,'2026-03-01 15:07:25.096','2026-03-01 15:07:25.096');
/*!40000 ALTER TABLE `content_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_types`
--

LOCK TABLES `content_types` WRITE;
/*!40000 ALTER TABLE `content_types` DISABLE KEYS */;
INSERT  IGNORE INTO `content_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'video','2026-02-02 10:06:25.048','2026-06-05 15:50:58.738'),(2,'audio','2026-02-02 10:06:25.069','2026-06-05 15:50:58.755');
/*!40000 ALTER TABLE `content_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `contents`
--

LOCK TABLES `contents` WRITE;
/*!40000 ALTER TABLE `contents` DISABLE KEYS */;
INSERT  IGNORE INTO `contents` (`id`, `project_rid`, `rid`, `display_name`, `content_type_id`, `collection_only`, `created_at`, `updated_at`) VALUES (1,'mindful','content-noah-1','Content Noah 1',1,0,'2026-02-25 20:49:10.285','2026-05-05 07:05:48.501'),(2,'mindful','content-noah-2','Content Noah 2',2,0,'2026-03-01 15:07:25.017','2026-03-16 16:16:51.565');
/*!40000 ALTER TABLE `contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_batch_write_tuples_outboxes`
--

LOCK TABLES `instructor_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `instructor_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_image_types`
--

LOCK TABLES `instructor_image_types` WRITE;
/*!40000 ALTER TABLE `instructor_image_types` DISABLE KEYS */;
INSERT  IGNORE INTO `instructor_image_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'avatar','2026-02-02 10:06:25.030','2026-06-05 15:50:58.712');
/*!40000 ALTER TABLE `instructor_image_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_images`
--

LOCK TABLES `instructor_images` WRITE;
/*!40000 ALTER TABLE `instructor_images` DISABLE KEYS */;
INSERT  IGNORE INTO `instructor_images` (`id`, `instructor_id`, `rid`, `display_name`, `description`, `instructor_image_type_id`, `object_rid`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'instruktor-noah-1-image-deutsch-testo','Instruktor Noah 1 Image Deutsch Testo','Instruktor Noah 1 Image Deutsch Testo has to be long en',1,'public/content/instructors/instructor-noah-1/images/avatar.jpg','de','2026-02-21 19:10:05.153','2026-03-01 14:05:40.831'),(2,1,'instruktor-noah-1-image-englisch-testo','Instruktor Noah 1 Image Englisch Testo','Instruktor Noah 1 Image Englisch Testo has to be long ',1,'public/content/contents/instructor-noah-1/images/test.jpg','en','2026-02-21 19:17:21.003','2026-02-21 19:17:21.003'),(3,2,'instruktor-noah-2-avatar-deutsch','Instruktor Noah 2 Avatar Deutsch','Instruktor Noah 2 Avatar Deutsch has to be long enough',1,'public/content/instructors/instruktor-noah-2/images/avatar.jpg','de','2026-03-02 17:33:56.043','2026-03-02 17:33:56.043');
/*!40000 ALTER TABLE `instructor_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_profiles`
--

LOCK TABLES `instructor_profiles` WRITE;
/*!40000 ALTER TABLE `instructor_profiles` DISABLE KEYS */;
INSERT  IGNORE INTO `instructor_profiles` (`id`, `instructor_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'instructor-noah-1-profile-german','Instruktor Noah 1 Profile German','Instruktor Noah 1 Profile German has to be longer ','Instruktor Noah 1 Profile German has to be longer ','de','2026-02-20 17:38:44.400','2026-02-20 17:38:44.400'),(2,1,'instruktor-noah-1-profile-englisch','Instruktor Noah 1 Profile Englisch','Instruktor Noah 1 Profile Englisch has to be long enough','Instruktor Noah 1 Profile Englisch has to be long enough','en','2026-02-21 19:18:00.517','2026-02-21 19:18:00.517'),(3,2,'instruktor-noah-2-profil-englisch','Instruktor Noah 2 Profil Englisch','Instruktor Noah 2 Profil Englisch has to be long enough','Instruktor Noah 2 Profil Englisch has to be long enough','en','2026-02-25 16:50:12.940','2026-02-25 16:50:12.940'),(4,2,'instruktor-noah-2-profile-deutsch','Instruktor Noah 2 Profile Deutsch','Instruktor Noah 2 Profile Deutsch has to be long enough','Instruktor Noah 2 Profile Deutsch has to be long enough','de','2026-03-02 17:35:36.389','2026-03-02 17:35:36.389');
/*!40000 ALTER TABLE `instructor_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_publications`
--

LOCK TABLES `instructor_publications` WRITE;
/*!40000 ALTER TABLE `instructor_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `instructor_publications` (`id`, `instructor_id`, `language_rid`, `instructor_image_avatar_id`, `instructor_profile_id`, `created_at`, `updated_at`) VALUES (1,1,'de',1,1,'2026-02-21 19:10:44.101','2026-02-21 19:10:44.101'),(2,1,'en',2,2,'2026-02-21 19:18:02.723','2026-02-21 19:18:02.723'),(3,2,'de',3,4,'2026-03-02 17:35:42.847','2026-03-02 17:35:42.847');
/*!40000 ALTER TABLE `instructor_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructors`
--

LOCK TABLES `instructors` WRITE;
/*!40000 ALTER TABLE `instructors` DISABLE KEYS */;
INSERT  IGNORE INTO `instructors` (`id`, `project_rid`, `rid`, `display_name`, `created_at`, `updated_at`) VALUES (1,'mindful','instructor-noah-1','Instruktor Noah 1','2026-02-10 20:01:27.871','2026-02-24 17:00:09.905'),(2,'mindful','instruktor-noah-2','Instruktor Noah 2','2026-02-24 19:51:49.270','2026-03-02 17:35:42.842');
/*!40000 ALTER TABLE `instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tag_batch_write_tuples_outboxes`
--

LOCK TABLES `tag_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `tag_batch_write_tuples_outboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tag_infos`
--

LOCK TABLES `tag_infos` WRITE;
/*!40000 ALTER TABLE `tag_infos` DISABLE KEYS */;
INSERT  IGNORE INTO `tag_infos` (`id`, `tag_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'tag-noah-1-info-german','Tag Noah 1 Information German','Tag Noah 1 Info German Description has to be longer than 50 characters','Tag Noah 1 Info German Short Description has to be longer than 50 characters','de','2026-02-20 16:51:18.327','2026-02-20 16:51:18.327'),(2,1,'tag-noah-1-information-english','Tag Noah 1 Information English','Tag Noah 1 Information English has to be long enough','Tag Noah 1 Information English has to be long enough','en','2026-02-20 22:16:45.955','2026-02-20 22:16:45.955'),(5,4,'tag-noah-1-kind-3-englisch','Tag Noah 1 Kind 3 Englisch','Tag Noah 1 Kind 3 Englisch has to be long enough to','Tag Noah 1 Kind 3 Englisch has to be long enough toooo','en','2026-02-21 15:46:22.540','2026-02-21 17:05:28.574'),(6,4,'tag-noah-1-kind-3-deutsch','Tag Noah 1 Kind 3 Deutsch','Tag Noah 1 Kind 3 Deutsch has to be long enough for','Tag Noah 1 Kind 3 Deutsch has to be long enough for','de','2026-02-21 19:57:17.735','2026-02-21 19:57:17.735');
/*!40000 ALTER TABLE `tag_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tag_publications`
--

LOCK TABLES `tag_publications` WRITE;
/*!40000 ALTER TABLE `tag_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `tag_publications` (`id`, `tag_id`, `parent_id`, `language_rid`, `tag_info_id`, `created_at`, `updated_at`) VALUES (12,1,NULL,'de',1,'2026-02-24 16:57:03.785','2026-02-24 16:57:03.785'),(13,1,NULL,'en',2,'2026-02-24 16:57:03.794','2026-02-24 16:57:03.794');
/*!40000 ALTER TABLE `tag_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT  IGNORE INTO `tags` (`id`, `project_rid`, `rid`, `display_name`, `parent_id`, `created_at`, `updated_at`) VALUES (1,'mindful','tag-noah-1','Tag Noah 1',NULL,'2026-02-10 19:41:57.929','2026-02-24 16:57:03.740'),(4,'mindful','tag-noah-1-kind-3','Tag Noah 1 Kind 3',1,'2026-02-21 13:52:39.414','2026-02-21 19:58:06.717'),(5,'mindful','test-123','test',NULL,'2026-02-24 16:05:47.178','2026-02-24 16:05:47.178');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-09 11:26:02
