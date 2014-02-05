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

  `������` VARCHAR(20) NULL ,

  PRIMARY KEY (`in_delivery_id`) ,

  UNIQUE INDEX `in_delivery_id_UNIQUE` (`in_delivery_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





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

  `�����_������` VARCHAR(45) NOT NULL ,

  `�_������` VARCHAR(10) NULL ,

  `������` VARCHAR(60) NOT NULL ,

  `�������_1` VARCHAR(15) NULL ,

  `�������_2` VARCHAR(15) NULL ,

  `�������_3` VARCHAR(15) NULL ,

  `����������_�����` VARCHAR(45) NOT NULL ,

  `���_����������` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`����������_id`) ,

  INDEX `fk_����������_����_����������1_idx` (`���_����������` ASC) ,

  CONSTRAINT `fk_����������_����_����������1`

    FOREIGN KEY (`���_����������` )

    REFERENCES `Rebok2_DB`.`����_����������` (`����_����������_id` )

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

  `���������` VARCHAR(45) NOT NULL ,

  `����������` VARCHAR(45) NULL ,

  `������` VARCHAR(20) NULL ,

  PRIMARY KEY (`out_delivery_id`) ,

  UNIQUE INDEX `in_delivery_id_UNIQUE` (`out_delivery_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`����������`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`����������` (

  `����������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `�������` VARCHAR(30) NOT NULL ,

  `���` VARCHAR(30) NOT NULL ,

  `��_�������` VARCHAR(20) NOT NULL ,

  `����_�_��������` VARCHAR(100) NOT NULL ,

  `����_�_���.����` VARCHAR(45) NOT NULL ,

  `������` VARCHAR(60) NOT NULL ,

  `�����_������` CHAR(3) NOT NULL ,

  PRIMARY KEY (`����������_id`) ,

  UNIQUE INDEX `����������_id_UNIQUE` (`����������_id` ASC) )

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

-- Table `Rebok2_DB`.`������`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`������` (

  `������_id` INT NOT NULL AUTO_INCREMENT ,

  `������` VARCHAR(45) NULL ,

  PRIMARY KEY (`������_id`) ,

  UNIQUE INDEX `������_id_UNIQUE` (`������_id` ASC) )

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

    REFERENCES `Rebok2_DB`.`����������` (`����������_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_���������_����������1`

    FOREIGN KEY (`����������_id` )

    REFERENCES `Rebok2_DB`.`����������` (`����������_id` )

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

  `������� �����������` DECIMAL(20,4) NULL ,

  `������� ����` INT NULL ,

  `�_����������` VARCHAR(20) NULL ,

  `���������_�����` VARCHAR(50) NULL ,

  `�������` VARCHAR(90) NULL ,

  `����` DECIMAL(15,2) NULL ,

  `�������` VARCHAR(20) NULL ,

  `���������_id` INT UNSIGNED NOT NULL ,

  `���������_id` INT UNSIGNED NOT NULL ,

  `������_id` INT NOT NULL ,

  `����������_id` INT UNSIGNED NOT NULL ,

  `����_���������_id` INT NOT NULL ,

  `����_��������_id` INT NOT NULL ,

  `���������_id` INT UNSIGNED NOT NULL ,

  PRIMARY KEY (`��������_id`) ,

  UNIQUE INDEX `cargo_id_UNIQUE` (`��������_id` ASC) ,

  INDEX `fk_��������_�����������1_idx` (`���������_id` ASC) ,

  INDEX `fk_��������_�����������2_idx` (`���������_id` ASC) ,

  INDEX `fk_��������_������1_idx` (`������_id` ASC) ,

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

    FOREIGN KEY (`������_id` )

    REFERENCES `Rebok2_DB`.`������` (`������_id` )

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





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`table2`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`table2` (

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`������`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`������` (

  `������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `����` DECIMAL(15,2) NULL ,

  `�������` VARCHAR(45) NULL ,

  PRIMARY KEY (`������_id`) ,

  UNIQUE INDEX `������_id_UNIQUE` (`������_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`���������_in_out`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`���������_in_out` (

  `���������_in_out_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `out_delivery_out_delivery_id` INT NOT NULL ,

  `in_delivery_in_delivery_id` INT NOT NULL ,

  PRIMARY KEY (`���������_in_out_id`, `out_delivery_out_delivery_id`, `in_delivery_in_delivery_id`) ,

  UNIQUE INDEX `���������_in_out_id_UNIQUE` (`���������_in_out_id` ASC) ,

  INDEX `fk_���������_in_out_out_delivery1_idx` (`out_delivery_out_delivery_id` ASC) ,

  INDEX `fk_���������_in_out_in_delivery1_idx` (`in_delivery_in_delivery_id` ASC) ,

  CONSTRAINT `fk_���������_in_out_out_delivery1`

    FOREIGN KEY (`out_delivery_out_delivery_id` )

    REFERENCES `Rebok2_DB`.`out_delivery` (`out_delivery_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_���������_in_out_in_delivery1`

    FOREIGN KEY (`in_delivery_in_delivery_id` )

    REFERENCES `Rebok2_DB`.`in_delivery` (`in_delivery_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`������`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`������` (

  `������_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,

  `�����` VARCHAR(45) NULL ,

  `������� (����)` VARCHAR(45) NULL ,

  `���� (����)` VARCHAR(45) NULL ,

  `������` VARCHAR(45) NULL ,

  `�������` VARCHAR(45) NULL ,

  `��������` VARCHAR(45) NULL ,

  `��������_������` VARCHAR(45) NULL ,

  PRIMARY KEY (`������_id`) ,

  UNIQUE INDEX `����_in_out_id_UNIQUE` (`������_id` ASC) )

ENGINE = InnoDB

DEFAULT CHARACTER SET = cp1251

COLLATE = cp1251_ukrainian_ci;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`�����`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`�����` (

  `�����_id` INT NOT NULL AUTO_INCREMENT ,

  `�����` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`�����_id`) ,

  UNIQUE INDEX `�����_id_UNIQUE` (`�����_id` ASC) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`�������`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`�������` (

  `�������_id` INT NOT NULL ,

  `�������` VARCHAR(45) NOT NULL ,

  `�����_�����_id` INT NOT NULL ,

  PRIMARY KEY (`�������_id`, `�����_�����_id`) ,

  INDEX `fk_�������_�����1_idx` (`�����_�����_id` ASC) ,

  CONSTRAINT `fk_�������_�����1`

    FOREIGN KEY (`�����_�����_id` )

    REFERENCES `Rebok2_DB`.`�����` (`�����_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`����`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`����` (

  `����_id` INT NOT NULL AUTO_INCREMENT ,

  `�����` VARCHAR(45) NOT NULL ,

  `�������_id` INT NOT NULL ,

  PRIMARY KEY (`����_id`, `�������_id`) ,

  UNIQUE INDEX `����_id_UNIQUE` (`����_id` ASC) ,

  INDEX `fk_����_�������1_idx` (`�������_id` ASC) ,

  CONSTRAINT `fk_����_�������1`

    FOREIGN KEY (`�������_id` )

    REFERENCES `Rebok2_DB`.`�������` (`�������_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`������`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`������` (

  `������_id` INT NOT NULL AUTO_INCREMENT ,

  `������` VARCHAR(45) NOT NULL ,

  `�������` VARCHAR(45) NOT NULL ,

  `��������` VARCHAR(45) NULL ,

  `��������_������` VARCHAR(45) NULL ,

  `����_id` INT NOT NULL ,

  PRIMARY KEY (`������_id`, `����_id`) ,

  UNIQUE INDEX `������_id_UNIQUE` (`������_id` ASC) ,

  INDEX `fk_������_����1_idx` (`����_id` ASC) ,

  CONSTRAINT `fk_������_����1`

    FOREIGN KEY (`����_id` )

    REFERENCES `Rebok2_DB`.`����` (`����_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `Rebok2_DB`.`������1`

-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `Rebok2_DB`.`������1` (

  `������_id` INT NOT NULL AUTO_INCREMENT ,

  `������_id` INT NOT NULL ,

  PRIMARY KEY (`������_id`, `������_id`) ,

  UNIQUE INDEX `������_id_UNIQUE` (`������_id` ASC) ,

  INDEX `fk_������1_������1_idx` (`������_id` ASC) ,

  CONSTRAINT `fk_������1_������1`

    FOREIGN KEY (`������_id` )

    REFERENCES `Rebok2_DB`.`������` (`������_id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;



USE `Rebok2_DB` ;





SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

