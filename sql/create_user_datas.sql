USE game;

DROP TABLE IF EXISTS `user_datas`;
CREATE TABLE `user_datas` (
	id BIGINT(20) UNSIGNED AUTO_INCREMENT NOT NULL
	, fbid BIGINT(20) UNSIGNED UNIQUE
	, fbid_text TEXT NOT NULL
	, name TEXT NOT NULL
	, gender CHAR(20) NULL
	, birthday DATETIME NULL
	, link TEXT NULL
	, created DATETIME
	, modified DATETIME
	, PRIMARY KEY (id)
) engine = InnoDb;
