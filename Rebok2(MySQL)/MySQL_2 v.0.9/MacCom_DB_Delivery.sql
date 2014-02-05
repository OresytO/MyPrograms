CREATE  TABLE `MacCOM_DB_Delivery`.`Out` (
  `idOut` INT NOT NULL ,
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Дата_відправлення` DATE NULL ,
  `Дата_отримання` DATE NULL ,
  `№_декларації` VARCHAR(45) NOT NULL ,
  `Перевізник` VARCHAR(45) NOT NULL ,
  `Екседитор` VARCHAR(45) NULL ,
  `Отримувач` VARCHAR(45) NULL ,
  `Місце_отримання` VARCHAR(90) NULL ,
  `Вартісь_перевезення` FLOAT NOT NULL ,
  `Кількість_місць` FLOAT NULL ,
  `Компанія_відправник` VARCHAR(45) NULL ,
  `Місце_відправки` VARCHAR(45) NULL ,
  `Вага` FLOAT NULL ,
  `Габарит` VARCHAR(45) NULL ,
  `Відправлено` VARCHAR(45) NULL ,
  `Контактна_особа` VARCHAR(45) NULL ,
  `Примітка` BLOB NULL ,
  PRIMARY KEY (`idOut`) ,
  UNIQUE INDEX `idOut_UNIQUE` (`idOut` ASC) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`In` (
  `idIn` INT NOT NULL ,
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Дата_відправлення` DATE NULL ,
  `Дата_отримання` DATE NULL ,
  `Дата_документу` DATE NULL ,
  `№_декларації` VARCHAR(45) NOT NULL ,
  `Перевізник` VARCHAR(45) NOT NULL ,
  `Екседитор` VARCHAR(45) NULL ,
  `Отримувач` VARCHAR(45) NULL ,
  `Місце_отримання` VARCHAR(90) NULL ,
  `Вартісь_перевезення` FLOAT NOT NULL ,
  `Кількість_місць` FLOAT NULL ,
  `Компанія_відправник` VARCHAR(45) NULL ,
  `Місце_відправки` VARCHAR(45) NULL ,
  `Вага` FLOAT NULL ,
  `Габарит` VARCHAR(45) NULL ,
  `№_Доручення` VARCHAR(45) NULL ,
  `Підпис_особи` VARCHAR(45) NULL ,
  `Отримано` VARCHAR(45) NULL ,
  `Контактна_особа` VARCHAR(45) NULL ,
  `Примітка` BLOB NULL ,
  PRIMARY KEY (`idIn`) ,
  UNIQUE INDEX `idIn_UNIQUE` (`idIn` ASC) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`Courier` (
  `idCourier` INT NOT NULL ,
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Назва_компанії` VARCHAR(45) NULL ,
  `№_складу` VARCHAR(45) NULL ,
  `Адреса` VARCHAR(45) NULL ,
  `Телефон1` VARCHAR(45) NOT NULL ,
  `Телефон2` VARCHAR(45) NOT NULL ,
  `Телефон3` VARCHAR(45) NULL ,
  `Права_як_посвідчення` VARCHAR(45) NULL ,
  `Вид_розрахунку` VARCHAR(45) NULL ,
  PRIMARY KEY (`idCourier`) ,
  UNIQUE INDEX `idCourier_UNIQUE` (`idCourier` ASC) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

CREATE  TABLE `MacCOM_DB_Delivery`.`Forwarder` (
  `idForwarder` INT NOT NULL ,
  `Порядковий_номер` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Прізвище` VARCHAR(45) NULL ,
  `Імя` VARCHAR(45) NULL ,
  `По_батькові` VARCHAR(45) NULL ,
  `Серія_№_паспорта` VARCHAR(45) NOT NULL ,
  `Серія_№_пос.водія` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idForwarder`) ,
  UNIQUE INDEX `idForwarder_UNIQUE` (`idForwarder` ASC) ,
  UNIQUE INDEX `Порядковий_номер_UNIQUE` (`Порядковий_номер` ASC) )
DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;