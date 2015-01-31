#!/bin/make

# extract and generate data for ../cantata
# @(#) $Id: makefile 807 2011-09-20 16:54:21Z gfis $
# 2011-09-20: dbat.jar separately
# 2010-10-19: all in 1 jar
# 2007-03-06, Dr. Georg Fischer <punctum@punctum.com>
# Table 'infos' must be present	

JAVA=java -classpath "../../../dist/gramword.jar"
# DBAT=$(JAVA) org.teherba.dbat.Dbat -e UTF-8
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8

all: bwv1 bwv2 bwv4 bwv5 diff load date_check

pdf:
	# pdftohtml Bach-Werke-Verzeichnis.pdf
	# generates Bach-Werke-Verzeichniss.html (Bach-Werke-Verzeichnis.html is not used)
	# perl bwv1_pdf.pl -list  | tee bwv1_pdf.tmp
bwv1:
	perl bwv1_pdf.pl -dict  > bwv1_pdf.dic
bwv2:
	perl bwv2_wiki.pl       > bwv2_wiki.dic
bwv4:
	perl bwv4_sorted.pl     > bwv4_sorted.dic
bwv5:
	perl bwv5_datum.pl      > bwv5_datum.dic
	
diff:
	grep "title" bwv1_pdf.dic     | cut -b 5- > bwv1_pdf.tmp
	grep "title" bwv2_wiki.dic    | cut -b 5- > bwv2_wiki.tmp
	grep "title" bwv5_datum.dic   | cut -b 5- > bwv5_datum.tmp
	sort bwv1_pdf.tmp bwv2_wiki.tmp bwv5_datum.tmp > bwv_diff.tmp
load:
	$(DBAT) "delete from infos where entry like 'bwv%'"
	$(DBAT) -m csv -s "#" -e UTF-8 -r infos < bwv1_pdf.dic
	$(DBAT) -m csv -s "#" -e UTF-8 -r infos < bwv2_wiki.dic
	$(DBAT) -m csv -s "#" -e UTF-8 -r infos < bwv5_datum.dic
#	$(DBAT) -m csv -s "#" -e UTF-8 -r infos < bwv4_sorted.dic
holyd:
	$(DBAT) -x "select enrel,morel from infos" \
	" where morph='holyd' " \
	| grep -vE "trin|epi|adv|profan" \
	| sort | uniq -c

#	         date     bwv_no   holyd    refa     refb
dates:
	$(DBAT) -x \
	" select a.enrel, a.entry, b.enrel, a.morel, b.morel " \
	"   from infos a, infos b                            " \
	"   where a.entry = b.entry                          " \
	" 	and a.morph = 'datum'                            " \
	" 	and b.morph = 'holyd'                            " \
	" 	and b.enrel <> ''                                " \
	"   order by 1	                                     " \
	| less

#	         bwv_no              date     holyd 
dates2:
	$(DBAT) -x \
	" select substr(a.entry, 5), a.enrel, b.enrel        " \
	"   from infos a, infos b                            " \
	"   where a.entry = b.entry                          " \
	" 	and a.morph = 'datum'                            " \
	" 	and b.morph = 'holyd'                            " \
	" 	and b.enrel <> ''                                " \
	"   order by 1	                                     " \
	| sort | uniq -c | less

# a: $entry#holyd#$holyd#bwv1
# b: $holyd#ccal.forml#$formula#
#	         bwv_no   holyd   'bwvi'
holyd_check:
	$(DBAT) -x \
	" select a.entry, a.enrel, a.morel        " \
	"   from infos a                                     " \
	"   where a.morph = 'holyd'                          " \
	"   and a.enrel <> 'profan'                          " \
	"   and a.enrel <> ''                                " \
	" 	and a.enrel not in (                             " \
	" 	  select b.entry from infos b where b.morph = 'ccal.forml') " \
	| cat
date_check:
	$(DBAT) -x \
	" select a.enrel, b.enrel, a.entry, a.morel          " \
	"   from infos a, infos b                            " \
	"   where a.entry = b.entry                          " \
	" 	and a.morph = 'datum'                            " \
	" 	and b.morph = 'holyd'                            " \
	" 	and b.enrel <> ''                                " \
	"   order by 1	                                     " \
	| sort | uniq | tr -d "\r" > ../../../../churchcal/test/iso_name.tmp

