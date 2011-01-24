USE game;

DROP TABLE IF EXISTS `own_game_datas`;
CREATE TABLE `own_game_datas` (
	user_data_id BIGINT(20) UNSIGNED NOT NULL
	, experience BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
	, money BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
	, spend_money BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
	, access_count BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
	, battle_count BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
	, won_count BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
	, lose_count BIGINT(20) UNSIGNED NOT NULL DEFAULT 0
	, created DATETIME
	, modified DATETIME
	, PRIMARY KEY (user_data_id)
	, CONSTRAINT `foreing_key_own_game_datas_user_data_id` FOREIGN KEY (`user_data_id`) REFERENCES `user_datas` (`id`)
) engine = InnoDB;
