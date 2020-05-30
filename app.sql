-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.7.20 - MySQL Community Server (GPL)
-- Операционная система:         Win64
-- HeidiSQL Версия:              10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных app
DROP DATABASE IF EXISTS `app`;
CREATE DATABASE IF NOT EXISTS `app` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `app`;

-- Дамп структуры для таблица app.admins
DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `signature` varchar(50) NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `signature` (`signature`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.admins: ~1 rows (приблизительно)
DELETE FROM `admins`;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` (`id`, `name`, `signature`, `level`) VALUES
	(1, 'qk4req', '124b55b62fab6b195b7e52ff96b31baf', 100);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

-- Дамп структуры для таблица app.challenges
DROP TABLE IF EXISTS `challenges`;
CREATE TABLE IF NOT EXISTS `challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `link` varchar(500) DEFAULT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.challenges: ~2 rows (приблизительно)
DELETE FROM `challenges`;
/*!40000 ALTER TABLE `challenges` DISABLE KEYS */;
INSERT INTO `challenges` (`id`, `title`, `description`, `link`, `start`, `end`) VALUES
	(1, 'Гаражный челлендж', 'Прожить в гараже год!', 'https://vk.com/topic-178832593_40083945?post=13', 1550330065, 1560816065),
	(2, 'Корч "Шкуровозка"', 'Мне нужно построить корч-проект "Шкуровозка".', 'https://vk.com/topic-178832593_40083945?post=14', 1550330065, 1585866065);
/*!40000 ALTER TABLE `challenges` ENABLE KEYS */;

-- Дамп структуры для таблица app.donations
DROP TABLE IF EXISTS `donations`;
CREATE TABLE IF NOT EXISTS `donations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `name` char(50) NOT NULL,
  `amount` float(11,2) unsigned NOT NULL,
  `currency` varchar(3) NOT NULL DEFAULT 'RUB',
  `comment` varchar(1000) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`notification_id`),
  CONSTRAINT `FK_to_notification1` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5844932 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.donations: ~22 rows (приблизительно)
DELETE FROM `donations`;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
INSERT INTO `donations` (`id`, `notification_id`, `name`, `amount`, `currency`, `comment`, `created_at`) VALUES
	(1, 5, 'asdasdas', 3000.00, 'RUB', 'завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали ', 1544175944),
	(4885288, 4, 'Аноним', 123.00, 'RUB', '123', 1544176064),
	(4897205, 4, 'Аноним', 123.33, 'RUB', '3', 1544268106),
	(4897206, 5, 'asdasdas4', 1000.00, 'RUB', '123', 1544181660),
	(4897210, 4, 'Аноним4', 123.00, 'RUB', '123', 1542210420),
	(4907663, 4, 'Аноним', 123.81, 'RUB', '123', 1544353507),
	(4983349, 4, 'Аноним2', 123.00, 'RUB', 'завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали ', 1544969794),
	(5253952, 5, 'Аноним1', 123.00, 'RUB', '123', 1546967120),
	(5420873, 4, 'test', 123.00, 'RUB', '123', 1548073027),
	(5420893, 4, '1', 123.00, 'RUB', '123', 1548073020),
	(5571490, 4, 'Аноним', 123.00, 'RUB', 'ЭТО ТЕСТ!', 1556467020),
	(5844921, 4, 'Аноним', 100.00, 'RUB', 'НА ТЕБЕ ПО ИПАЛУ!', 1551257643),
	(5844922, 5, 'ЕБАЛО', 3000.00, 'RUB', 'завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали ', 1544175944),
	(5844923, 5, 'ЕБАЛО1', 3000.00, 'RUB', 'завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали ', 1544175944),
	(5844924, 5, 'ЕБАЛО2', 3000.00, 'RUB', 'завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали ', 1544175944),
	(5844925, 5, 'ЕБАЛО455', 3000.00, 'RUB', 'завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали завали ', 1556467020),
	(5844926, 4, 'John', 66.00, 'RUB', 'This is a test donation for RUB66.00.', 1560354129),
	(5844927, 4, 'John', 6.00, 'RUB', 'This is a test donation for RUB6.00.', 1560354163),
	(5844928, 4, 'John', 86.00, 'RUB', 'This is a test donation for RUB86.00.', 1560354252),
	(5844929, 4, 'John', 76.00, 'RUB', 'This is a test donation for RUB76.00.', 1560869199),
	(5844930, 4, 'John', 14.00, 'RUB', 'This is a test donation for RUB14.00.', 1563042718),
	(5844931, 5, 'asdasd', 11111.00, 'RUB', 'asdasd', 1576342436);
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;

-- Дамп структуры для таблица app.easter_eggs
DROP TABLE IF EXISTS `easter_eggs`;
CREATE TABLE IF NOT EXISTS `easter_eggs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `expression` varchar(10) NOT NULL,
  `value` float(11,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.easter_eggs: ~1 rows (приблизительно)
DELETE FROM `easter_eggs`;
/*!40000 ALTER TABLE `easter_eggs` DISABLE KEYS */;
INSERT INTO `easter_eggs` (`id`, `notification_id`, `expression`, `value`) VALUES
	(1, 0, '>=', 1000.00);
/*!40000 ALTER TABLE `easter_eggs` ENABLE KEYS */;

-- Дамп структуры для таблица app.followers
DROP TABLE IF EXISTS `followers`;
CREATE TABLE IF NOT EXISTS `followers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`notification_id`),
  CONSTRAINT `FK_to_notification2` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.followers: ~7 rows (приблизительно)
DELETE FROM `followers`;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` (`id`, `notification_id`, `name`, `created_at`) VALUES
	(1, 6, 'qk4req', 1560354207),
	(2, 6, 'qk4req', 1560354246),
	(3, 6, 'qk4req', 1560869194),
	(4, 6, 'qk4req', 1563043106),
	(5, 6, 'qk4req', 1563043140),
	(6, 6, 'qk4req', 1563043178),
	(7, 6, 'qk4req', 1576341972);
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;

-- Дамп структуры для таблица app.notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `easter_egg_id` int(11) DEFAULT NULL,
  `type` enum('donation','follower','subscription','easter_egg','progress_bar') NOT NULL,
  `volume` float unsigned NOT NULL DEFAULT '1',
  `src` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`),
  KEY `FK1` (`easter_egg_id`),
  CONSTRAINT `FK_to_easter_egg` FOREIGN KEY (`easter_egg_id`) REFERENCES `easter_eggs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.notifications: ~5 rows (приблизительно)
DELETE FROM `notifications`;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`id`, `easter_egg_id`, `type`, `volume`, `src`) VALUES
	(4, NULL, 'donation', 1, '/assets/media/notifications/donation.mp3'),
	(5, 1, 'easter_egg', 1, '/assets/media/notifications/easter_eggs/dimooon.mp3'),
	(6, NULL, 'follower', 1, '/assets/media/notifications/follower.mp3'),
	(7, NULL, 'subscription', 1, '/assets/media/notifications/subscription.mp3'),
	(8, NULL, 'progress_bar', 1, '/assets/media/notifications/progress_bar.mp3');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Дамп структуры для таблица app.progress_bar_levels
DROP TABLE IF EXISTS `progress_bar_levels`;
CREATE TABLE IF NOT EXISTS `progress_bar_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL DEFAULT '0',
  `points` int(11) NOT NULL,
  `color` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`),
  KEY `stream_id` (`session_id`),
  CONSTRAINT `FK_to_notification4` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`),
  CONSTRAINT `FK_to_session1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.progress_bar_levels: ~5 rows (приблизительно)
