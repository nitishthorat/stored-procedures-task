-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: localhost    Database: company
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES (1,2,'Updated salary for existing employee','2025-07-10 23:43:20'),(2,3,'New employee added with details and salary','2025-07-10 23:54:32'),(3,4,'New employee added with details and salary','2025-07-11 01:06:19'),(4,3,'Updated salary for existing employee','2025-07-17 20:07:28'),(5,5,'New employee added with details and salary','2025-07-17 20:08:17'),(6,3,'Updated salary for existing employee','2025-07-17 20:10:31'),(7,6,'New employee added with details and salary','2025-07-17 20:11:35'),(8,2,'Updated salary for existing employee','2025-07-18 16:01:37'),(9,7,'New employee added with details and salary','2025-07-18 16:02:12'),(10,8,'New employee added with details and salary','2025-07-18 16:06:27'),(11,8,'Updated salary for existing employee','2025-07-18 16:07:15');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_details`
--

DROP TABLE IF EXISTS `employee_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `employee_details_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_details`
--

LOCK TABLES `employee_details` WRITE;
/*!40000 ALTER TABLE `employee_details` DISABLE KEYS */;
INSERT INTO `employee_details` VALUES (1,3,'2023-08-01','john.doe@example.com'),(2,4,'2025-05-01','aditya@gmail.com'),(3,5,'2025-05-01','nitishthorat112@gmail.com'),(4,6,'2025-07-17','nitish@example.com'),(5,7,'2025-07-17','nitish@example.com'),(6,8,'2025-07-01','ayushi@gmail.com');
/*!40000 ALTER TABLE `employee_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Alice Johnson','Engineering'),(2,'John Doe','Engineering'),(3,'Nitish Thorat','Engineering'),(4,'Aditya Sharma','Technology'),(5,'Adam Scott','Engineering'),(6,'Tony Stark','Engineering'),(7,'Rahul Sharma','Engineering'),(8,'Ayushi Shah','Engineering');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscriber_id` int DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `subscriber_id` (`subscriber_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`subscriber_id`) REFERENCES `users` (`id`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,2,1,'New post from Alice: Alice\'s first post','2025-07-11 09:07:55'),(2,3,1,'New post from Alice: Alice\'s first post','2025-07-11 09:07:55'),(3,2,2,'New post from user 1: Test Post','2025-07-11 09:13:43'),(4,3,2,'New post from user 1: Test Post','2025-07-11 09:13:43'),(5,2,3,'New post from user 1: Hello World!','2025-07-11 09:23:37'),(6,3,3,'New post from user 1: Hello World!','2025-07-11 09:23:37'),(7,2,4,'New post from user 1: Hello World!','2025-07-11 09:25:13'),(8,3,4,'New post from user 1: Hello World!','2025-07-11 09:25:13'),(9,2,5,'New post from user 1: Hello World!','2025-07-11 09:32:47'),(10,3,5,'New post from user 1: Hello World!','2025-07-11 09:32:47'),(11,2,6,'New post from user 1: Wonderful Day','2025-07-11 09:34:26'),(12,3,6,'New post from user 1: Wonderful Day','2025-07-11 09:34:26'),(17,2,9,'New post from user 1: Bad day','2025-07-11 09:48:07'),(18,3,9,'New post from user 1: Bad day','2025-07-11 09:48:07'),(19,2,10,'New post from user 1: Test message','2025-07-18 09:11:07'),(20,3,10,'New post from user 1: Test message','2025-07-18 09:11:07');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'Alice\'s first post','2025-07-11 09:07:55'),(2,1,'Test Post','2025-07-11 09:13:43'),(3,1,'Hello World!','2025-07-11 09:23:37'),(4,1,'Hello World!','2025-07-11 09:25:13'),(5,1,'Hello World!','2025-07-11 09:32:47'),(6,1,'Wonderful Day','2025-07-11 09:34:26'),(9,1,'Bad day','2025-07-11 09:48:07'),(10,1,'Test message','2025-07-18 09:11:07');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary_records`
--

DROP TABLE IF EXISTS `salary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `base_salary` decimal(10,2) DEFAULT NULL,
  `bonus` decimal(10,2) DEFAULT NULL,
  `record_created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `salary_records_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary_records`
--

LOCK TABLES `salary_records` WRITE;
/*!40000 ALTER TABLE `salary_records` DISABLE KEYS */;
INSERT INTO `salary_records` VALUES (1,3,80000.00,5000.00,'2025-07-17 20:10:31'),(2,4,5000.00,100.00,'2025-07-11 01:06:19'),(3,5,1000.00,1500.00,'2025-07-17 20:08:17'),(4,6,80000.00,5000.00,'2025-07-17 20:11:35'),(5,7,80000.00,5000.00,'2025-07-18 16:02:12'),(6,8,1500.00,500.00,'2025-07-18 16:07:15');
/*!40000 ALTER TABLE `salary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscriber_id` int DEFAULT NULL,
  `publisher_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriber_id` (`subscriber_id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`subscriber_id`) REFERENCES `users` (`id`),
  CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (1,2,1),(2,3,1),(3,4,2);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alice','alice@example.com'),(2,'Bob','bob@example.com'),(3,'Charlie','charlie@example.com'),(4,'David','david@example.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'company'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_or_update_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_or_update_employee`(
    IN emp_name VARCHAR(100),
    IN dept VARCHAR(50),
    IN doj DATE,
    IN email VARCHAR(100),
    IN salary DECIMAL(10, 2),
    IN bonus DECIMAL(10, 2)
)
BEGIN
    DECLARE existing_id INT DEFAULT NULL;
    DECLARE new_emp_id INT;
    
    SET existing_id = NULL;

    -- Step 1: Check if employee already exists by name + dept
    SELECT e.id
    INTO existing_id
    FROM employees e
    WHERE e.name = emp_name AND e.department = dept
    LIMIT 1;

    IF existing_id IS NOT NULL THEN
        -- Step 2: Update salary
        UPDATE salary_records
        SET base_salary = salary,
            bonus = bonus,
            record_created_at = NOW()
        WHERE employee_id = existing_id;

        -- Step 3: Log update
        INSERT INTO activity_logs(employee_id, action)
        VALUES (existing_id, 'Updated salary for existing employee');

    ELSE
        -- Step 4: Insert new employee
        INSERT INTO employees(name, department)
        VALUES (emp_name, dept);

        SET new_emp_id = LAST_INSERT_ID();

        -- Step 5: Insert employee details
        INSERT INTO employee_details(employee_id, date_of_joining, contact_email)
        VALUES (new_emp_id, doj, email);

        -- Step 6: Insert salary
        INSERT INTO salary_records(employee_id, base_salary, bonus)
        VALUES (new_emp_id, salary, bonus);

        -- Step 7: Log creation
        INSERT INTO activity_logs(employee_id, action)
        VALUES (new_emp_id, 'New employee added with details and salary');
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-18 11:29:18
