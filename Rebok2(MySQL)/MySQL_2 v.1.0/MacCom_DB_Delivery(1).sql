SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET  cp1251 COLLATE cp1251_ukrainian_ci;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`in_delivery`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`in_delivery` (
  `in_delivery_id` INT NOT NULL AUTO_INCREMENT ,
  `перевізник` VARCHAR(45) NOT NULL ,
  `експедитор` VARCHAR(45) NULL ,
  `статус` VARCHAR(20) NULL ,
  PRIMARY KEY (`in_delivery_id`) ,
  UNIQUE INDEX `in_delivery_id_UNIQUE` (`in_delivery_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`перевізники`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`перевізники` (
  `перевізники_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `назва_компанії` VARCHAR(45) NOT NULL ,
  `№_складу` VARCHAR(10) NULL ,
  `адреса` VARCHAR(60) NOT NULL ,
  `телефон_1` VARCHAR(15) NULL ,
  `телефон_2` VARCHAR(15) NULL ,
  `телефон_3` VARCHAR(15) NULL ,
  `посвідчення_особи` VARCHAR(45) NOT NULL ,
  `вид_розрахунку` VARCHAR(45) NULL ,
  PRIMARY KEY (`перевізники_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`out_delivery`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`out_delivery` (
  `out_delivery_id` INT NOT NULL AUTO_INCREMENT ,
  `перевізник` VARCHAR(45) NOT NULL ,
  `експедитор` VARCHAR(45) NULL ,
  `статус` VARCHAR(20) NULL ,
  PRIMARY KEY (`out_delivery_id`) ,
  UNIQUE INDEX `in_delivery_id_UNIQUE` (`out_delivery_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`експедитор`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`експедитор` (
  `експедитор_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `прізвище` VARCHAR(30) NOT NULL ,
  `імя` VARCHAR(30) NOT NULL ,
  `по_батькові` VARCHAR(20) NOT NULL ,
  `серія_№_паспорта` VARCHAR(100) NOT NULL ,
  `серія_№_пос.водія` VARCHAR(45) NOT NULL ,
  `посада` VARCHAR(60) NOT NULL ,
  `право_підпису` CHAR(3) NOT NULL ,
  `out_delivery_out_delivery_id` INT NOT NULL ,
  PRIMARY KEY (`експедитор_id`, `out_delivery_out_delivery_id`) ,
  UNIQUE INDEX `експедитор_id_UNIQUE` (`експедитор_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`доручення`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`доручення` (
  `доручення_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `дата_доручення` DATE NULL ,
  `№_доручення` VARCHAR(20) NULL ,
  `підпис_id` INT UNSIGNED NOT NULL ,
  `експедитор_id` INT UNSIGNED NOT NULL ,
  `перевізники` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`доручення_id`, `підпис_id`, `експедитор_id`, `перевізники`) ,
  UNIQUE INDEX `доручення_id_UNIQUE` (`доручення_id` ASC) ,
  INDEX `fk_доручення_експедитор_idx` (`підпис_id` ASC) ,
  INDEX `fk_доручення_експедитор1_idx` (`експедитор_id` ASC) ,
  INDEX `fk_доручення_перевізники1_idx` (`перевізники` ASC) ,
  CONSTRAINT `fk_доручення_експедитор`
    FOREIGN KEY (`підпис_id` )
    REFERENCES `mydb`.`експедитор` (`експедитор_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_доручення_експедитор1`
    FOREIGN KEY (`експедитор_id` )
    REFERENCES `mydb`.`експедитор` (`експедитор_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_доручення_перевізники1`
    FOREIGN KEY (`перевізники` )
    REFERENCES `mydb`.`перевізники` (`перевізники_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`перехідна_in_out`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`перехідна_in_out` (
  `перехідна_in_out_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `out_delivery_out_delivery_id` INT NOT NULL ,
  `in_delivery_in_delivery_id` INT NOT NULL ,
  PRIMARY KEY (`перехідна_in_out_id`, `out_delivery_out_delivery_id`, `in_delivery_in_delivery_id`) ,
  UNIQUE INDEX `перехідна_in_out_id_UNIQUE` (`перехідна_in_out_id` ASC) ,
  INDEX `fk_перехідна_in_out_out_delivery1_idx` (`out_delivery_out_delivery_id` ASC) ,
  INDEX `fk_перехідна_in_out_in_delivery1_idx` (`in_delivery_in_delivery_id` ASC) ,
  CONSTRAINT `fk_перехідна_in_out_out_delivery1`
    FOREIGN KEY (`out_delivery_out_delivery_id` )
    REFERENCES `mydb`.`out_delivery` (`out_delivery_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_перехідна_in_out_in_delivery1`
    FOREIGN KEY (`in_delivery_in_delivery_id` )
    REFERENCES `mydb`.`in_delivery` (`in_delivery_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`місця_in_out`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`місця_in_out` (
  `місця_in_out_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `місця_in_out` VARCHAR(90) NOT NULL ,
  PRIMARY KEY (`місця_in_out_id`) ,
  UNIQUE INDEX `місця_in_out_id_UNIQUE` (`місця_in_out_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`контрагенти`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`контрагенти` (
  `контрагенти_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `назва` VARCHAR(45) NOT NULL ,
  `адреса` VARCHAR(45) NOT NULL ,
  `телефон_1` VARCHAR(45) NULL ,
  `телефон_2` VARCHAR(45) NULL ,
  PRIMARY KEY (`контрагенти_id`) ,
  UNIQUE INDEX `контрагенти_id_UNIQUE` (`контрагенти_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`відправка`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`відправка` (
  `відправка_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `дата_відправки` DATE NULL ,
  `дата_отримання` DATE NULL ,
  `вартість перевезення` DECIMAL(15,2) NULL ,
  `кількість місць` INT NULL ,
  `№_декларації` VARCHAR(20) NULL ,
  `контактна_особа` VARCHAR(50) NULL ,
  `примітка` VARCHAR(90) NULL ,
  `доручення_доручення_id` INT UNSIGNED NOT NULL ,
  `доручення_підпис_id` INT UNSIGNED NOT NULL ,
  `доручення_експедитор_id` INT UNSIGNED NOT NULL ,
  `доручення_перевізники` INT UNSIGNED NOT NULL ,
  `out_delivery_out_delivery_id` INT NOT NULL ,
  `перехідна_in_out_перехідна_in_out_id` INT UNSIGNED NOT NULL ,
  `перехідна_in_out_out_delivery_out_delivery_id` INT NOT NULL ,
  `перехідна_in_out_in_delivery_in_delivery_id` INT NOT NULL ,
  `вага` DECIMAL(15,2) NULL ,
  `габарит` VARCHAR(20) NULL ,
  `місце_відправки` INT UNSIGNED NOT NULL ,
  `місце_отримання` INT UNSIGNED NOT NULL ,
  `контрагенти_контрагенти_id` INT UNSIGNED NOT NULL ,
  `контрагенти_контрагенти_id1` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`відправка_id`, `доручення_доручення_id`, `доручення_підпис_id`, `доручення_експедитор_id`, `доручення_перевізники`, `out_delivery_out_delivery_id`, `перехідна_in_out_перехідна_in_out_id`, `перехідна_in_out_out_delivery_out_delivery_id`, `перехідна_in_out_in_delivery_in_delivery_id`, `місце_відправки`, `місце_отримання`, `контрагенти_контрагенти_id`, `контрагенти_контрагенти_id1`) ,
  UNIQUE INDEX `cargo_id_UNIQUE` (`відправка_id` ASC) ,
  INDEX `fk_відправка_доручення1_idx` (`доручення_доручення_id` ASC, `доручення_підпис_id` ASC, `доручення_експедитор_id` ASC, `доручення_перевізники` ASC) ,
  INDEX `fk_відправка_перехідна_in_out1_idx` (`перехідна_in_out_перехідна_in_out_id` ASC, `перехідна_in_out_out_delivery_out_delivery_id` ASC, `перехідна_in_out_in_delivery_in_delivery_id` ASC) ,
  INDEX `fk_відправка_місця_in_out1_idx` (`місце_відправки` ASC) ,
  INDEX `fk_відправка_місця_in_out2_idx` (`місце_отримання` ASC) ,
  INDEX `fk_відправка_контрагенти1_idx` (`контрагенти_контрагенти_id` ASC) ,
  INDEX `fk_відправка_контрагенти2_idx` (`контрагенти_контрагенти_id1` ASC) ,
  CONSTRAINT `fk_відправка_доручення1`
    FOREIGN KEY (`доручення_доручення_id` , `доручення_підпис_id` , `доручення_експедитор_id` , `доручення_перевізники` )
    REFERENCES `mydb`.`доручення` (`доручення_id` , `підпис_id` , `експедитор_id` , `перевізники` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_перехідна_in_out1`
    FOREIGN KEY (`перехідна_in_out_перехідна_in_out_id` , `перехідна_in_out_out_delivery_out_delivery_id` , `перехідна_in_out_in_delivery_in_delivery_id` )
    REFERENCES `mydb`.`перехідна_in_out` (`перехідна_in_out_id` , `out_delivery_out_delivery_id` , `in_delivery_in_delivery_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_місця_in_out1`
    FOREIGN KEY (`місце_відправки` )
    REFERENCES `mydb`.`місця_in_out` (`місця_in_out_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_місця_in_out2`
    FOREIGN KEY (`місце_отримання` )
    REFERENCES `mydb`.`місця_in_out` (`місця_in_out_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_контрагенти1`
    FOREIGN KEY (`контрагенти_контрагенти_id` )
    REFERENCES `mydb`.`контрагенти` (`контрагенти_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_контрагенти2`
    FOREIGN KEY (`контрагенти_контрагенти_id1` )
    REFERENCES `mydb`.`контрагенти` (`контрагенти_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `mydb`.`вантаж`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`вантаж` (
  `вантаж_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `вага` DECIMAL(15,2) NULL ,
  `габарит` VARCHAR(45) NULL ,
  PRIMARY KEY (`вантаж_id`) ,
  UNIQUE INDEX `вантаж_id_UNIQUE` (`вантаж_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
