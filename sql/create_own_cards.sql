USE game;

DROP TABLE IF EXISTS `own_cards`;
CREATE TABLE `own_cards` (
	user_data_id BIGINT(20) UNSIGNED NOT NULL
	, card_id BIGINT(20) UNSIGNED NOT NULL
	, seq BIGINT(20) UNSIGNED NOT NULL
	, lifepoint BIGINT(20) UNSIGNED NOT NULL
	, offence BIGINT(20) UNSIGNED NOT NULL
	, defense BIGINT(20) UNSIGNED NOT NULL
	, card_attribute_ids TEXT NULL
	, created DATETIME
	, modified DATETIME
	, PRIMARY KEY (user_data_id, card_id, seq)
	, CONSTRAINT `foreing_key_own_cards_user_data_id` FOREIGN KEY (`user_data_id`) REFERENCES `user_datas` (`id`)
	, CONSTRAINT `foreing_key_own_cards_card_id` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`)
) engine = InnoDB;
