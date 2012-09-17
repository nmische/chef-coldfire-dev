/* Database and User */

CREATE DATABASE `coldfiretest`;
CREATE USER 'coldfiretest'@'%' IDENTIFIED BY 'coldfiretest';
GRANT ALL ON `coldfiretest`.* TO 'coldfiretest'@'%';
GRANT SELECT ON `mysql`.`proc` TO 'coldfiretest'@'%'; 

/* User Types Table */

SET NAMES latin1;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `coldfiretest`.`UserTypes` (
  `UserTypeID` int(11) NOT NULL auto_increment,
  `UserType` varchar(20) NOT NULL,
  PRIMARY KEY  (`UserTypeID`),
  KEY `UserTypeID` (`UserTypeID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO `coldfiretest`.`UserTypes` VALUES('1','Passenger'),
 ('2','Other');

SET FOREIGN_KEY_CHECKS = 1;

/* Users Table */

SET NAMES latin1;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `coldfiretest`.`Users` (
  `UserID` int(11) NOT NULL auto_increment,
  `FirstName` varchar(50) default NULL,
  `LastName` varchar(50) default NULL,
  `Active` bit(1) default NULL,
  `UserTypeID` int(11) default NULL,
  `UserCode` char(3) default NULL,
  PRIMARY KEY  (`UserID`),
  KEY `UserTypeID` (`UserTypeID`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

INSERT INTO `coldfiretest`.`Users` VALUES('1','Kate','Austen',b'00000001','1','SUR'),
 ('2','Boone','Carlyle',b'00000000','1','SUR'),
 ('3','Ana Lucia','Cortez',b'00000000','1','SUR'),
 ('4','Michael','Dawson',b'00000000','1','SUR'),
 ('5','James','Ford',b'00000001','1','SUR'),
 ('6','Sayid','Jarrah',b'00000001','1','SUR'),
 ('7','Jin-Soo','Kwon',b'00000001','1','SUR'),
 ('8','Sun-Hwa','Kwon',b'00000001','1','SUR'),
 ('9','Claire','Littleton',b'00000001','1','SUR'),
 ('10','Walt','Lloyd',b'00000000','1','SUR'),
 ('11','John','Locke',b'00000001','1','SUR'),
 ('12','Charlie','Pace',b'00000001','1','SUR'),
 ('13','Hugo','Reyes',b'00000001','1','SUR'),
 ('14','Shannon','Rutherford',b'00000000','1','SUR'),
 ('15','Jack','Shephard',b'00000001','1','SUR'),
 ('16','Ben','Linus',b'00000001','2','OTH'),
 ('17','Richard','Alpert',b'00000001','2','OTH'),
 ('18','Danny','Pickett',b'00000000','2','OTH'),
 ('19','Ethan','Rom',b'00000000','2','OTH'),
 ('20','Goodwin','Stanhope',b'00000000','2','OTH'),
 ('21','Juliet','Burke',b'00000001','2','OTH');

SET FOREIGN_KEY_CHECKS = 1;

/* GetUsers Procedure */

DELIMITER $$

DROP PROCEDURE IF EXISTS `coldfiretest`.`GetUsers`$$
CREATE PROCEDURE `coldfiretest`.`GetUsers` (
		fnfilter VARCHAR(10),
		lnfilter VARCHAR(10),
		afilter BIT
)
BEGIN
	SELECT 
		* 
	FROM 
		Users
	WHERE
		1=1
		AND (FirstName LIKE CONCAT(fnfilter, '%') OR fnfilter IS NULL)
		AND (FirstName LIKE CONCAT(lnfilter, '%') OR lnfilter IS NULL)
		AND (FirstName LIKE CONCAT(afilter, '%') OR afilter IS NULL);
END$$

DELIMITER ;