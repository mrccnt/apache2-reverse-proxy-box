UPDATE `mysql`.`user` SET `Host`="%" WHERE `Host`="::1" AND `User`="root";

CREATE DATABASE `user_storage` CHARACTER SET "utf8" COLLATE "utf8_unicode_ci";

CREATE TABLE `user_storage`.`user` (
  `user_id`   INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  `username`  VARCHAR(45)   NOT NULL,
  `password`  VARCHAR(4096) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

INSERT INTO `user_storage`.`user` (`username`, `password`) VALUES ("test", "$apr1$nc/ziZJ3$pNCss69Jy8A5OB8IziF/o.");