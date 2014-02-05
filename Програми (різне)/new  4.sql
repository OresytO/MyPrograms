SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Rebok2_DB` DEFAULT CHARACTER SET cp1251 COLLATE cp1251_ukrainian_ci ;
USE `Rebok2_DB` ;

-- -----------------------------------------------------
-- Table `Rebok2_DB`.`����_����������`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`����_����������` (
  `����_����������_id` INT NOT NULL AUTO_INCREMENT ,
  `����_����������` VARCHAR(45) NULL ,
  PRIMARY KEY (`����_����������_id`) ,
  UNIQUE INDEX `����_����������_id_UNIQUE` (`����_����������_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rebok2_DB`.`����������`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`����������` (
  `����������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `�����_��������` VARCHAR(45) NOT NULL ,
  `�_������` VARCHAR(10) NULL ,
  `������` VARCHAR(60) NOT NULL ,
  `�������_1` VARCHAR(15) NULL ,
  `�������_2` VARCHAR(15) NULL ,
  `�������_3` VARCHAR(15) NULL ,
  `����������_�����` VARCHAR(45) NOT NULL ,
  `����_����������_id` INT NOT NULL ,
  PRIMARY KEY (`����������_id`) ,
  INDEX `fk_����������_����_����������1_idx` (`����_����������_id` ASC) ,
  CONSTRAINT `fk_����������_����_����������1`
    FOREIGN KEY (`����_����������_id` )
    REFERENCES `Rebok2_DB`.`����_����������` (`����_����������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `Rebok2_DB`.`�����������`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`�����������` (
  `�����������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `�������` VARCHAR(30) NOT NULL ,
  `���` VARCHAR(30) NOT NULL ,
  `��_�������` VARCHAR(20) NOT NULL ,
  `����_�_��������` VARCHAR(100) NOT NULL ,
  `����_�_���.����` VARCHAR(45) NOT NULL ,
  `������` VARCHAR(60) NOT NULL ,
  `�����_������` CHAR(3) NOT NULL ,
  PRIMARY KEY (`�����������_id`) ,
  UNIQUE INDEX `����������_id_UNIQUE` (`�����������_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `Rebok2_DB`.`�����������`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`�����������` (
  `�����������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `�����` VARCHAR(45) NOT NULL ,
  `������` VARCHAR(45) NOT NULL ,
  `�������_1` VARCHAR(45) NULL ,
  `�������_2` VARCHAR(45) NULL ,
  PRIMARY KEY (`�����������_id`) ,
  UNIQUE INDEX `�����������_id_UNIQUE` (`�����������_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `Rebok2_DB`.`�������`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`�������` (
  `�������_id` INT NOT NULL AUTO_INCREMENT ,
  `������` VARCHAR(45) NULL ,
  PRIMARY KEY (`�������_id`) ,
  UNIQUE INDEX `������_id_UNIQUE` (`�������_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rebok2_DB`.`����`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`����` (
  `����_id` INT NOT NULL AUTO_INCREMENT ,
  `�����` VARCHAR(45) NULL ,
  `��������_������` VARCHAR(45) NULL ,
  PRIMARY KEY (`����_id`) ,
  UNIQUE INDEX `����_id_UNIQUE` (`����_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rebok2_DB`.`���������`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`���������` (
  `���������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `����_���������` DATE NULL ,
  `�_���������` VARCHAR(20) NULL ,
  `�����_id` INT UNSIGNED NOT NULL ,
  `����������_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`���������_id`) ,
  UNIQUE INDEX `���������_id_UNIQUE` (`���������_id` ASC) ,
  INDEX `fk_���������_����������_idx` (`�����_id` ASC) ,
  INDEX `fk_���������_����������1_idx` (`����������_id` ASC) ,
  CONSTRAINT `fk_���������_����������`
    FOREIGN KEY (`�����_id` )
    REFERENCES `Rebok2_DB`.`�����������` (`�����������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_���������_����������1`
    FOREIGN KEY (`����������_id` )
    REFERENCES `Rebok2_DB`.`�����������` (`�����������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `Rebok2_DB`.`��������`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`��������` (
  `��������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `����_��������` DATE NULL ,
  `����_���������` DATE NULL ,
  `�������_�����������` DECIMAL(20,4) NULL ,
  `�������_����` INT NULL ,
  `�_����������` VARCHAR(20) NULL ,
  `���������_�����` VARCHAR(50) NULL ,
  `�������` VARCHAR(90) NULL ,
  `����` DECIMAL(15,2) NULL ,
  `�������` VARCHAR(20) NULL ,
  `���������_id` INT UNSIGNED NOT NULL ,
  `���������_id` INT UNSIGNED NOT NULL ,
  `�������_id` INT NOT NULL ,
  `����������_id` INT UNSIGNED NOT NULL ,
  `����_���������_id` INT NOT NULL ,
  `����_��������_id` INT NOT NULL ,
  `���������_id` INT UNSIGNED NULL ,
  `����_�����` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`��������_id`) ,
  UNIQUE INDEX `cargo_id_UNIQUE` (`��������_id` ASC) ,
  INDEX `fk_��������_�����������1_idx` (`���������_id` ASC) ,
  INDEX `fk_��������_�����������2_idx` (`���������_id` ASC) ,
  INDEX `fk_��������_������1_idx` (`�������_id` ASC) ,
  INDEX `fk_��������_����������1_idx` (`����������_id` ASC) ,
  INDEX `fk_��������_����1_idx` (`����_���������_id` ASC) ,
  INDEX `fk_��������_����2_idx` (`����_��������_id` ASC) ,
  INDEX `fk_��������_���������1_idx` (`���������_id` ASC) ,
  CONSTRAINT `fk_��������_�����������1`
    FOREIGN KEY (`���������_id` )
    REFERENCES `Rebok2_DB`.`�����������` (`�����������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_��������_�����������2`
    FOREIGN KEY (`���������_id` )
    REFERENCES `Rebok2_DB`.`�����������` (`�����������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_��������_������1`
    FOREIGN KEY (`�������_id` )
    REFERENCES `Rebok2_DB`.`�������` (`�������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_��������_����������1`
    FOREIGN KEY (`����������_id` )
    REFERENCES `Rebok2_DB`.`����������` (`����������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_��������_����1`
    FOREIGN KEY (`����_���������_id` )
    REFERENCES `Rebok2_DB`.`����` (`����_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_��������_����2`
    FOREIGN KEY (`����_��������_id` )
    REFERENCES `Rebok2_DB`.`����` (`����_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_��������_���������1`
    FOREIGN KEY (`���������_id` )
    REFERENCES `Rebok2_DB`.`���������` (`���������_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

USE `Rebok2_DB` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
