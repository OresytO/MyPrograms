SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Rebok2_DB1` ;
CREATE SCHEMA IF NOT EXISTS `Rebok2_DB1` DEFAULT CHARACTER SET cp1251 COLLATE cp1251_ukrainian_ci ;
USE `Rebok2_DB1` ;

-- -----------------------------------------------------
-- Table `payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment` ;

CREATE  TABLE IF NOT EXISTS `payment` (
  `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `payment` VARCHAR(45) NULL ,
  PRIMARY KEY (`payment_id`) ,
  UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `courier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `courier` ;

CREATE  TABLE IF NOT EXISTS `courier` (
  `name_storage_number` VARCHAR(30) NOT NULL ,
  `adress` VARCHAR(60) NOT NULL ,
  `phone_1` VARCHAR(15) NULL ,
  `phone_2` VARCHAR(15) NULL ,
  `phone_3` VARCHAR(15) NULL ,
  `passport_for_id` VARCHAR(60) NOT NULL ,
  `payment_id` INT NOT NULL ,
  PRIMARY KEY (`name_storage_number`) ,
  UNIQUE INDEX `name_storage_number_UNIQUE` (`name_storage_number` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `forwarder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `forwarder` ;

CREATE  TABLE IF NOT EXISTS `forwarder` (
  `forwarder_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NOT NULL ,
  `code_№_passport` VARCHAR(100) NOT NULL ,
  `code_№_driver_lice` VARCHAR(45) NOT NULL ,
  `job_title` VARCHAR(60) NOT NULL ,
  `sign` CHAR(3) NOT NULL ,
  PRIMARY KEY (`forwarder_id`) ,
  UNIQUE INDEX `forwarder_id_UNIQUE` (`forwarder_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `contragent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contragent` ;

CREATE  TABLE IF NOT EXISTS `contragent` (
  `contragent_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `adress` VARCHAR(45) NOT NULL ,
  `phone_1` VARCHAR(45) NULL ,
  `phone_2` VARCHAR(45) NULL ,
  PRIMARY KEY (`contragent_id`) ,
  UNIQUE INDEX `contragent_id_UNIQUE` (`contragent_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `status` ;

CREATE  TABLE IF NOT EXISTS `status` (
  `status_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `status` VARCHAR(45) NULL ,
  PRIMARY KEY (`status_id`) ,
  UNIQUE INDEX `статус_id_UNIQUE` (`status_id` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cities` ;

CREATE  TABLE IF NOT EXISTS `cities` (
  `cities_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `zip_code` VARCHAR(45) NULL ,
  PRIMARY KEY (`cities_id`) ,
  UNIQUE INDEX `cities_id_UNIQUE` (`cities_id` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `power_of_attorney`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `power_of_attorney` ;

CREATE  TABLE IF NOT EXISTS `power_of_attorney` (
  `power_of_attorney_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `power_of_attorney_date` DATE NOT NULL ,
  `№_power_of_attorney` VARCHAR(20) NOT NULL ,
  `sign_id` INT NOT NULL ,
  `forwarder_id` INT NOT NULL ,
  PRIMARY KEY (`power_of_attorney_id`) ,
  UNIQUE INDEX `power_of_attorney_id_UNIQUE` (`power_of_attorney_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `delivery` ;

CREATE  TABLE IF NOT EXISTS `delivery` (
  `delivery_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `send_date` DATE NULL ,
  `take_date` DATE NULL ,
  `delivery_cost` DECIMAL(20,2) NULL ,
  `places` INT NULL ,
  `declaration_number` VARCHAR(20) NULL ,
  `contact_person` VARCHAR(30) NULL ,
  `note` VARCHAR(90) NULL ,
  `weight` DECIMAL(15,2) NULL ,
  `size` VARCHAR(30) NULL ,
  `taker_id` INT NOT NULL ,
  `sender_id` INT NOT NULL ,
  `status_id` INT NOT NULL ,
  `destionation_place_id` INT NOT NULL ,
  `sender_place_id` INT NOT NULL ,
  `power_of_attorney_id` INT NULL ,
  `in_or_out` VARCHAR(45) NOT NULL ,
  `courier_id` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`delivery_id`) ,
  UNIQUE INDEX `delivery_id_UNIQUE` (`delivery_id` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

USE `Rebok2_DB1` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
