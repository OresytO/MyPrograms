CREATE  TABLE `MacCOM_DB_Delivery`.`out_delivery` (
  `����������_�����` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `����_�����������` DATE NULL ,
  `����_���������` DATE NULL ,
  `�_����������` VARCHAR(45) NOT NULL ,
  `���������` VARCHAR(45) NOT NULL ,
  `����������` VARCHAR(45) NULL ,
  `���������` VARCHAR(45) NULL ,
  `̳���_���������` VARCHAR(90) NULL ,
  `������_�����������` FLOAT NOT NULL ,
  `ʳ������_����` FLOAT NULL ,
  `�������_���������` VARCHAR(45) NULL ,
  `̳���_��������` VARCHAR(45) NULL ,
  `����` FLOAT NULL ,
  `�������` VARCHAR(45) NULL ,
  `³���������` VARCHAR(45) NOT NULL ,
  `���������_�����` VARCHAR(45) NULL ,
  `�������` BLOB NULL ,
  PRIMARY KEY (`����������_�����`) ,
  UNIQUE INDEX `����������_�����_UNIQUE` (`����������_�����` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`in_delivery` (
  `����������_�����` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `����_�����������` DATE NULL ,
  `����_���������` DATE NULL ,
  `����_���������` DATE NULL ,
  `�_����������` VARCHAR(45) NOT NULL ,
  `���������` VARCHAR(45) NOT NULL ,
  `����������` VARCHAR(45) NULL ,
  `���������` VARCHAR(45) NULL ,
  `̳���_���������` VARCHAR(90) NULL ,
  `�������_�����������` FLOAT NOT NULL ,
  `ʳ������_����` FLOAT NULL ,
  `�������_���������` VARCHAR(45) NULL ,
  `̳���_��������` VARCHAR(45) NULL ,
  `����` FLOAT NULL ,
  `�������` VARCHAR(45) NULL ,
  `�_���������` VARCHAR(45) NULL ,
  `ϳ����_�����` VARCHAR(45) NULL ,
  `��������` VARCHAR(45) NOT NULL ,
  `���������_�����` VARCHAR(45) NULL ,
  `�������` BLOB NULL ,
  PRIMARY KEY (`����������_�����`) ,
  UNIQUE INDEX `����������_�����_UNIQUE` (`����������_�����` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`courier` (
  `����������_�����` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `�����_������` VARCHAR(45) NULL ,
  `�_������` VARCHAR(45) NULL ,
  `������` VARCHAR(45) NULL ,
  `�������1` VARCHAR(45) NOT NULL ,
  `�������2` VARCHAR(45) NOT NULL ,
  `�������3` VARCHAR(45) NULL ,
  `�����_��_����������` VARCHAR(45) NULL ,
  `���_����������` VARCHAR(45) NULL ,
  PRIMARY KEY (`����������_�����`) ,
  UNIQUE INDEX `����������_�����_UNIQUE` (`����������_�����` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`forwarder` (
  `����������_�����` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `�������` VARCHAR(45) NULL ,
  `���` VARCHAR(45) NULL ,
  `��_�������` VARCHAR(45) NULL ,
  `����_�_��������` VARCHAR(45) NOT NULL ,
  `����_�_���.����` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`����������_�����`) ,
  UNIQUE INDEX `����������_�����_UNIQUE` (`����������_�����` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;