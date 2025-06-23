-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: fizikova.mysql.pythonanywhere-services.com    Database: fizikova$volunteering
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('71dbbbdcaa14');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `date` date NOT NULL,
  `place` varchar(128) NOT NULL,
  `volunteers_required` int NOT NULL,
  `image_filename` varchar(255) NOT NULL,
  `organizer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organizer_id` (`organizer_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`organizer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (2,'Кто больше съест острой лапши под филлеры блича','вы едите и старайтесь не умереть от того, что остаря лапша проедает вам органы','2025-06-22','Сырой подвал',5,'WIN_20250614_08_47_22_Pro.jpg',1),(3,'Проходка в Москва-Сити','вы приходите, едите бесплтаное мороженое и уходите эщкееере','2025-06-25','Одинцово',7,'png',1),(5,'класс','e3wq','2025-06-29','Сырой подвал',2,'Group_1.png',1),(6,'2','2','2025-06-26','2',2,'image.png',1),(7,'3','777\n* &gt; вава\n1. вмсва\n2. **ало**\n3. *амаксуп*\n# 4. ','2025-07-04','абвг',3,'png',1),(9,'7','7','2025-06-28','7',7,'image.png',1),(10,'8','8','2025-06-28','8',8,'741q7njztqo8gw0ssss4k4w0g.jpg',1),(11,'9','9','2025-07-03','9',9,'png',1),(12,'11','1','2025-07-02','Одинцово',1,'3.drawio.png',1),(14,'11','окак','2025-06-22','1',11,'3.drawio.png',1),(15,'проверочка','22','2025-06-21','2',22,'drawio.png',1),(17,'Алена',' е ймукфск','2025-06-24','2',6,'3.drawio.png',1),(18,'Прыжки на батут без парашюта','**Вы приходите, покупаете рюкзак без парашюта, а там сами разберётесь. Если вдруг продавец не двигается - бегите что есть сил, это инцидент 212. Итак, вот инструкции по выживанию:**\n1) Не смотрите продавцу в глаза\n2) Если вы услышали шорохи позади вас - он уже тут, бегите!!!!!\n3) Если вы слышите детский лепет - не идите на него, это ловушка\n4) Небо здесь ненастоящее, понятие времени сломано, всё, что тут реально - это вы.\n5) Если вы видите одиноко стояющую дверь посреди батутного центра - скорее бегите в неё, это выход в реальный мир.\n# УДАЧИ!','2000-09-23','Батутный центр \"Пока никто не жаловался\"',12,'output.jpg',1),(20,'Я снова на коне','**Я 1 на коне, в смысле количество волонтёров?**','2029-09-23','Конь',1,'images.png',1),(21,'banany','alert(\'hello!!\')','2025-06-29','Батутный центр \"Пока никто не жаловался\"',131,'banany-960-960x540.jpg',1),(22,'Чистый парк','**Субботник по уборке территории: сбор и вывоз мусора, сортировка вторсырья, установка новых урн.**','2025-07-06','Центральный парк города',2,'beautiful-park_1417-1417.png',1),(23,'Благотворительный забег','**Помощь в организации и сопровождении участников благотворительного 5 км забега – пункт питания и гиды.**','2025-07-02','Набережная реки',1,'Eisk2006.jpg',1),(24,'Книжный марафон','**Чтение сказок и проведение мастер-классов для детей 6–10 лет, помощь в оформлении книжных полок.**','2025-06-29','Городская детская библиотека',5,'8d099ee0c8efc78a239ee84133c2fd68.jpg',1),(25,'Акция «Тёплые вещи»','*Сбор, сортировка и упаковка тёплых вещей для бездомных, раздача комплектов в приютах и на улицах города.*','2025-06-30','Волонтёрский центр «Рука помощи»',10,'2123.970.jpg',1),(26,'День в приюте для животных','# Выгул собак, уборка в вольерах, кормление питомцев и мелкий ремонт будок, регистрация нового потока гостей.','2025-07-03','Городской приют «Лапа друга»',15,'images.jpg',1),(27,'Посади дерево','# Костная мука, саженцы - лес готов!','2025-07-06','Сервер Heheherrrr',3,'photo_2025-06-23_03-25-03.jpg',1),(28,'Кровь — это жизнь','**Помощь в организации пункта донорства: встреча доноров, оформление документов, контроль постпроцедуры.**','2025-07-05','Городская больница № 3',12,'62fb73f538c7ccf6cb31bede63b36d9d.jpg',1),(29,'IT для всех','**Проведение бесплатных мастер-классов по основам компьютера и интернета для пожилых людей.**','2025-07-04','Большая семеновская',14,'photo_2023-10-27_00-51-22.jpg',1);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registrations`
--

DROP TABLE IF EXISTS `registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `volunteer_id` int NOT NULL,
  `contact_info` varchar(255) NOT NULL,
  `registered_at` datetime NOT NULL,
  `status` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `volunteer_id` (`volunteer_id`),
  CONSTRAINT `registrations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `registrations_ibfk_2` FOREIGN KEY (`volunteer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations`
--

LOCK TABLES `registrations` WRITE;
/*!40000 ALTER TABLE `registrations` DISABLE KEYS */;
INSERT INTO `registrations` VALUES (1,2,5,'Физикова Алена Сергеевна','2025-06-21 04:14:11','accepted'),(2,2,4,'цифры знаете - наберешь','2025-06-21 04:48:44','rejected'),(3,3,4,'хз','2025-06-21 04:49:15','accepted'),(6,5,3,'цифры знаете - наберешь','2025-06-21 22:43:45','accepted'),(7,3,3,'хз','2025-06-21 23:10:41','accepted'),(8,5,4,'хз','2025-06-21 23:57:00','accepted'),(9,7,3,'2132424r','2025-06-22 00:23:12','accepted'),(10,14,4,'891823456','2025-06-22 04:56:18','pending'),(11,7,5,'дал бог зайку - даст и лужайку','2025-06-22 08:45:11','accepted'),(12,9,5,'2132424r','2025-06-22 22:03:11','accepted'),(13,12,4,'цифры знаете - наберешь','2025-06-22 22:09:23','accepted'),(15,21,3,'цифры знаешь - наберешь','2025-06-23 00:29:19','accepted'),(16,9,3,'2132424r','2025-06-23 00:29:29','accepted'),(17,17,3,'ууцйцйц','2025-06-23 00:29:41','pending'),(18,25,3,'люблю есть салаты','2025-06-23 00:30:05','accepted'),(19,24,3,'села муха на варенье вот и все стихотворение','2025-06-23 00:30:37','rejected'),(20,29,3,'крипер2004 свяжись со мной','2025-06-23 00:31:00','accepted'),(21,17,4,'cccc','2025-06-23 00:31:41','pending'),(22,24,4,'555','2025-06-23 00:31:52','accepted'),(23,25,4,'89189328844','2025-06-23 00:32:11','accepted'),(24,22,4,'дал бог зайку - даст и лужайку','2025-06-23 00:32:24','pending'),(25,27,5,'кошмарики','2025-06-23 00:35:21','pending');
/*!40000 ALTER TABLE `registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Суперпользователь, имеет полный доступ к системе'),(2,'moderator','Может редактировать данные мероприятий и модерацию заявок'),(3,'user','Обычный пользователь, может просматривать и регистрироваться');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(64) NOT NULL,
  `password_hash` varchar(128) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `patronymic` varchar(64) DEFAULT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','pbkdf2:sha256:1000000$eML1PsIDl6mxFUys$b2a9890dc7f8801f58f90f2ae780a804bdde0e8e4089fa2ca847a7355e2df07c','Комиссарова','Алена','Сергеевна',1),(2,'mod_login','pbkdf2:sha256:1000000$NyBrU5qdZmOdml8m$c03af3b090d7d7bac66a6b5e3a131172f5353c0b6e205a0f1b36c024a68565fc','Иванов','Иван','Александрович',2),(3,'vol1','pbkdf2:sha256:1000000$sDlRgIF6lBGYB2m1$2bdd6f2705a79f969c174d5b33dc2a9703185832d4a1211dc8c255b796a07c13','Иванова','Анна','Ивановна',3),(4,'vol2','pbkdf2:sha256:1000000$oqRTsdHBZpRSNM6H$2915012be2d17a488104b5c2cae82cbdc1b5fe607061861edaf23c49ef7f26ea','Петров','Лучезар','Сергеевич',3),(5,'vol3','pbkdf2:sha256:1000000$X02QaaFkLQKQcfns$dbd15596c1d9ca5223f82ccd1593cf8623e8d2e21b942fff46e32aed86e4692e','Соколова','Мария','Олеговна',3);
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

-- Dump completed on 2025-06-23  0:47:35
