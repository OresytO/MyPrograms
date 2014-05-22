INSERT INTO `rebok2j`.`users` (`password`, `userName`, `enabled`) VALUES ('1111', 'orest', 1);
INSERT INTO `rebok2j`.`users` (`password`, `userName`, `enabled`) VALUES ('1111', 'OREST', 1);

INSERT INTO `rebok2j`.`roles` (`roleName`) VALUES ('USER_ROLE');
INSERT INTO `rebok2j`.`roles` (`roleName`) VALUES ('GUEST_ROLE');
INSERT INTO `rebok2j`.`roles` (`roleName`) VALUES ('ADMIN_ROLE');

INSERT INTO `rebok2j`.`users_roles` (`role_id`, `user_id`) VALUES ('3', '1');
INSERT INTO `rebok2j`.`users_roles` (`role_id`, `user_id`) VALUES ('1', '2');
