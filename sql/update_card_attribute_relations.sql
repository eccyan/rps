USE game;

REPLACE INTO `card_attribute_relations` VALUES (1, 2, 'critical', NULL, now(), now());
REPLACE INTO `card_attribute_relations` VALUES (2, 3, 'critical', NULL, now(), now());
REPLACE INTO `card_attribute_relations` VALUES (3, 1, 'critical', NULL, now(), now());
REPLACE INTO `card_attribute_relations` VALUES (1, 3, 'ineffectual', NULL, now(), now());
REPLACE INTO `card_attribute_relations` VALUES (2, 1, 'ineffectual', NULL, now(), now());
REPLACE INTO `card_attribute_relations` VALUES (3, 2, 'ineffectual', NULL, now(), now());
