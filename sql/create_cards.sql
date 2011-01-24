USE game;

DROP TABLE IF EXISTS `cards`;
CREATE TABLE `cards` (
	id BIGINT(20) UNSIGNED NOT NULL
	, name TEXT NOT NULL
	, description TEXT NULL
	, lifepoint BIGINT(20) UNSIGNED NOT NULL
	, offence BIGINT(20) UNSIGNED NOT NULL
	, defense BIGINT(20) UNSIGNED NOT NULL
	, card_attribute_ids TEXT NOT NULL
	, created DATETIME
	, modified DATETIME
	, PRIMARY KEY (id)
) engine = InnoDB;
