SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `rebok2j` DEFAULT CHARACTER SET utf8;
USE `rebok2j`;

-- -----------------------------------------------------
-- Table `staff`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `staff` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`drivingLicense` VARCHAR(255) NULL DEFAULT NULL,`firstName` VARCHAR(255) NULL DEFAULT NULL,`lastName` VARCHAR(255) NULL DEFAULT NULL,`passport` VARCHAR(255) NULL DEFAULT NULL,`powerToSign` TINYINT(1) NULL DEFAULT '0',PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `autorizations`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `autorizations` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`autorizationCode` VARCHAR(255) NULL DEFAULT NULL,`creationDate` VARCHAR(255) NULL DEFAULT NULL,`dateofAutorization` VARCHAR(255) NULL DEFAULT NULL,`forwarder` BIGINT(20) NOT NULL,`signedPerson` BIGINT(20) NOT NULL,PRIMARY KEY (`id`),INDEX `FK_Autorizations_forwarder` (`forwarder` ASC),INDEX `FK_Autorizations_signedPerson` (`signedPerson` ASC),CONSTRAINT `FK_Autorizations_signedPerson`FOREIGN KEY (`signedPerson`)REFERENCES `staff` (`id`),CONSTRAINT `FK_Autorizations_forwarder`FOREIGN KEY (`forwarder`)REFERENCES `staff` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `idtypes`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `idtypes` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`idName` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `locations`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `locations` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`locationName` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `couriercompanies`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `couriercompanies` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`address` VARCHAR(255) NULL DEFAULT NULL,`companyName` VARCHAR(255) NULL DEFAULT NULL,`phones` VARCHAR(255) NULL DEFAULT NULL,`warehouseCode` VARCHAR(255) NULL DEFAULT NULL,`idType` BIGINT(20) NOT NULL,`location` BIGINT(20) NOT NULL,PRIMARY KEY (`id`),INDEX `FK_CourierCompanies_location` (`location` ASC),INDEX `FK_CourierCompanies_idType` (`idType` ASC),CONSTRAINT `FK_CourierCompanies_idType`FOREIGN KEY (`idType`)REFERENCES `idtypes` (`id`),CONSTRAINT `FK_CourierCompanies_location`FOREIGN KEY (`location`)REFERENCES `locations` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `deliveriestypes`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `deliveriestypes` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`deliveryType` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `deliveries`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `deliveries` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`cost` DOUBLE NULL DEFAULT NULL,`creationDate` VARCHAR(255) NULL DEFAULT NULL,`dateOfReceiving` VARCHAR(255) NULL DEFAULT NULL,`dateOfSending` VARCHAR(255) NULL DEFAULT NULL,`deliveryCode` VARCHAR(255) NULL DEFAULT NULL,`recieved` TINYINT(1) NULL DEFAULT '0',`sended` TINYINT(1) NULL DEFAULT '0',`size` VARCHAR(255) NULL DEFAULT NULL,`weight` DOUBLE NULL DEFAULT NULL,`autorization` BIGINT(20) NOT NULL,`courierCompany` BIGINT(20) NOT NULL,`typeOfDelivery` BIGINT(20) NOT NULL,PRIMARY KEY (`id`),INDEX `FK_Deliveries_autorization` (`autorization` ASC),INDEX `FK_Deliveries_courierCompany` (`courierCompany` ASC),INDEX `FK_Deliveries_typeOfDelivery` (`typeOfDelivery` ASC),CONSTRAINT `FK_Deliveries_typeOfDelivery`FOREIGN KEY (`typeOfDelivery`)REFERENCES `deliveriestypes` (`id`),CONSTRAINT `FK_Deliveries_autorization`FOREIGN KEY (`autorization`)REFERENCES `autorizations` (`id`),CONSTRAINT `FK_Deliveries_courierCompany`FOREIGN KEY (`courierCompany`)REFERENCES `couriercompanies` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `roles` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`roleName` VARCHAR(255) NULL DEFAULT NULL, PRIMARY KEY (`id`)) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`enabled` TINYINT(1) NULL DEFAULT '0',`password` VARCHAR(255) NULL DEFAULT NULL,`userName` VARCHAR(255) NULL DEFAULT NULL,`userNickname` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `users_roles`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `users_roles` (`role_id` BIGINT(20) NOT NULL,`user_id` BIGINT(20) NOT NULL,PRIMARY KEY (`role_id`, `user_id`),INDEX `FK_users_roles_user_id` (`user_id` ASC),CONSTRAINT `FK_users_roles_role_id`FOREIGN KEY (`role_id`)REFERENCES `roles` (`id`),CONSTRAINT `FK_users_roles_user_id`FOREIGN KEY (`user_id`)REFERENCES `users` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;
USE `rebok2j`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
