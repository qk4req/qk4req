-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.7.29-log - MySQL Community Server (GPL)
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
CREATE DATABASE IF NOT EXISTS `qk4req` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `qk4req`;

-- Дамп структуры для таблица qk4req.admins
DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signature` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `signature` (`signature`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.admins: ~0 rows (приблизительно)
DELETE FROM `admins`;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` (`id`, `name`, `signature`, `level`) VALUES
	(1, 'qk4req', '124b55b62fab6b195b7e52ff96b31baf', 100);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.challenges
DROP TABLE IF EXISTS `challenges`;
CREATE TABLE IF NOT EXISTS `challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) DEFAULT NULL,
  `easter_egg_id` int(11) DEFAULT NULL,
  `from` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` float(11,2) unsigned DEFAULT NULL,
  `original_amount` float(11,4) unsigned DEFAULT NULL,
  `original_currency` char(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `platform` enum('da','donationalerts','sl','streamlabs') COLLATE utf8mb4_unicode_ci NOT NULL,
  `dubbing_src` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('shown','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`notification_id`),
  KEY `FK2` (`easter_egg_id`),
  CONSTRAINT `FK_to_easter_eggs1` FOREIGN KEY (`easter_egg_id`) REFERENCES `easter_eggs` (`id`),
  CONSTRAINT `FK_to_notification1` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.donations: ~7 rows (приблизительно)
DELETE FROM `donations`;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
INSERT INTO `donations` (`id`, `notification_id`, `easter_egg_id`, `from`, `amount`, `original_amount`, `original_currency`, `comment`, `created_at`, `platform`, `dubbing_src`, `status`) VALUES
	(1, 4, NULL, 'John', 29.00, NULL, NULL, 'This is a test donation for RUB29.00.', '2020-12-04 18:25:58', 'streamlabs', 'https://polly.streamlabs.com/v1/speech?OutputFormat=ogg_vorbis&Text=This%20is%20a%20test%20donation%20for%20RUB29.00.&VoiceId=Maxim&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIHKNQTJ7BGLEFVZA%2F20201204%2Fus-west-2%2Fpolly%2Faws4_request&X-Amz-Date=20201204T182556Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Signature=f3ae9ab1570c42ac92f3c63e73c2647ddebff54a946127f66708368a3c5c59fa', 'shown'),
	(2, 4, NULL, 'John', 16.00, NULL, NULL, 'This is a test donation for RUB16.00.', '2020-12-04 18:25:59', 'streamlabs', 'https://polly.streamlabs.com/v1/speech?OutputFormat=ogg_vorbis&Text=This%20is%20a%20test%20donation%20for%20RUB16.00.&VoiceId=Maxim&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIHKNQTJ7BGLEFVZA%2F20201204%2Fus-west-2%2Fpolly%2Faws4_request&X-Amz-Date=20201204T182556Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Signature=c051718c3709ffc191014d96636cfb4215d0a5ecb04f5a1cc13b8e11deeab8c8', 'shown'),
	(3, 4, NULL, 'John', 18.00, NULL, NULL, 'This is a test donation for RUB18.00.', '2020-12-04 18:26:00', 'streamlabs', 'https://polly.streamlabs.com/v1/speech?OutputFormat=ogg_vorbis&Text=This%20is%20a%20test%20donation%20for%20RUB18.00.&VoiceId=Maxim&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIHKNQTJ7BGLEFVZA%2F20201204%2Fus-west-2%2Fpolly%2Faws4_request&X-Amz-Date=20201204T182557Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Signature=578f7707a36b4253a365e2ab79ad4cbb08616d625da903a285484e40c7ade3e8', 'shown'),
	(4, 4, NULL, 'John', 73.00, NULL, NULL, 'This is a test donation for RUB73.00.', '2020-12-04 18:26:01', 'streamlabs', 'https://polly.streamlabs.com/v1/speech?OutputFormat=ogg_vorbis&Text=This%20is%20a%20test%20donation%20for%20RUB73.00.&VoiceId=Maxim&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIHKNQTJ7BGLEFVZA%2F20201204%2Fus-west-2%2Fpolly%2Faws4_request&X-Amz-Date=20201204T182559Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Signature=0a01789db6a5aa8f0509bde40ad72498db759b30d88f0eb22cc332c52ad2eb41', 'shown'),
	(5, 4, NULL, 'John', 7.00, NULL, NULL, 'This is a test donation for RUB7.00.', '2020-12-04 18:26:02', 'streamlabs', 'https://polly.streamlabs.com/v1/speech?OutputFormat=ogg_vorbis&Text=This%20is%20a%20test%20donation%20for%20RUB7.00.&VoiceId=Maxim&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIHKNQTJ7BGLEFVZA%2F20201204%2Fus-west-2%2Fpolly%2Faws4_request&X-Amz-Date=20201204T182559Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Signature=76a59445ca14328b185fe3783ec1f7ef358edc682ac08930b296b8901fbc4521', 'shown'),
	(6, 4, NULL, 'John', 71.00, NULL, NULL, 'This is a test donation for RUB71.00.', '2020-12-04 18:26:03', 'streamlabs', 'https://polly.streamlabs.com/v1/speech?OutputFormat=ogg_vorbis&Text=This%20is%20a%20test%20donation%20for%20RUB71.00.&VoiceId=Maxim&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIHKNQTJ7BGLEFVZA%2F20201204%2Fus-west-2%2Fpolly%2Faws4_request&X-Amz-Date=20201204T182600Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Signature=46916d64558ebe3c6569d5d2433e2b9c34ea599210a5cb1ec90963e4d801cf81', 'shown'),
	(7, 4, NULL, 'John', 14.00, NULL, NULL, 'This is a test donation for RUB14.00.', '2020-12-04 18:26:03', 'streamlabs', 'https://polly.streamlabs.com/v1/speech?OutputFormat=ogg_vorbis&Text=This%20is%20a%20test%20donation%20for%20RUB14.00.&VoiceId=Maxim&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIHKNQTJ7BGLEFVZA%2F20201204%2Fus-west-2%2Fpolly%2Faws4_request&X-Amz-Date=20201204T182600Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Signature=4bd8088dd1a71d016d8026c7d9766e76b081a2c37b4ab89e2e979bba670e0e82', 'shown');
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.dubbings
DROP TABLE IF EXISTS `dubbings`;
CREATE TABLE IF NOT EXISTS `dubbings` (
  `id` int(11) NOT NULL,
  `src` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `volume` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.dubbings: ~0 rows (приблизительно)
DELETE FROM `dubbings`;
/*!40000 ALTER TABLE `dubbings` DISABLE KEYS */;
/*!40000 ALTER TABLE `dubbings` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.easter_eggs
DROP TABLE IF EXISTS `easter_eggs`;
CREATE TABLE IF NOT EXISTS `easter_eggs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expression` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` float(11,2) NOT NULL,
  `src` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.easter_eggs: ~7 rows (приблизительно)
DELETE FROM `easter_eggs`;
/*!40000 ALTER TABLE `easter_eggs` DISABLE KEYS */;
INSERT INTO `easter_eggs` (`id`, `expression`, `value`, `src`) VALUES
	(2, '>=', 100.00, '/assets/media/easter_eggs/bratishka.mp3'),
	(3, '>=', 200.00, '/assets/media/easter_eggs/88005553535.mp3'),
	(4, '>=', 500.00, '/assets/media/easter_eggs/dimooon.mp3'),
	(5, '>=', 1000.00, '/assets/media/easter_eggs/uebishe.mp3'),
	(6, '>=', 5000.00, '/assets/media/easter_eggs/pfrf.mp3'),
	(7, '>=', 10000.00, '/assets/media/easter_eggs/akulenok.mp3'),
	(9, '>=', 50000.00, '/assets/media/easter_eggs/kari4.mp3');
/*!40000 ALTER TABLE `easter_eggs` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.followers
DROP TABLE IF EXISTS `followers`;
CREATE TABLE IF NOT EXISTS `followers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `platform` enum('tw','twitch','sl','streamlabs') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'streamlabs',
  `status` enum('shown','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK1` (`notification_id`),
  CONSTRAINT `FK_to_notification2` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.followers: ~1 rows (приблизительно)
DELETE FROM `followers`;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` (`id`, `notification_id`, `name`, `created_at`, `platform`, `status`) VALUES
	(19, 6, 'ol3jkeee', '2020-12-04 18:14:53', 'twitch', 'shown');
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('donation','follower','subscription','progress_bar','dubbing') COLLATE utf8mb4_unicode_ci NOT NULL,
  `src` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.notifications: ~4 rows (приблизительно)
DELETE FROM `notifications`;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`id`, `type`, `src`) VALUES
	(4, 'donation', '/assets/media/notifications/shnir-don.mp3'),
	(6, 'follower', '/assets/media/notifications/zdrastitya-fol.mp3'),
	(7, 'subscription', '/assets/media/notifications/dimooon-sub.mp3'),
	(8, 'progress_bar', '/assets/media/notifications/progress_bar.mp3');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.progress_bar_levels
DROP TABLE IF EXISTS `progress_bar_levels`;
CREATE TABLE IF NOT EXISTS `progress_bar_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `points` int(11) NOT NULL,
  `color` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notification_id` (`notification_id`),
  KEY `stream_id` (`session_id`),
  CONSTRAINT `FK_to_notification4` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`),
  CONSTRAINT `FK_to_session1` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `FK_to_session2` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.progress_bar_points: ~0 rows (приблизительно)
DELETE FROM `progress_bar_points`;
/*!40000 ALTER TABLE `progress_bar_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `progress_bar_points` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.subscriptions
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `months` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `status` enum('shown','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK1` (`notification_id`),
  CONSTRAINT `FK_to_notification3` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы qk4req.subscriptions: ~0 rows (приблизительно)
DELETE FROM `subscriptions`;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;

-- Дамп структуры для таблица qk4req.vote
DROP TABLE IF EXISTS `vote`;
CREATE TABLE IF NOT EXISTS `vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voting_id` int(11) NOT NULL,
  `voting_point_id` int(11) NOT NULL,
  `signature` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`voting_point_id`),
  KEY `FK2` (`voting_id`),
  CONSTRAINT `FK_to_voting1` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`),
  CONSTRAINT `FK_to_voting_point` FOREIGN KEY (`voting_point_id`) REFERENCES `voting_points` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voting_id` int(11) NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `background_color` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `border_color` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1` (`voting_id`),
  CONSTRAINT `FK_to_voting2` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
