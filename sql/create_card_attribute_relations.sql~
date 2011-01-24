USE game;

DROP TABLE IF EXISTS `card_attribute_relations`;
CREATE TABLE `card_attribute_relations` (
	attribute_id BIGINT(20) UNSIGNED NOT NULL
	, related_attribute_id BIGINT(20) UNSIGNED NOT NULL
	, type CHAR(20) NOT NULL
	, datas TEXT NULL
	, created DATETIME
	, modified DATETIME
	, PRIMARY KEY (attribute_id, related_attribute_id, type)
	, CONSTRAINT `foreing_key_card_attribute_relations_attribute_id` FOREIGN KEY (`attribute_id`) REFERENCES `card_attributes` (`id`)
	, CONSTRAINT `foreing_key_card_attribute_relations_related_attribute_id` FOREIGN KEY (`related_attribute_id`) REFERENCES `card_attributes` (`id`)
) engine = InnoDB;
