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
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT  IGNORE INTO `categories` (`id`, `project_rid`, `rid`, `display_name`, `parent_id`, `created_at`, `updated_at`) VALUES (1,'mindful','node-1','node-1',NULL,'2026-02-06 13:20:54.694','2026-02-06 13:23:41.231'),(2,'mindful','node-2','node-2',NULL,'2026-02-06 13:21:18.167','2026-02-06 13:21:18.167'),(3,'mindful','node-1-1','node-1-1',1,'2026-02-06 13:21:53.211','2026-02-06 13:24:59.390');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category_batch_write_tuples_outboxes`
--

LOCK TABLES `category_batch_write_tuples_outboxes` WRITE;
/*!40000 ALTER TABLE `category_batch_write_tuples_outboxes` DISABLE KEYS */;
INSERT  IGNORE INTO `category_batch_write_tuples_outboxes` (`id`, `project_rid`, `rid`, `request`, `fails`, `locked_at`, `created_at`, `updated_at`) VALUES (1,'mindful','node-1',_binary '\n#projects/mindful/authorizationModel8\ncategoryPolicy:node-1categoryPolicy\Zcategory:node-1,\ncategory:node-1category\Zproject:mindful',10,NULL,'2026-02-06 13:20:54.746','2026-02-06 13:21:05.182'),(2,'mindful','node-2',_binary '\n#projects/mindful/authorizationModel8\ncategoryPolicy:node-2categoryPolicy\Zcategory:node-2,\ncategory:node-2category\Zproject:mindful',10,NULL,'2026-02-06 13:21:18.171','2026-02-06 13:21:27.918'),(3,'mindful','node-1-1',_binary '\n#projects/mindful/authorizationModel<\ncategoryPolicy:node-1-1categoryPolicy\Zcategory:node-1-1.\ncategory:node-1-1category\Zproject:mindful',10,NULL,'2026-02-06 13:21:53.218','2026-02-06 13:22:03.745');
/*!40000 ALTER TABLE `category_batch_write_tuples_outboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category_infos`
--

LOCK TABLES `category_infos` WRITE;
/*!40000 ALTER TABLE `category_infos` DISABLE KEYS */;
INSERT  IGNORE INTO `category_infos` (`id`, `category_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'node-1-en','Node 1 English','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','en','2026-02-06 13:22:50.593','2026-02-06 13:22:50.593'),(2,3,'node-1-1-en','Node 1 1 English','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','en','2026-02-06 13:23:00.681','2026-02-06 13:23:00.681');
/*!40000 ALTER TABLE `category_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `category_publications`
--

LOCK TABLES `category_publications` WRITE;
/*!40000 ALTER TABLE `category_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `category_publications` (`id`, `category_id`, `parent_id`, `language_rid`, `category_info_id`, `created_at`, `updated_at`) VALUES (1,1,NULL,'en',1,'2026-02-06 13:23:41.234','2026-02-06 13:23:41.234'),(2,3,1,'en',2,'2026-02-06 13:24:59.393','2026-02-06 13:24:59.393');
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
INSERT  IGNORE INTO `content_categories` (`content_id`, `category_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2026-02-06 13:43:54.333','2026-02-06 13:43:54.333');
/*!40000 ALTER TABLE `content_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_category_publications`
--

LOCK TABLES `content_category_publications` WRITE;
/*!40000 ALTER TABLE `content_category_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_category_publications` (`content_id`, `language_rid`, `category_id`, `order`, `created_at`, `updated_at`) VALUES (1,'en',1,0,'2026-05-07 14:13:37.667','2026-05-07 14:13:37.667');
/*!40000 ALTER TABLE `content_category_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_image_types`
--

LOCK TABLES `content_image_types` WRITE;
/*!40000 ALTER TABLE `content_image_types` DISABLE KEYS */;
INSERT  IGNORE INTO `content_image_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'poster-square','2026-02-04 14:24:02.445','2026-06-05 15:50:58.452'),(2,'poster-portrait','2026-02-04 14:24:02.490','2026-06-05 15:50:58.465'),(3,'poster-landscape','2026-02-04 14:24:02.496','2026-06-05 15:50:58.474');
/*!40000 ALTER TABLE `content_image_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_images`
--

LOCK TABLES `content_images` WRITE;
/*!40000 ALTER TABLE `content_images` DISABLE KEYS */;
INSERT  IGNORE INTO `content_images` (`id`, `content_id`, `rid`, `display_name`, `description`, `content_image_type_id`, `object_rid`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'gurke-123-landscape-en','Gurke 123 Landscape Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',3,'public/content/contents/gurke-123/images/test.jpg','en','2026-02-06 13:55:08.124','2026-02-06 13:55:08.124'),(3,1,'gurke-123-square-en','Gurke 123 Landscape Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',1,'public/content/contents/gurke-123/images/test.jpg','en','2026-02-06 13:55:22.734','2026-02-06 13:55:22.734'),(4,1,'gurke-123-portrait-en','Gurke 123 Portrait Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',2,'public/content/contents/gurke-123/images/test.jpg','en','2026-02-06 13:55:35.615','2026-02-06 13:55:35.615');
/*!40000 ALTER TABLE `content_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_infos`
--

LOCK TABLES `content_infos` WRITE;
/*!40000 ALTER TABLE `content_infos` DISABLE KEYS */;
INSERT  IGNORE INTO `content_infos` (`id`, `content_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'gurke-123-en','Gurke 123 English','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','en','2026-02-06 13:44:10.432','2026-02-06 13:44:10.432');
/*!40000 ALTER TABLE `content_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_instructor_publications`
--

LOCK TABLES `content_instructor_publications` WRITE;
/*!40000 ALTER TABLE `content_instructor_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_instructor_publications` (`content_id`, `language_rid`, `instructor_id`, `order`, `created_at`, `updated_at`) VALUES (1,'en',1,0,'2026-05-07 14:13:37.622','2026-05-07 14:13:37.622');
/*!40000 ALTER TABLE `content_instructor_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_instructors`
--

LOCK TABLES `content_instructors` WRITE;
/*!40000 ALTER TABLE `content_instructors` DISABLE KEYS */;
INSERT  IGNORE INTO `content_instructors` (`content_id`, `instructor_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2026-02-06 13:43:54.315','2026-02-06 13:43:54.315'),(1,2,1,'2026-02-06 13:43:54.323','2026-02-06 13:43:54.323');
/*!40000 ALTER TABLE `content_instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_media_types`
--

LOCK TABLES `content_media_types` WRITE;
/*!40000 ALTER TABLE `content_media_types` DISABLE KEYS */;
INSERT  IGNORE INTO `content_media_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'video-teaser-portrait','2026-02-04 14:24:02.610','2026-06-05 15:50:58.495'),(2,'video-teaser-landscape','2026-02-04 14:24:02.617','2026-06-05 15:50:58.506'),(3,'video-trailer-portrait','2026-02-04 14:24:02.623','2026-06-05 15:50:58.516'),(4,'video-trailer-landscape','2026-02-04 14:24:02.631','2026-06-05 15:50:58.526'),(5,'video-primary','2026-02-04 14:24:02.637','2026-06-05 15:50:58.535'),(6,'audio-primary','2026-02-04 14:24:02.643','2026-06-05 15:50:58.544'),(7,'audio-teaser','2026-02-04 14:24:02.649','2026-06-05 15:50:58.554');
/*!40000 ALTER TABLE `content_media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_medias`
--

LOCK TABLES `content_medias` WRITE;
/*!40000 ALTER TABLE `content_medias` DISABLE KEYS */;
INSERT  IGNORE INTO `content_medias` (`id`, `content_id`, `rid`, `display_name`, `description`, `content_media_type_id`, `media_rid`, `language_rid`, `created_at`, `updated_at`) VALUES (7,1,'gurke-123-primary-en','Gurke 123 Primary Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',5,'content/contents/gurke-123/videos/test.mp4','en','2026-02-09 06:51:43.292','2026-02-09 06:51:43.292'),(8,1,'gurke-123-teaser-portrait-en','Gurke 123 Teaser Portrait Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',1,'public/content/contents/gurke-123/videos/test.mp4','en','2026-02-09 06:52:39.752','2026-02-09 06:52:39.752'),(9,1,'gurke-123-teaser-landscape-en','Gurke 123 Teaser Landscape Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',2,'public/content/contents/gurke-123/videos/test.mp4','en','2026-02-09 06:52:52.466','2026-02-09 06:52:52.466');
/*!40000 ALTER TABLE `content_medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_publications`
--

LOCK TABLES `content_publications` WRITE;
/*!40000 ALTER TABLE `content_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_publications` (`id`, `content_id`, `language_rid`, `content_info_id`, `content_image_poster_square_id`, `content_image_poster_portrait_id`, `content_image_poster_landscape_id`, `content_media_primary_id`, `content_media_video_teaser_portrait_id`, `content_media_video_teaser_landscape_id`, `content_media_video_trailer_portrait_id`, `content_media_video_trailer_landscape_id`, `content_media_audio_teaser_id`, `created_at`, `updated_at`) VALUES (3,1,'en',1,3,4,1,7,8,9,NULL,NULL,NULL,'2026-05-07 14:13:37.582','2026-05-07 14:13:37.582');
/*!40000 ALTER TABLE `content_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_tag_publications`
--

LOCK TABLES `content_tag_publications` WRITE;
/*!40000 ALTER TABLE `content_tag_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `content_tag_publications` (`content_id`, `language_rid`, `tag_id`, `order`, `created_at`, `updated_at`) VALUES (1,'en',1,0,'2026-05-07 14:13:37.646','2026-05-07 14:13:37.646'),(1,'en',2,1,'2026-05-07 14:13:37.646','2026-05-07 14:13:37.646');
/*!40000 ALTER TABLE `content_tag_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_tags`
--

LOCK TABLES `content_tags` WRITE;
/*!40000 ALTER TABLE `content_tags` DISABLE KEYS */;
INSERT  IGNORE INTO `content_tags` (`content_id`, `tag_id`, `order`, `created_at`, `updated_at`) VALUES (1,1,0,'2026-02-06 13:43:54.326','2026-02-06 13:43:54.326'),(1,2,1,'2026-02-09 13:08:36.865','2026-02-09 13:08:36.865');
/*!40000 ALTER TABLE `content_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `content_types`
--

LOCK TABLES `content_types` WRITE;
/*!40000 ALTER TABLE `content_types` DISABLE KEYS */;
INSERT  IGNORE INTO `content_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'video','2026-02-04 14:24:02.420','2026-06-05 15:50:58.419'),(2,'audio','2026-02-04 14:24:02.429','2026-06-05 15:50:58.432');
/*!40000 ALTER TABLE `content_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `contents`
--

