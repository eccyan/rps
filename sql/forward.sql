SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `game` ;
CREATE SCHEMA IF NOT EXISTS `game` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `game` ;

-- -----------------------------------------------------
-- Table `game`.`card_attributes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game`.`card_attributes` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `game`.`card_attributes` (
  `id` BIGINT(20) UNSIGNED NOT NULL ,
  `name` TEXT NULL DEFAULT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `modified` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `game`.`card_attribute_relations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game`.`card_attribute_relations` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `game`.`card_attribute_relations` (
  `attribute_id` BIGINT(20) UNSIGNED NOT NULL ,
  `related_attribute_id` BIGINT(20) UNSIGNED NOT NULL ,
  `type` CHAR(20) NOT NULL ,
  `datas` TEXT NULL DEFAULT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `modified` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`attribute_id`, `related_attribute_id`, `type`) ,
  INDEX `foreing_key_card_attribute_relations_related_attribute_id` (`related_attribute_id` ASC) ,
  CONSTRAINT `foreing_key_card_attribute_relations_attribute_id`
    FOREIGN KEY (`attribute_id` )
    REFERENCES `game`.`card_attributes` (`id` ),
  CONSTRAINT `foreing_key_card_attribute_relations_related_attribute_id`
    FOREIGN KEY (`related_attribute_id` )
    REFERENCES `game`.`card_attributes` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `game`.`cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game`.`cards` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `game`.`cards` (
  `id` BIGINT(20) UNSIGNED NOT NULL ,
  `name` TEXT NOT NULL ,
  `description` TEXT NULL DEFAULT NULL ,
  `lifepoint` BIGINT(20) UNSIGNED NOT NULL ,
  `offence` BIGINT(20) UNSIGNED NOT NULL ,
  `defense` BIGINT(20) UNSIGNED NOT NULL ,
  `card_attribute_ids` TEXT NOT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `modified` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `game`.`user_datas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game`.`user_datas` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `game`.`user_datas` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `fbid` BIGINT(20) UNSIGNED NULL DEFAULT NULL ,
  `fbid_text` TEXT NOT NULL ,
  `name` TEXT NOT NULL ,
  `gender` CHAR(20) NULL DEFAULT NULL ,
  `birthday` DATETIME NULL DEFAULT NULL ,
  `link` TEXT NULL DEFAULT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `modified` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `fbid` (`fbid` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `game`.`own_cards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game`.`own_cards` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `game`.`own_cards` (
  `user_data_id` BIGINT(20) UNSIGNED NOT NULL ,
  `card_id` BIGINT(20) UNSIGNED NOT NULL ,
  `seq` BIGINT(20) UNSIGNED NOT NULL ,
  `lifepoint` BIGINT(20) UNSIGNED NOT NULL ,
  `offence` BIGINT(20) UNSIGNED NOT NULL ,
  `defense` BIGINT(20) UNSIGNED NOT NULL ,
  `card_attribute_ids` TEXT NULL DEFAULT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `modified` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`user_data_id`, `card_id`, `seq`) ,
  INDEX `foreing_key_own_cards_card_id` (`card_id` ASC) ,
  CONSTRAINT `foreing_key_own_cards_user_data_id`
    FOREIGN KEY (`user_data_id` )
    REFERENCES `game`.`user_datas` (`id` ),
  CONSTRAINT `foreing_key_own_cards_card_id`
    FOREIGN KEY (`card_id` )
    REFERENCES `game`.`cards` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `game`.`own_draw_settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game`.`own_draw_settings` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `game`.`own_draw_settings` (
  `user_data_id` BIGINT(20) UNSIGNED NOT NULL ,
  `card_id` BIGINT(20) UNSIGNED NOT NULL ,
  `own_card_seq` BIGINT(20) UNSIGNED NOT NULL ,
  `type` CHAR(20) NOT NULL ,
  `seq` BIGINT(20) UNSIGNED NOT NULL ,
  `datas` TEXT NOT NULL ,
  `created` DATETIME NULL DEFAULT NULL ,
  `modified` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`user_data_id`, `card_id`, `own_card_seq`, `type`, `seq`) ,
  INDEX `foreing_key_own_draw_settings_card_id` (`card_id` ASC) ,
  CONSTRAINT `foreing_key_own_draw_settings_user_data_id`
    FOREIGN KEY (`user_data_id` )
    REFERENCES `game`.`user_datas` (`id` ),
  CONSTRAINT `foreing_key_own_draw_settings_card_id`
    FOREIGN KEY (`card_id` )
    REFERENCES `game`.`cards` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `game`.`own_game_datas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game`.`own_game_datas` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `game`.`own_game_datas` (
  `user_data_id` BIGINT(20) UNSIGNED NOT NULL ,
  `experience` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `money` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `spend_money` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `access_count` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `battle_count` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `won_count` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `lose_count` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `created` DATETIME NULL DEFAULT NULL ,
  `modified` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`user_data_id`) ,
  CONSTRAINT `foreing_key_own_game_datas_user_data_id`
    FOREIGN KEY (`user_data_id` )
    REFERENCES `game`.`user_datas` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