DELETE FROM `progress_bar_levels`;
/*!40000 ALTER TABLE `progress_bar_levels` DISABLE KEYS */;
INSERT INTO `progress_bar_levels` (`id`, `session_id`, `notification_id`, `title`, `points`, `color`) VALUES
	(1, 1, 8, '5%', 1000, '#86e01e'),
	(2, 1, 8, '25%', 5000, '#ffc746'),
	(3, 1, 8, '50%', 10000, '#f2b01e'),
	(4, 1, 8, '75%', 15000, '#f27011'),
	(5, 1, 8, '100%', 20000, '#f63a0f');
/*!40000 ALTER TABLE `progress_bar_levels` ENABLE KEYS */;

-- Дамп структуры для таблица app.progress_bar_points
DROP TABLE IF EXISTS `progress_bar_points`;
CREATE TABLE IF NOT EXISTS `progress_bar_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `FK_to_session2` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.progress_bar_points: ~0 rows (приблизительно)
DELETE FROM `progress_bar_points`;
/*!40000 ALTER TABLE `progress_bar_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `progress_bar_points` ENABLE KEYS */;

-- Дамп структуры для таблица app.sessions
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.sessions: ~1 rows (приблизительно)
DELETE FROM `sessions`;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` (`id`, `start`, `end`) VALUES
	(1, 1400939566, 0);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

-- Дамп структуры для таблица app.subscriptions
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `months` int(11) NOT NULL DEFAULT '1',
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`notification_id`),
  CONSTRAINT `FK_to_notification3` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.subscriptions: ~5 rows (приблизительно)
DELETE FROM `subscriptions`;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` (`id`, `notification_id`, `name`, `months`, `created_at`) VALUES
	(1, 7, 'qk4req', 1, 1560354222),
	(2, 7, 'qk4req', 1, 1560869200),
	(3, 7, 'qk4req', 1, 1563043008),
	(4, 7, 'qk4req', 1, 1563043201),
	(5, 7, 'qk4req', 1, 1576341975);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;

