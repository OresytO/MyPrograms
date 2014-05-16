SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `rebok2J` ;
CREATE SCHEMA IF NOT EXISTS `rebok2J` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `rebok2J` ;

-- -----------------------------------------------------
-- Table `IdTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IdTypes` ;

CREATE  TABLE IF NOT EXISTS `IdTypes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `idName` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `Locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Locations` ;

CREATE  TABLE IF NOT EXISTS `Locations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `locationName` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `CourierCompanies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CourierCompanies` ;

CREATE  TABLE IF NOT EXISTS `CourierCompanies` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `IdTypes_id` INT UNSIGNED NOT NULL ,
  `locationID` INT NOT NULL ,
  `companyName` VARCHAR(45) NOT NULL ,
  `warehouseCode` VARCHAR(45) NOT NULL ,
  `address` VARCHAR(45) NOT NULL ,
  `phones` VARCHAR(45) NULL ,
  `creationDate` DATETIME NOT NULL ,
  PRIMARY KEY (`id`, `IdTypes_id`, `locationID`) ,
  INDEX `fk_CourierCompany_IdTypes1_idx` (`IdTypes_id` ASC) ,
  INDEX `fk_CourierCompanies_Locations1_idx` (`locationID` ASC) ,
  CONSTRAINT `fk_CourierCompany_IdTypes1`
    FOREIGN KEY (`IdTypes_id` )
    REFERENCES `IdTypes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CourierCompanies_Locations1`
    FOREIGN KEY (`locationID` )
    REFERENCES `Locations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `DeliveriesTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DeliveriesTypes` ;

CREATE  TABLE IF NOT EXISTS `DeliveriesTypes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `deliveryType` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `Deliveries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Deliveries` ;

CREATE  TABLE IF NOT EXISTS `Deliveries` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `CourierCompany_id` INT UNSIGNED NOT NULL ,
  `deliveryCode` VARCHAR(45) NULL ,
  `weight` DECIMAL(10,4) NULL ,
  `size` VARCHAR(45) NULL ,
  `cost` DECIMAL(10,4) NULL ,
  `dateOfSending` DATE NULL ,
  `dateOfReceiving` DATE NULL ,
  `sended` TINYINT(1) NULL ,
  `received` TINYINT(1) NULL ,
  `typeOfDelivery` INT NOT NULL ,
  `creationDate` DATETIME NOT NULL ,
  PRIMARY KEY (`id`, `CourierCompany_id`, `typeOfDelivery`) ,
  INDEX `fk_Deliveries_CourierCompany_idx` (`CourierCompany_id` ASC) ,
  INDEX `fk_Deliveries_DeliveriesTypes1_idx` (`typeOfDelivery` ASC) ,
  CONSTRAINT `fk_Deliveries_CourierCompany`
    FOREIGN KEY (`CourierCompany_id` )
    REFERENCES `CourierCompanies` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Deliveries_DeliveriesTypes1`
    FOREIGN KEY (`typeOfDelivery` )
    REFERENCES `DeliveriesTypes` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Staff` ;

CREATE  TABLE IF NOT EXISTS `Staff` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `firstName` VARCHAR(45) NOT NULL ,
  `lastName` VARCHAR(45) NOT NULL ,
  `passport` VARCHAR(45) NOT NULL ,
  `drivingLicense` VARCHAR(45) NULL ,
  `powerToSign` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `Authorizations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Authorizations` ;

CREATE  TABLE IF NOT EXISTS `Authorizations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `deliveryID` INT UNSIGNED NOT NULL ,
  `signedPerson` INT UNSIGNED NOT NULL ,
  `forwarder` INT UNSIGNED NOT NULL ,
  `authorizationCode` VARCHAR(45) NOT NULL ,
  `dateOfAutorization` DATE NOT NULL ,
  `creationDate` DATETIME NOT NULL ,
  PRIMARY KEY (`id`, `deliveryID`, `signedPerson`, `forwarder`) ,
  INDEX `fk_Authorization_Deliveries1_idx` (`deliveryID` ASC) ,
  INDEX `fk_Authorization_Staff1_idx` (`signedPerson` ASC) ,
  INDEX `fk_Authorization_Staff2_idx` (`forwarder` ASC) ,
  CONSTRAINT `fk_Authorization_Deliveries1`
    FOREIGN KEY (`deliveryID` )
    REFERENCES `Deliveries` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Authorization_Staff1`
    FOREIGN KEY (`signedPerson` )
    REFERENCES `Staff` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Authorization_Staff2`
    FOREIGN KEY (`forwarder` )
    REFERENCES `Staff` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users` ;

CREATE  TABLE IF NOT EXISTS `Users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Roles` ;

CREATE  TABLE IF NOT EXISTS `Roles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `Users_has_Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users_has_Roles` ;

CREATE  TABLE IF NOT EXISTS `Users_has_Roles` (
  `Users_id` INT UNSIGNED NOT NULL ,
  `Roles_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`Users_id`, `Roles_id`) ,
  INDEX `fk_Users_has_Roles_Roles1_idx` (`Roles_id` ASC) ,
  INDEX `fk_Users_has_Roles_Users1_idx` (`Users_id` ASC) ,
  CONSTRAINT `fk_Users_has_Roles_Users1`
    FOREIGN KEY (`Users_id` )
    REFERENCES `Users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Roles_Roles1`
    FOREIGN KEY (`Roles_id` )
    REFERENCES `Roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;

USE `rebok2J` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
