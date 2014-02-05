CREATE  TABLE `MacCOM_DB_Delivery`.`out_delivery` (
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Дата_відправлення` DATE NULL ,
  `Дата_отримання` DATE NULL ,
  `№_декларації` VARCHAR(45) NOT NULL ,
  `Перевізник` VARCHAR(45) NOT NULL ,
  `Експедитор` VARCHAR(45) NULL ,
  `Отримувач` VARCHAR(45) NULL ,
  `Місце_отримання` VARCHAR(90) NULL ,
  `Вартісь_перевезення` FLOAT NOT NULL ,
  `Кількість_місць` FLOAT NULL ,
  `Компанія_відправник` VARCHAR(45) NULL ,
  `Місце_відправки` VARCHAR(45) NULL ,
  `Вага` FLOAT NULL ,
  `Габарит` VARCHAR(45) NULL ,
  `Відправлено` VARCHAR(45) NOT NULL ,
  `Контактна_особа` VARCHAR(45) NULL ,
  `Примітка` BLOB NULL ,
  PRIMARY KEY (`Порядковий_номер`) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`in_delivery` (
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Дата_відправлення` DATE NULL ,
  `Дата_отримання` DATE NULL ,
  `Дата_документу` DATE NULL ,
  `№_декларації` VARCHAR(45) NOT NULL ,
  `Перевізник` VARCHAR(45) NOT NULL ,
  `Експедитор` VARCHAR(45) NULL ,
  `Отримувач` VARCHAR(45) NULL ,
  `Місце_отримання` VARCHAR(90) NULL ,
  `Вартість_перевезення` FLOAT NOT NULL ,
  `Кількість_місць` FLOAT NULL ,
  `Компанія_відправник` VARCHAR(45) NULL ,
  `Місце_відправки` VARCHAR(45) NULL ,
  `Вага` FLOAT NULL ,
  `Габарит` VARCHAR(45) NULL ,
  `№_Доручення` VARCHAR(45) NULL ,
  `Підпис_особи` VARCHAR(45) NULL ,
  `Отримано` VARCHAR(45) NOT NULL ,
  `Контактна_особа` VARCHAR(45) NULL ,
  `Примітка` BLOB NULL ,
  PRIMARY KEY (`Порядковий_номер`) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`courier` (
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Назва_компанії` VARCHAR(45) NULL ,
  `№_складу` VARCHAR(45) NULL ,
  `Адреса` VARCHAR(45) NULL ,
  `Телефон1` VARCHAR(45) NOT NULL ,
  `Телефон2` VARCHAR(45) NOT NULL ,
  `Телефон3` VARCHAR(45) NULL ,
  `Права_як_посвідчення` VARCHAR(45) NULL ,
  `Вид_розрахунку` VARCHAR(45) NULL ,
  PRIMARY KEY (`Порядковий_номер`) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`forwarder` (
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Прізвище` VARCHAR(45) NULL ,
  `Імя` VARCHAR(45) NULL ,
  `По_батькові` VARCHAR(45) NULL ,
  `Серія_№_паспорта` VARCHAR(45) NOT NULL ,
  `Серія_№_пос.водія` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`Порядковий_номер`) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;