LOCK TABLES `contents` WRITE;
/*!40000 ALTER TABLE `contents` DISABLE KEYS */;
INSERT  IGNORE INTO `contents` (`id`, `project_rid`, `rid`, `display_name`, `content_type_id`, `collection_only`, `created_at`, `updated_at`) VALUES (1,'mindful','gurke-123','Gurke 123 b a',1,0,'2026-02-06 13:43:54.284','2026-05-07 14:13:37.544');
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
INSERT  IGNORE INTO `instructor_image_types` (`id`, `rid`, `created_at`, `updated_at`) VALUES (1,'avatar','2026-02-04 14:24:02.399','2026-06-05 15:50:58.357');
/*!40000 ALTER TABLE `instructor_image_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_images`
--

LOCK TABLES `instructor_images` WRITE;
/*!40000 ALTER TABLE `instructor_images` DISABLE KEYS */;
INSERT  IGNORE INTO `instructor_images` (`id`, `instructor_id`, `rid`, `display_name`, `description`, `instructor_image_type_id`, `object_rid`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'lukas-mankow-en','Lukas Mankow Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',1,'public/content/instructors/lukas-mankow/images/test.jpg','en','2026-02-05 06:18:42.358','2026-02-05 06:18:42.358'),(2,1,'lukas-mankow-de','Lukas Mankow German','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en',1,'public/content/instructors/lukas-mankow/images/test.jpg','de','2026-02-05 06:27:02.718','2026-02-05 06:27:02.718');
/*!40000 ALTER TABLE `instructor_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_profiles`
--

LOCK TABLES `instructor_profiles` WRITE;
/*!40000 ALTER TABLE `instructor_profiles` DISABLE KEYS */;
INSERT  IGNORE INTO `instructor_profiles` (`id`, `instructor_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,1,'lukas-mankow-en','Lukas Mankow English 2','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','en','2026-02-05 05:58:55.181','2026-02-05 06:16:45.063'),(2,2,'noah-loeffel-en','Noah Loeffel Englisch','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','en','2026-02-05 05:59:05.883','2026-02-05 05:59:05.883'),(3,1,'lukas-mankow-de','Lukas Mankow German','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','de','2026-02-05 05:59:31.954','2026-02-05 05:59:31.954'),(4,2,'noah-loeffel-de','Noah Loeffel German','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','de','2026-02-05 05:59:52.504','2026-02-05 05:59:52.504');
/*!40000 ALTER TABLE `instructor_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructor_publications`
--

LOCK TABLES `instructor_publications` WRITE;
/*!40000 ALTER TABLE `instructor_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `instructor_publications` (`id`, `instructor_id`, `language_rid`, `instructor_image_avatar_id`, `instructor_profile_id`, `created_at`, `updated_at`) VALUES (1,1,'en',1,1,'2026-02-05 06:26:03.071','2026-02-05 06:26:03.071'),(2,1,'de',2,3,'2026-02-05 06:27:15.750','2026-02-05 06:27:15.750');
/*!40000 ALTER TABLE `instructor_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `instructors`
--

LOCK TABLES `instructors` WRITE;
/*!40000 ALTER TABLE `instructors` DISABLE KEYS */;
INSERT  IGNORE INTO `instructors` (`id`, `project_rid`, `rid`, `display_name`, `created_at`, `updated_at`) VALUES (1,'mindful','lukas-mankow','Lukas Mankow 2','2026-02-05 05:58:18.366','2026-02-05 06:44:02.282'),(2,'mindful','noah-loeffel','Noah Loeffel','2026-02-05 05:58:33.832','2026-02-05 05:58:33.832');
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
INSERT  IGNORE INTO `tag_infos` (`id`, `tag_id`, `rid`, `display_name`, `description`, `short_description`, `language_rid`, `created_at`, `updated_at`) VALUES (1,2,'legs-en','Legs English','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','en','2026-02-06 13:13:34.706','2026-02-06 13:13:34.706'),(2,1,'body-en','Body English','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet en','Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet','en','2026-02-06 13:13:53.290','2026-02-06 13:13:53.290');
/*!40000 ALTER TABLE `tag_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tag_publications`
--

LOCK TABLES `tag_publications` WRITE;
/*!40000 ALTER TABLE `tag_publications` DISABLE KEYS */;
INSERT  IGNORE INTO `tag_publications` (`id`, `tag_id`, `parent_id`, `language_rid`, `tag_info_id`, `created_at`, `updated_at`) VALUES (2,1,NULL,'en',2,'2026-02-06 13:14:41.987','2026-02-06 13:14:41.987'),(3,2,1,'en',1,'2026-02-06 13:15:08.737','2026-02-06 13:15:08.737');
/*!40000 ALTER TABLE `tag_publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT  IGNORE INTO `tags` (`id`, `project_rid`, `rid`, `display_name`, `parent_id`, `created_at`, `updated_at`) VALUES (1,'mindful','body','Body',NULL,'2026-02-06 13:12:34.686','2026-02-06 13:14:41.984'),(2,'mindful','legs','Legs',1,'2026-02-06 13:12:51.510','2026-02-06 13:15:08.735'),(5,'mindful','arme','Arme',NULL,'2026-05-08 17:51:35.674','2026-05-08 17:51:35.674'),(6,'mindful','arme-mit-parent','Arme mit Parent',1,'2026-05-08 17:51:57.511','2026-05-08 17:51:57.511');
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

-- Dump completed on 2026-06-09  8:49:11
