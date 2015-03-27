/*
SQLyog Community v12.03 (64 bit)
MySQL - 5.6.20 : Database - ccoach
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ccoach` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db570633470`;

/*Table structure for table `gamesession` */

DROP TABLE IF EXISTS `gamesession`;

CREATE TABLE `gamesession` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `accessTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1D6329D464B64DCC` (`userId`),
  CONSTRAINT `FK_1D6329D464B64DCC` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `gamesession` */

insert  into `gamesession`(`id`,`userId`,`points`,`accessTime`) values (1,3,273,'2015-02-26 22:32:07'),(2,3,273,'2015-02-26 22:33:52'),(3,3,273,'2015-02-26 22:39:24'),(4,3,273,'2015-02-26 22:40:04'),(5,3,273,'2015-02-26 23:10:42'),(6,3,0,'2015-03-13 20:57:02'),(7,3,0,'2015-03-14 01:13:07'),(8,3,512,'2015-03-14 01:25:38'),(9,3,273,'2015-03-14 13:13:59'),(10,14,127,'2015-03-15 23:13:34'),(11,14,326,'2015-03-15 23:23:25'),(15,3,254,'2015-03-16 22:25:46'),(16,3,122,'2015-03-16 23:24:15'),(17,3,611,'2015-03-22 23:14:30'),(18,3,128,'2015-03-25 00:27:37');

/*Table structure for table `logintable` */

DROP TABLE IF EXISTS `logintable`;

CREATE TABLE `logintable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `logintable` */

insert  into `logintable`(`id`,`userName`,`password`) values (1,'javi','4a9c7bc7049492b1dd402265045948e0'),(6,'guest','084e0343a0486ff05530df6c705c8bb4'),(9,'paco@porras.es','4a9c7bc7049492b1dd402265045948e0'),(10,'maria_kuman@yahoo.de','ce8611dbc32f045588548c9dbfef1aeb'),(11,'cosquer@monguer.de','9f04f4d2341d5ea8be52e8d4b398ae68'),(12,'cosquer2@monguer.de','9f04f4d2341d5ea8be52e8d4b398ae68'),(13,'cosquer23@monguer.de','9f04f4d2341d5ea8be52e8d4b398ae68'),(14,'cosquerrer@mongo.de','449dbee947bc2f5d4b788d4235670c0d'),(15,'kokocroko@mosco.co','4c193eb3ec2ce5f02b29eba38621bea1'),(16,'fedegarrido79@gmail.com','65eed50e11bf650a709bc1138a992e7e');

/*Table structure for table `questiontype` */

DROP TABLE IF EXISTS `questiontype`;

CREATE TABLE `questiontype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionIdent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `questiontype` */

insert  into `questiontype`(`id`,`questionIdent`,`level`) values (1,'notesOfInterval',1),(2,'intervalOfNotes',1),(3,'notesOfChord',2),(4,'chordOfNotes',3),(5,'notesOfScale',4),(6,'scaleOfNotes',5),(7,'degreeOfChord',99),(8,'chordOfDegree',99),(9,'chordBelongsToScale',99),(10,'notesOfDistance',0),(11,'distanceOfNotes',0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `userId` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `points` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `pointsThisWeek` int(11) NOT NULL,
  `lastAccess` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`fullName`,`userId`,`points`,`level`,`pointsThisWeek`,`lastAccess`) values (3,'Javi Donado','javi',17700,5,3265,'2015-03-25 00:27:37'),(5,'Paco','paco',0,1,234,'2015-02-26 22:40:04'),(6,'Lolo','lolo',432,1,34,NULL),(7,'Moloco','moloco',1143,1,543,NULL),(8,'Krokako','krokako',334,1,213,'2015-02-26 22:40:04'),(9,'Moneino','moneino',665,1,443,NULL),(10,'guest','guest',0,0,0,'2015-03-16 22:15:55'),(13,'paco','paco@porras.es',0,0,0,NULL),(14,'maria_kuman','maria_kuman@yahoo.de',453,0,453,'2015-03-15 23:23:25'),(15,'cosquer','cosquer@monguer.de',0,0,0,NULL),(16,'cosquer2','cosquer2@monguer.de',0,0,0,NULL),(17,'cosquer23','cosquer23@monguer.de',0,0,0,NULL),(18,'cosquerrer','cosquerrer@mongo.de',0,0,0,NULL),(19,'kokocroko','kokocroko@mosco.co',0,0,0,NULL),(20,'fedegarrido79','fedegarrido79@gmail.com',0,0,0,NULL);

/*Table structure for table `userskill` */

DROP TABLE IF EXISTS `userskill`;

CREATE TABLE `userskill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currentSkill` int(11) NOT NULL,
  `numberOfAnswers` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `questionTypeId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3AA9750264B64DCC` (`userId`),
  KEY `IDX_3AA97502268B6C3E` (`questionTypeId`),
  CONSTRAINT `FK_3AA97502268B6C3E` FOREIGN KEY (`questionTypeId`) REFERENCES `questiontype` (`id`),
  CONSTRAINT `FK_3AA9750264B64DCC` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `userskill` */

insert  into `userskill`(`id`,`currentSkill`,`numberOfAnswers`,`userId`,`questionTypeId`) values (1,1,29,3,1),(2,0,3,3,2),(3,0,4,3,3),(4,1,28,3,4),(5,0,2,3,5),(6,1,28,3,6),(7,-1,0,13,1),(8,-1,0,10,10),(9,0,14,14,10),(10,0,3,3,10),(11,0,2,3,11),(12,-1,0,14,11),(13,-1,0,10,11);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
