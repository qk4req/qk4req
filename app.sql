-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               8.0.19 - MySQL Community Server - GPL
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.0.0.5958
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных qk4req
DROP DATABASE IF EXISTS `qk4req`;
CREATE DATABASE IF NOT EXISTS `qk4req` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `qk4req`;

-- Дамп структуры для таблица qk4req.admins
DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `signature` varchar(50) NOT NULL,
  `level` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `signature` (`signature`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.admins: ~0 rows (приблизительно)
DELETE FROM `admins`;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` (`id`, `name`, `signature`, `level`) VALUES
	(1, 'qk4req', '124b55b62fab6b195b7e52ff96b31baf', 100);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.challenges
DROP TABLE IF EXISTS `challenges`;
CREATE TABLE IF NOT EXISTS `challenges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `link` varchar(500) DEFAULT NULL,
  `start` int NOT NULL,
  `end` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.challenges: ~2 rows (приблизительно)
DELETE FROM `challenges`;
/*!40000 ALTER TABLE `challenges` DISABLE KEYS */;
INSERT INTO `challenges` (`id`, `title`, `description`, `link`, `start`, `end`) VALUES
	(1, 'Гаражный челлендж', 'Прожить в гараже год!', 'https://vk.com/topic-178832593_40083945?post=13', 1550330065, 1560816065),
	(2, 'Корч "Шкуровозка"', 'Мне нужно построить корч-проект "Шкуровозка".', 'https://vk.com/topic-178832593_40083945?post=14', 1550330065, 1585866065);
/*!40000 ALTER TABLE `challenges` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.donations
DROP TABLE IF EXISTS `donations`;
CREATE TABLE IF NOT EXISTS `donations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notification_id` int DEFAULT NULL,
  `easter_egg_id` int DEFAULT NULL,
  `from` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `amount` float(11,2) unsigned DEFAULT NULL,
  `original_amount` float(11,4) unsigned DEFAULT NULL,
  `original_currency` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `comment` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `platform` enum('da','donationalerts','sl','streamlabs') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dubbing_src` varchar(1000) DEFAULT NULL,
  `status` enum('shown','hidden') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`notification_id`),
  KEY `FK2` (`easter_egg_id`),
  CONSTRAINT `FK_to_easter_eggs1` FOREIGN KEY (`easter_egg_id`) REFERENCES `easter_eggs` (`id`),
  CONSTRAINT `FK_to_notification1` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.donations: ~0 rows (приблизительно)
DELETE FROM `donations`;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.dubbings
DROP TABLE IF EXISTS `dubbings`;
CREATE TABLE IF NOT EXISTS `dubbings` (
  `id` int NOT NULL,
  `src` varchar(1000) NOT NULL,
  `volume` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.dubbings: ~0 rows (приблизительно)
DELETE FROM `dubbings`;
/*!40000 ALTER TABLE `dubbings` DISABLE KEYS */;
/*!40000 ALTER TABLE `dubbings` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.easter_eggs
DROP TABLE IF EXISTS `easter_eggs`;
CREATE TABLE IF NOT EXISTS `easter_eggs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `expression` varchar(10) NOT NULL,
  `value` float(11,2) NOT NULL,
  `src` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.easter_eggs: ~1 rows (приблизительно)
DELETE FROM `easter_eggs`;
/*!40000 ALTER TABLE `easter_eggs` DISABLE KEYS */;
INSERT INTO `easter_eggs` (`id`, `expression`, `value`, `src`) VALUES
	(2, '>=', 1000.00, '/assets/media/easter_eggs/dimooon.mp3');
/*!40000 ALTER TABLE `easter_eggs` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.followers
DROP TABLE IF EXISTS `followers`;
CREATE TABLE IF NOT EXISTS `followers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notification_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `status` enum('shown','hidden') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`notification_id`),
  CONSTRAINT `FK_to_notification2` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.followers: ~0 rows (приблизительно)
DELETE FROM `followers`;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` (`id`, `notification_id`, `name`, `created_at`, `status`) VALUES
	(1, 6, 'test1', '2020-09-26 22:45:25', 'shown'),
	(2, 6, 'test2', '2020-09-26 22:45:25', 'shown');
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('donation','follower','subscription','progress_bar','dubbing') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `src` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.notifications: ~5 rows (приблизительно)
DELETE FROM `notifications`;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`id`, `type`, `src`) VALUES
	(4, 'donation', '/assets/media/notifications/donation.mp3'),
	(6, 'follower', '/assets/media/notifications/follower.mp3'),
	(7, 'subscription', '/assets/media/notifications/subscription.mp3'),
	(8, 'progress_bar', '/assets/media/notifications/progress_bar.mp3'),
	(9, 'dubbing', NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.progress_bar_levels
DROP TABLE IF EXISTS `progress_bar_levels`;
CREATE TABLE IF NOT EXISTS `progress_bar_levels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `notification_id` int NOT NULL,
  `title` varchar(50) NOT NULL DEFAULT '0',
  `points` int NOT NULL,
  `color` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`),
  KEY `stream_id` (`session_id`),
  CONSTRAINT `FK_to_notification4` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`),
  CONSTRAINT `FK_to_session1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.progress_bar_levels: ~5 rows (приблизительно)
DELETE FROM `progress_bar_levels`;
/*!40000 ALTER TABLE `progress_bar_levels` DISABLE KEYS */;
INSERT INTO `progress_bar_levels` (`id`, `session_id`, `notification_id`, `title`, `points`, `color`) VALUES
	(1, 1, 8, '5%', 1000, '#86e01e'),
	(2, 1, 8, '25%', 5000, '#ffc746'),
	(3, 1, 8, '50%', 10000, '#f2b01e'),
	(4, 1, 8, '75%', 15000, '#f27011'),
	(5, 1, 8, '100%', 20000, '#f63a0f');
/*!40000 ALTER TABLE `progress_bar_levels` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.progress_bar_points
DROP TABLE IF EXISTS `progress_bar_points`;
CREATE TABLE IF NOT EXISTS `progress_bar_points` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `FK_to_session2` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.progress_bar_points: ~0 rows (приблизительно)
DELETE FROM `progress_bar_points`;
/*!40000 ALTER TABLE `progress_bar_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `progress_bar_points` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.sessions
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start` int NOT NULL,
  `end` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.sessions: ~0 rows (приблизительно)
DELETE FROM `sessions`;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` (`id`, `start`, `end`) VALUES
	(1, 1400939566, 0);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.subscriptions
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notification_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `months` int NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `status` enum('shown','hidden') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`notification_id`),
  CONSTRAINT `FK_to_notification3` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.subscriptions: ~0 rows (приблизительно)
DELETE FROM `subscriptions`;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.vote
DROP TABLE IF EXISTS `vote`;
CREATE TABLE IF NOT EXISTS `vote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voting_id` int NOT NULL,
  `voting_point_id` int NOT NULL,
  `signature` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`voting_point_id`),
  KEY `FK2` (`voting_id`),
  CONSTRAINT `FK_to_voting1` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`),
  CONSTRAINT `FK_to_voting_point` FOREIGN KEY (`voting_point_id`) REFERENCES `voting_points` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.vote: ~2 rows (приблизительно)
DELETE FROM `vote`;
/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
INSERT INTO `vote` (`id`, `voting_id`, `voting_point_id`, `signature`) VALUES
	(44, 3, 8, '837ec5754f503cfaaee0929fd48974e7'),
	(50, 2, 10, '202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.votings
DROP TABLE IF EXISTS `votings`;
CREATE TABLE IF NOT EXISTS `votings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `start` int NOT NULL,
  `end` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.votings: ~2 rows (приблизительно)
DELETE FROM `votings`;
/*!40000 ALTER TABLE `votings` DISABLE KEYS */;
INSERT INTO `votings` (`id`, `title`, `start`, `end`) VALUES
	(2, '75%', 1547120212, 1747120212),
	(3, '100%', 1547920212, 1647120212);
/*!40000 ALTER TABLE `votings` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.voting_points
DROP TABLE IF EXISTS `voting_points`;
CREATE TABLE IF NOT EXISTS `voting_points` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voting_id` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `background_color` varchar(50) NOT NULL,
  `border_color` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`voting_id`),
  CONSTRAINT `FK_to_voting2` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы qk4req.voting_points: ~8 rows (приблизительно)
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
