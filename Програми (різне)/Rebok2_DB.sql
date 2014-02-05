SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';



CREATE SCHEMA IF NOT EXISTS `Rebok2_DB` DEFAULT CHARACTER SET cp1251 COLLATE cp1251_ukrainian_ci ;

USE `Rebok2_DB` ;



-- -----------------------------------------------------

-- Table `Rebok2_DB`.`table1`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`table1` (

)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`in_delivery`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`in_delivery` (

  `in_delivery_id` INT NOT NULL AUTO_INCREMENT ,

  `статус` VARCHAR(20) NULL ,

  PRIMARY KEY (`in_delivery_id`) ,

  UNIQUE INDEX `in_delivery_id_UNIQUE` (`in_delivery_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`види_розрахунків`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`види_розрахунків` (

  `види_розрахунків_id` INT NOT NULL AUTO_INCREMENT ,

  `види_розрахунків` VARCHAR(45) NULL ,

  PRIMARY KEY (`види_розрахунків_id`) ,

  UNIQUE INDEX `види_розрахунків_id_UNIQUE` (`види_розрахунків_id` ASC) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`перевізники`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`перевізники` (

  `перевізники_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `назва_компанії` VARCHAR(45) NOT NULL ,

  `№_складу` VARCHAR(10) NULL ,

  `адреса` VARCHAR(60) NOT NULL ,

  `телефон_1` VARCHAR(15) NULL ,

  `телефон_2` VARCHAR(15) NULL ,

  `телефон_3` VARCHAR(15) NULL ,

  `посвідчення_особи` VARCHAR(45) NOT NULL ,

  `вид_розрахунку` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`перевізники_id`) ,

  INDEX `fk_перевізники_види_розрахунків1_idx` (`вид_розрахунку` ASC) ,

  CONSTRAINT `fk_перевізники_види_розрахунків1`

    FOREIGN KEY (`вид_розрахунку` )

    REFERENCES `Rebok2_DB`.`види_розрахунків` (`види_розрахунків_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`out_delivery`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`out_delivery` (

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

-- Table `Rebok2_DB`.`експедитор`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`експедитор` (

  `експедитор_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `прізвище` VARCHAR(30) NOT NULL ,

  `імя` VARCHAR(30) NOT NULL ,

  `по_батькові` VARCHAR(20) NOT NULL ,

  `серія_№_паспорта` VARCHAR(100) NOT NULL ,

  `серія_№_пос.водія` VARCHAR(45) NOT NULL ,

  `посада` VARCHAR(60) NOT NULL ,

  `право_підпису` CHAR(3) NOT NULL ,

  PRIMARY KEY (`експедитор_id`) ,

  UNIQUE INDEX `експедитор_id_UNIQUE` (`експедитор_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`контрагенти`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`контрагенти` (

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

-- Table `Rebok2_DB`.`статус`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`статус` (

  `статус_id` INT NOT NULL AUTO_INCREMENT ,

  `статус` VARCHAR(45) NULL ,

  PRIMARY KEY (`статус_id`) ,

  UNIQUE INDEX `статус_id_UNIQUE` (`статус_id` ASC) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`міста`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`міста` (

  `міста_id` INT NOT NULL AUTO_INCREMENT ,

  `назва` VARCHAR(45) NULL ,

  `поштовий_індекс` VARCHAR(45) NULL ,

  PRIMARY KEY (`міста_id`) ,

  UNIQUE INDEX `міста_id_UNIQUE` (`міста_id` ASC) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`доручення`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`доручення` (

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

    REFERENCES `Rebok2_DB`.`експедитор` (`експедитор_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_доручення_експедитор1`

    FOREIGN KEY (`експедитор_id` )

    REFERENCES `Rebok2_DB`.`експедитор` (`експедитор_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`відправка`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`відправка` (

  `відправка_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `дата_відправки` DATE NULL ,

  `дата_отримання` DATE NULL ,

  `вартість перевезення` DECIMAL(20,4) NULL ,

  `кількість місць` INT NULL ,

  `№_декларації` VARCHAR(20) NULL ,

  `контактна_особа` VARCHAR(50) NULL ,

  `примітка` VARCHAR(90) NULL ,

  `вага` DECIMAL(15,2) NULL ,

  `габарит` VARCHAR(20) NULL ,

  `одержувач_id` INT UNSIGNED NOT NULL ,

  `відправник_id` INT UNSIGNED NOT NULL ,

  `статус_id` INT NOT NULL ,

  `перевізники_id` INT UNSIGNED NOT NULL ,

  `місце_отримання_id` INT NOT NULL ,

  `місце_відправки_id` INT NOT NULL ,

  `доручення_id` INT UNSIGNED NOT NULL ,

  PRIMARY KEY (`відправка_id`) ,

  UNIQUE INDEX `cargo_id_UNIQUE` (`відправка_id` ASC) ,

  INDEX `fk_відправка_контрагенти1_idx` (`одержувач_id` ASC) ,

  INDEX `fk_відправка_контрагенти2_idx` (`відправник_id` ASC) ,

  INDEX `fk_відправка_статус1_idx` (`статус_id` ASC) ,

  INDEX `fk_відправка_перевізники1_idx` (`перевізники_id` ASC) ,

  INDEX `fk_відправка_міста1_idx` (`місце_отримання_id` ASC) ,

  INDEX `fk_відправка_міста2_idx` (`місце_відправки_id` ASC) ,

  INDEX `fk_відправка_доручення1_idx` (`доручення_id` ASC) ,

  CONSTRAINT `fk_відправка_контрагенти1`

    FOREIGN KEY (`одержувач_id` )

    REFERENCES `Rebok2_DB`.`контрагенти` (`контрагенти_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_відправка_контрагенти2`

    FOREIGN KEY (`відправник_id` )

    REFERENCES `Rebok2_DB`.`контрагенти` (`контрагенти_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_відправка_статус1`

    FOREIGN KEY (`статус_id` )

    REFERENCES `Rebok2_DB`.`статус` (`статус_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_відправка_перевізники1`

    FOREIGN KEY (`перевізники_id` )

    REFERENCES `Rebok2_DB`.`перевізники` (`перевізники_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_відправка_міста1`

    FOREIGN KEY (`місце_отримання_id` )

    REFERENCES `Rebok2_DB`.`міста` (`міста_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_відправка_міста2`

    FOREIGN KEY (`місце_відправки_id` )

    REFERENCES `Rebok2_DB`.`міста` (`міста_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_відправка_доручення1`

    FOREIGN KEY (`доручення_id` )

    REFERENCES `Rebok2_DB`.`доручення` (`доручення_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`table2`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`table2` (

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`вантаж`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`вантаж` (

  `вантаж_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `вага` DECIMAL(15,2) NULL ,

  `габарит` VARCHAR(45) NULL ,

  PRIMARY KEY (`вантаж_id`) ,

  UNIQUE INDEX `вантаж_id_UNIQUE` (`вантаж_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`перехідна_in_out`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`перехідна_in_out` (

  `перехідна_in_out_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `out_delivery_out_delivery_id` INT NOT NULL ,

  `in_delivery_in_delivery_id` INT NOT NULL ,

  PRIMARY KEY (`перехідна_in_out_id`, `out_delivery_out_delivery_id`, `in_delivery_in_delivery_id`) ,

  UNIQUE INDEX `перехідна_in_out_id_UNIQUE` (`перехідна_in_out_id` ASC) ,

  INDEX `fk_перехідна_in_out_out_delivery1_idx` (`out_delivery_out_delivery_id` ASC) ,

  INDEX `fk_перехідна_in_out_in_delivery1_idx` (`in_delivery_in_delivery_id` ASC) ,

  CONSTRAINT `fk_перехідна_in_out_out_delivery1`

    FOREIGN KEY (`out_delivery_out_delivery_id` )

    REFERENCES `Rebok2_DB`.`out_delivery` (`out_delivery_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_перехідна_in_out_in_delivery1`

    FOREIGN KEY (`in_delivery_in_delivery_id` )

    REFERENCES `Rebok2_DB`.`in_delivery` (`in_delivery_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`адреса`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`адреса` (

  `адреса_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `країна` VARCHAR(45) NULL ,

  `область (штат)` VARCHAR(45) NULL ,

  `місто (село)` VARCHAR(45) NULL ,

  `вулиця` VARCHAR(45) NULL ,

  `будинок` VARCHAR(45) NULL ,

  `квартира` VARCHAR(45) NULL ,

  `поштовий_індекс` VARCHAR(45) NULL ,

  PRIMARY KEY (`адреса_id`) ,

  UNIQUE INDEX `місця_in_out_id_UNIQUE` (`адреса_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`країна`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`країна` (

  `країна_id` INT NOT NULL AUTO_INCREMENT ,

  `країна` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`країна_id`) ,

  UNIQUE INDEX `країна_id_UNIQUE` (`країна_id` ASC) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`область`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`область` (

  `область_id` INT NOT NULL ,

  `область` VARCHAR(45) NOT NULL ,

  `країна_країна_id` INT NOT NULL ,

  PRIMARY KEY (`область_id`, `країна_країна_id`) ,

  INDEX `fk_область_країна1_idx` (`країна_країна_id` ASC) ,

  CONSTRAINT `fk_область_країна1`

    FOREIGN KEY (`країна_країна_id` )

    REFERENCES `Rebok2_DB`.`країна` (`країна_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`місто`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`місто` (

  `міста_id` INT NOT NULL AUTO_INCREMENT ,

  `назва` VARCHAR(45) NOT NULL ,

  `область_id` INT NOT NULL ,

  PRIMARY KEY (`міста_id`, `область_id`) ,

  UNIQUE INDEX `міста_id_UNIQUE` (`міста_id` ASC) ,

  INDEX `fk_місто_область1_idx` (`область_id` ASC) ,

  CONSTRAINT `fk_місто_область1`

    FOREIGN KEY (`область_id` )

    REFERENCES `Rebok2_DB`.`область` (`область_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`вулиця`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`вулиця` (

  `вулиця_id` INT NOT NULL AUTO_INCREMENT ,

  `вулиця` VARCHAR(45) NOT NULL ,

  `будинок` VARCHAR(45) NOT NULL ,

  `квартира` VARCHAR(45) NULL ,

  `поштовий_індекс` VARCHAR(45) NULL ,

  `міста_id` INT NOT NULL ,

  PRIMARY KEY (`вулиця_id`, `міста_id`) ,

  UNIQUE INDEX `вулиця_id_UNIQUE` (`вулиця_id` ASC) ,

  INDEX `fk_вулиця_місто1_idx` (`міста_id` ASC) ,

  CONSTRAINT `fk_вулиця_місто1`

    FOREIGN KEY (`міста_id` )

    REFERENCES `Rebok2_DB`.`місто` (`міста_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`адреса1`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`адреса1` (

  `адреса_id` INT NOT NULL AUTO_INCREMENT ,

  `вулиця_id` INT NOT NULL ,

  PRIMARY KEY (`адреса_id`, `вулиця_id`) ,

  UNIQUE INDEX `адреса_id_UNIQUE` (`адреса_id` ASC) ,

  INDEX `fk_адреса1_вулиця1_idx` (`вулиця_id` ASC) ,

  CONSTRAINT `fk_адреса1_вулиця1`

    FOREIGN KEY (`вулиця_id` )

    REFERENCES `Rebok2_DB`.`вулиця` (`вулиця_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;



USE `Rebok2_DB` ;





SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

