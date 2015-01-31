-- process prefixes of strong verbs
-- @(#) $Id: verb_select.sql 36 2008-09-08 06:05:06Z gfis $
-- 2006-06-09, Georg Fischer
SELECT w.entry FROM roots r, words w 
WHERE  w.morph LIKE 'VbSIn%'
  AND  w.entry = concat(r.entry, r.descr)
ORDER BY 1;
SELECT count(w.entry) FROM roots r, words w 
WHERE  w.morph LIKE 'VbSIn%'
  AND  w.entry = concat(r.entry, r.descr)
ORDER BY 1;
