#!/bin/make

# extract data and load it into perikopen table
# @(#) $Id: makefile 807 2011-09-20 16:54:21Z gfis $
# 2011-09-20: dbat.jar separately
# 2010-10-19: all in 1 jar
# 2007-02-04, Dr. Georg Fischer <punctum@punctum.com>
JAVA=java -classpath "../../../dist/gramword.jar"
# DBAT=$(JAVA) org.teherba.dbat.Dbat -e UTF-8
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8
LOAD=$(JAVA) org.teherba.gramword.LoadDict -enc UTF-8 -enc UTF-8 -exp

all: holydays holyjava holytest

holydays:
	perl holydays.pl -dict > holydays.dic
	$(DBAT) "delete from infos where morph like 'ccal%'"
	$(DBAT) -m csv -s "#" -r infos < holydays.dic
holytest:
	$(DBAT) "select a.entry, a.enrel from infos a where a.morph = 'ccal.forml' order by 1"
# $holyd#ccal.forml#$formula#

holyjava:
	perl holydays.pl -java > ../../../../churchcal/src/main/java/org/teherba/churchcal/DayMap.java
#---------------------------------------
nordelb:
	perl nordelbien.pl
	sort nordelbien.tmp | uniq > nordelbien.tsv
	cut -f 5 nordelbien.tsv | grep '???'
check:
	perl norde_check.pl | sort 
wiki:
	perl periwiki.pl > periwiki.html
	cmd /c start periwiki.html
norde:
	perl perinorde.pl > perinorde.html
	cmd /c start perinorde.html
keydiff:
	xsltproc getkey.xsl perinorde.html | sort | uniq > norde.tmp
	xsltproc getkey.xsl periwiki.xml   | sort | uniq >  wiki.tmp
	diff norde.tmp wiki.tmp
suname:
	perl suname.pl wikipedia.neu.txt | tee sun_wiki.tmp
	# copy and edit manually in sun_wiki.csv
luth_abbr:
	perl luther_perikope.pl abbr | sort | uniq -c
luth_html:
	perl luther_perikope.pl html > ../../../web/bibleref/luther_perikope.htm
#	tidy -asxhtml luther_perikope.tmp > luther_perikope.html
luth_xml:
	perl luther_perikope.pl xml > luther_perikope.xml
