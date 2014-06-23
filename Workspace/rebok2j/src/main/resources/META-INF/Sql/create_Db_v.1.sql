SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `rebok2j` DEFAULT CHARACTER SET utf8;
USE `rebok2j`;

-- -----------------------------------------------------
-- Table `staff`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Staff` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`drivingLicense` VARCHAR(255) NULL DEFAULT NULL,`firstName` VARCHAR(255) NULL DEFAULT NULL,`lastName` VARCHAR(255) NULL DEFAULT NULL,`passport` VARCHAR(255) NULL DEFAULT NULL,`powerToSign` TINYINT(1) NULL DEFAULT '0',PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `authorizations`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Authorizations` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`AuthorizationCode` VARCHAR(255) NULL DEFAULT NULL,`creationDate` VARCHAR(255) NULL DEFAULT NULL,`dateOfAuthorization` VARCHAR(255) NULL DEFAULT NULL,`forwarderId` BIGINT(20) NOT NULL,`signedPersonId` BIGINT(20) NOT NULL,PRIMARY KEY (`id`),INDEX `FK_Authorizations_forwarderId` (`forwarderId` ASC),INDEX `FK_Authorizations_signedPersonId` (`signedPersonId` ASC),CONSTRAINT `FK_Authorizations_signedPersonId`FOREIGN KEY (`signedPersonId`)REFERENCES `staff` (`id`),CONSTRAINT `FK_Authorizations_forwarderId`FOREIGN KEY (`forwarderId`)REFERENCES `staff` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `idTypes`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `idTypes` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`idName` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `locations`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Locations` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`locationName` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `courierCompanies`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `CourierCompanies` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`address` VARCHAR(255) NULL DEFAULT NULL,`companyName` VARCHAR(255) NULL DEFAULT NULL,`phones` VARCHAR(255) NULL DEFAULT NULL,`warehouseCode` VARCHAR(255) NULL DEFAULT NULL,`idTypeId` BIGINT(20) NOT NULL,`location` BIGINT(20) NOT NULL,PRIMARY KEY (`id`),INDEX `FK_CourierCompanies_location` (`location` ASC),INDEX `FK_CourierCompanies_idTypeId` (`idTypeId` ASC),CONSTRAINT `FK_CourierCompanies_idTypeId`FOREIGN KEY (`idTypeId`)REFERENCES `idTypes` (`id`),CONSTRAINT `FK_CourierCompanies_location`FOREIGN KEY (`location`)REFERENCES `locations` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `deliveriesTypes`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `DeliveriesTypes` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`deliveryType` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `deliveries`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Deliveries` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`cost` DOUBLE NULL DEFAULT NULL,`creationDate` VARCHAR(255) NULL DEFAULT NULL,`dateOfReceiving` VARCHAR(255) NULL DEFAULT NULL,`dateOfSending` VARCHAR(255) NULL DEFAULT NULL,`deliveryCode` VARCHAR(255) NULL DEFAULT NULL,`recieved` TINYINT(1) NULL DEFAULT '0',`sended` TINYINT(1) NULL DEFAULT '0',`size` VARCHAR(255) NULL DEFAULT NULL,`weight` DOUBLE NULL DEFAULT NULL,`authorizationId` BIGINT(20) NOT NULL,`courierCompanyId` BIGINT(20) NOT NULL,`typeOfDeliveryId` BIGINT(20) NOT NULL,PRIMARY KEY (`id`),INDEX `FK_Deliveries_authorization` (`authorizationId` ASC),INDEX `FK_Deliveries_courierCompany` (`courierCompanyId` ASC),INDEX `FK_Deliveries_typeOfDelivery` (`typeOfDeliveryId` ASC),CONSTRAINT `FK_Deliveries_typeOfDelivery`FOREIGN KEY (`typeOfDeliveryId`)REFERENCES `deliveriestypes` (`id`),CONSTRAINT `FK_Deliveries_authorization`FOREIGN KEY (`authorizationId`)REFERENCES `Authorizations` (`id`),CONSTRAINT `FK_Deliveries_courierCompany`FOREIGN KEY (`courierCompanyId`)REFERENCES `couriercompanies` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Roles` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`roleName` VARCHAR(255) NULL DEFAULT NULL, PRIMARY KEY (`id`)) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `Users` (`id` BIGINT(20) NOT NULL AUTO_INCREMENT,`enabled` TINYINT(1) NULL DEFAULT '0',`password` VARCHAR(255) NULL DEFAULT NULL,`userName` VARCHAR(255) NULL DEFAULT NULL,`userNickname` VARCHAR(255) NULL DEFAULT NULL,PRIMARY KEY (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `users_roles`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `UsersRoles` (`role_id` BIGINT(20) NOT NULL,`user_id` BIGINT(20) NOT NULL,PRIMARY KEY (`role_id`, `user_id`),INDEX `FK_users_roles_user_id` (`user_id` ASC),CONSTRAINT `FK_users_roles_role_id`FOREIGN KEY (`role_id`)REFERENCES `roles` (`id`),CONSTRAINT `FK_users_roles_user_id`FOREIGN KEY (`user_id`)REFERENCES `users` (`id`))ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;
USE `rebok2j`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
