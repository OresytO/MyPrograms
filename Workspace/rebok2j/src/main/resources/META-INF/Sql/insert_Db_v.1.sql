INSERT INTO `rebok2j`.`users` (`password`, `userName`, `enabled`, `userNickname`) VALUES ('1111', 'orest', 1, 'orest');
INSERT INTO `rebok2j`.`users` (`password`, `userName`, `enabled`, `userNickname`) VALUES ('1111', 'OREST1', 1, 'OREST1');

INSERT INTO `rebok2j`.`roles` (`roleName`) VALUES ('ROLE_USER');
INSERT INTO `rebok2j`.`roles` (`roleName`) VALUES ('ROLE_GUEST');
INSERT INTO `rebok2j`.`roles` (`roleName`) VALUES ('ROLE_ADMIN');

INSERT INTO `rebok2j`.`UsersRoles` (`role_id`, `user_id`) VALUES ('3', '1');
INSERT INTO `rebok2j`.`UsersRoles` (`role_id`, `user_id`) VALUES ('1', '2');

INSERT INTO `rebok2j`.`staff` (`drivingLicense`, `firstName`, `lastName`, `passport`, `powerToSign`) VALUES ('1111', 'Orest', 'loz', '1111', '1');

INSERT INTO `rebok2j`.`locations` (`locationName`) VALUES ('Lviv');

INSERT INTO `rebok2j`.`idTypes` (`idName`) VALUES ('passport');
INSERT INTO `rebok2j`.`idTypes` (`idName`) VALUES ('driving lice');

INSERT INTO `rebok2j`.`deliveriesTypes` (`deliveryType`) VALUES ('in');
INSERT INTO `rebok2j`.`deliveriesTypes` (`deliveryType`) VALUES ('out');

INSERT INTO `rebok2j`.`courierCompanies` (`address`, `companyName`, `phones`, `warehouseCode`, `idTypeId`, `location`) VALUES ('Lviv', 'companyName', '1111', '1', '1', '1');

INSERT INTO `rebok2j`.`Authorizations` (`AuthorizationCode`, `creationDate`, `dateOfAuthorization`, `forwarderId`, `signedPersonId`) VALUES ('1111', '2014/05/27', '2014/05/27', '1', '1');