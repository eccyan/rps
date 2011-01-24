USE game;

DROP TABLE IF EXISTS `own_draw_settings`;
CREATE TABLE `own_draw_settings` (
	user_data_id BIGINT(20) UNSIGNED NOT NULL
	, card_id BIGINT(20) UNSIGNED NOT NULL
	, own_card_seq BIGINT(20) UNSIGNED NOT NULL
	, type CHAR(20) NOT NULL
	, seq BIGINT(20) UNSIGNED NOT NULL
	, datas TEXT NOT NULL
	, created DATETIME
	, modified DATETIME
	, PRIMARY KEY (user_data_id, card_id, own_card_seq, type, seq)
	, CONSTRAINT `foreing_key_own_draw_settings_user_data_id` FOREIGN KEY (`user_data_id`) REFERENCES `user_datas` (`id`)
	, CONSTRAINT `foreing_key_own_draw_settings_card_id` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`)
) engine = InnoDB;
