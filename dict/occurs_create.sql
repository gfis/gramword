-- @(#) $Id: forge_create.sql 36 2008-09-08 06:05:06Z gfis $
-- 2013-02-05, Georg Fischer
DROP TABLE IF EXISTS occurs;
CREATE TABLE occurs
	( entry		varchar(128) NOT NULL
	, occur		varchar(24)  NOT NULL
	, KEY occurs (entry)
	) ENGINE=MyISAM CHARACTER SET utf8 COLLATE utf8_bin;