-- Дамп структуры для таблица app.vote
DROP TABLE IF EXISTS `vote`;
CREATE TABLE IF NOT EXISTS `vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voting_id` int(11) NOT NULL,
  `voting_point_id` int(11) NOT NULL,
  `signature` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`voting_point_id`),
  KEY `FK2` (`voting_id`),
  CONSTRAINT `FK_to_voting1` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`),
  CONSTRAINT `FK_to_voting_point` FOREIGN KEY (`voting_point_id`) REFERENCES `voting_points` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.vote: ~2 rows (приблизительно)
DELETE FROM `vote`;
/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
INSERT INTO `vote` (`id`, `voting_id`, `voting_point_id`, `signature`) VALUES
	(44, 3, 8, '837ec5754f503cfaaee0929fd48974e7'),
	(50, 2, 10, '202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;

-- Дамп структуры для таблица app.votings
DROP TABLE IF EXISTS `votings`;
CREATE TABLE IF NOT EXISTS `votings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.votings: ~2 rows (приблизительно)
DELETE FROM `votings`;
/*!40000 ALTER TABLE `votings` DISABLE KEYS */;
INSERT INTO `votings` (`id`, `title`, `start`, `end`) VALUES
	(2, '75%', 1547120212, 1747120212),
	(3, '100%', 1547920212, 1647120212);
/*!40000 ALTER TABLE `votings` ENABLE KEYS */;

-- Дамп структуры для таблица app.voting_points
DROP TABLE IF EXISTS `voting_points`;
CREATE TABLE IF NOT EXISTS `voting_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voting_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `background_color` varchar(50) NOT NULL,
  `border_color` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`voting_id`),
  CONSTRAINT `FK_to_voting2` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы app.voting_points: ~8 rows (приблизительно)
DELETE FROM `voting_points`;
/*!40000 ALTER TABLE `voting_points` DISABLE KEYS */;
INSERT INTO `voting_points` (`id`, `voting_id`, `title`, `background_color`, `border_color`) VALUES
	(1, 3, 'Дракоша "ТОХА" ', 'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 1)'),
	(5, 3, 'Заправиться бензом 100мл ', 'rgba(54, 162, 235, 0.2)', 'rgba(54, 162, 235, 1)'),
	(6, 3, 'Постоять в углу час ', 'rgba(255, 206, 86, 0.2)', 'rgba(255, 206, 86, 1)'),
	(7, 3, 'Потягать штангу 50 раз', 'rgba(75, 192, 192, 0.2)', 'rgba(75, 192, 192, 1)'),
	(8, 3, 'Прокричать чайкой 100 раз', 'rgba(153, 102, 255, 0.2)', 'rgba(153, 102, 255, 1)'),
	(9, 3, 'Пробить стекло головой', 'rgba(255, 159, 64, 0.2)', 'rgba(255, 159, 64, 1)'),
	(10, 2, 'Выключить стрим', 'rgba(255, 159, 64, 0.2)', 'rgba(255, 159, 64, 1)'),
	(11, 2, 'Выключить стрим2', 'rgba(255, 159, 64, 0.2)', 'rgba(255, 159, 64, 1)');
/*!40000 ALTER TABLE `voting_points` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
