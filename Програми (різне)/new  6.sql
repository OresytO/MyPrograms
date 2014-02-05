SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE  DATABASE `Rebok2_DB1`;

-- -----------------------------------------------------
-- Table `Rebok2_DB1`.`payment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT ,
  `payment` VARCHAR(45) NULL ,
  PRIMARY KEY (`payment_id`) ,
  UNIQUE INDEX `види_розрахунків_id_UNIQUE` (`payment_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rebok2_DB1`.`courier`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`courier` (
  `courier_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `№_storage` VARCHAR(10) NULL ,
  `adress` VARCHAR(60) NOT NULL ,
  `phone_1` VARCHAR(15) NULL ,
  `phone_2` VARCHAR(15) NULL ,
  `phone_3` VARCHAR(15) NULL ,
  `person_id` VARCHAR(45) NOT NULL ,
  `payment_id` INT NOT NULL ,
  PRIMARY KEY (`courier_id`) ,
  INDEX `fk_перевізники_види_розрахунків1_idx` (`payment_id` ASC) ,
  CONSTRAINT `fk_перевізники_види_розрахунків1`
    FOREIGN KEY (`payment_id` )
    REFERENCES `Rebok2_DB1`.`payment` (`payment_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `Rebok2_DB1`.`експедитори`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`експедитори` (
  `експедитори_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `прізвище` VARCHAR(30) NOT NULL ,
  `імя` VARCHAR(30) NOT NULL ,
  `по_батькові` VARCHAR(20) NOT NULL ,
  `серія_№_паспорта` VARCHAR(100) NOT NULL ,
  `серія_№_пос.водія` VARCHAR(45) NOT NULL ,
  `посада` VARCHAR(60) NOT NULL ,
  `право_підпису` CHAR(3) NOT NULL ,
  PRIMARY KEY (`експедитори_id`) ,
  UNIQUE INDEX `експедитор_id_UNIQUE` (`експедитори_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `Rebok2_DB1`.`контрагенти`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`контрагенти` (
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
-- Table `Rebok2_DB1`.`статуси`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`статуси` (
  `статуси_id` INT NOT NULL AUTO_INCREMENT ,
  `статус` VARCHAR(45) NULL ,
  PRIMARY KEY (`статуси_id`) ,
  UNIQUE INDEX `статус_id_UNIQUE` (`статуси_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rebok2_DB1`.`міста`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`міста` (
  `міста_id` INT NOT NULL AUTO_INCREMENT ,
  `назва` VARCHAR(45) NULL ,
  `поштовий_індекс` VARCHAR(45) NULL ,
  PRIMARY KEY (`міста_id`) ,
  UNIQUE INDEX `міста_id_UNIQUE` (`міста_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rebok2_DB1`.`доручення`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`доручення` (
  `доручення_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `дата_доручення` DATE NULL ,
  `№_доручення` VARCHAR(20) NULL ,
  `підпис_id` INT UNSIGNED NOT NULL ,
  `експедитор_id` INT UNSIGNED NOT NULL ,
  PRIMARY KEY (`доручення_id`) ,
  UNIQUE INDEX `доручення_id_UNIQUE` (`доручення_id` ASC) ,
  INDEX `fk_доручення_експедитор_idx` (`підпис_id` ASC) ,
  INDEX `fk_доручення_експедитор1_idx` (`експедитор_id` ASC) ,
  CONSTRAINT `fk_доручення_експедитор`
    FOREIGN KEY (`підпис_id` )
    REFERENCES `Rebok2_DB1`.`експедитори` (`експедитори_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_доручення_експедитор1`
    FOREIGN KEY (`експедитор_id` )
    REFERENCES `Rebok2_DB1`.`експедитори` (`експедитори_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;


-- -----------------------------------------------------
-- Table `Rebok2_DB1`.`відправки`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Rebok2_DB1`.`відправки` (
  `відправки_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `дата_відправки` DATE NULL ,
  `дата_отримання` DATE NULL ,
  `вартість_перевезення` DECIMAL(20,4) NULL ,
  `кількість_місць` INT NULL ,
  `№_декларації` VARCHAR(20) NULL ,
  `контактна_особа` VARCHAR(50) NULL ,
  `примітка` VARCHAR(90) NULL ,
  `вага` DECIMAL(15,2) NULL ,
  `габарит` VARCHAR(20) NULL ,
  `одержувач_id` INT UNSIGNED NOT NULL ,
  `відправник_id` INT UNSIGNED NOT NULL ,
  `статуси_id` INT NOT NULL ,
  `перевізники_id` INT UNSIGNED NOT NULL ,
  `місце_отримання_id` INT NOT NULL ,
  `місце_відправки_id` INT NOT NULL ,
  `доручення_id` INT UNSIGNED NULL ,
  `вхідна_вихідна` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`відправки_id`) ,
  UNIQUE INDEX `cargo_id_UNIQUE` (`відправки_id` ASC) ,
  INDEX `fk_відправка_контрагенти1_idx` (`одержувач_id` ASC) ,
  INDEX `fk_відправка_контрагенти2_idx` (`відправник_id` ASC) ,
  INDEX `fk_відправка_статус1_idx` (`статуси_id` ASC) ,
  INDEX `fk_відправка_перевізники1_idx` (`перевізники_id` ASC) ,
  INDEX `fk_відправка_міста1_idx` (`місце_отримання_id` ASC) ,
  INDEX `fk_відправка_міста2_idx` (`місце_відправки_id` ASC) ,
  INDEX `fk_відправка_доручення1_idx` (`доручення_id` ASC) ,
  CONSTRAINT `fk_відправка_контрагенти1`
    FOREIGN KEY (`одержувач_id` )
    REFERENCES `Rebok2_DB1`.`контрагенти` (`контрагенти_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_контрагенти2`
    FOREIGN KEY (`відправник_id` )
    REFERENCES `Rebok2_DB1`.`контрагенти` (`контрагенти_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_статус1`
    FOREIGN KEY (`статуси_id` )
    REFERENCES `Rebok2_DB1`.`статуси` (`статуси_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_перевізники1`
    FOREIGN KEY (`перевізники_id` )
    REFERENCES `Rebok2_DB1`.`courier` (`courier_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_міста1`
    FOREIGN KEY (`місце_отримання_id` )
    REFERENCES `Rebok2_DB1`.`міста` (`міста_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_міста2`
    FOREIGN KEY (`місце_відправки_id` )
    REFERENCES `Rebok2_DB1`.`міста` (`міста_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_відправка_доручення1`
    FOREIGN KEY (`доручення_id` )
    REFERENCES `Rebok2_DB1`.`доручення` (`доручення_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
