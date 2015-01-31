-- caution - do not edit here - c.f. makefile.create_ddl
-- @(#) $Id: forge_create.sql 36 2008-09-08 06:05:06Z gfis $
-- 2006-08-13, Georg Fischer
DROP TABLE IF EXISTS forge;
CREATE TABLE forge
	( entry		varchar(64) NOT NULL
	, morph		varchar(64) NOT NULL
	, enrel		varchar(64) 
	, morel		varchar(64)
	, KEY forge (entry)
	) ENGINE=MyISAM CHARACTER SET utf8 COLLATE utf8_bin;
