#!/usr/bin/make

# @(#) $Id: makefile 36 2008-09-08 06:05:06Z gfis $
# 2016-09-13: regression
# 2006-07-20, Georg Fischer

APPL=gramword
JAVA=java -cp dist/gramword.jar
UNSHIELD=$(JAVA) org.teherba.gramword.ReEncode -u
LANG=de
DIFF=diff -y --suppress-common-lines --width=160
DIFF=diff -w -rs -C0
SRC=src/main/java/org/teherba/$(APPL)
TOMC=/var/lib/tomcat/webapps/jextra
TOMC=c:/var/lib/tomcat/webapps/jextra
METHOD=post
LANG=en
TESTDIR=test
# the following can be overriden outside for single or subset tests,
# for example make regression TEST=U%
TEST="%"
# for Windows, SUDO should be empty
SUDO=

all: regression
#-------------------------------------------------------------------
# Perform a regression test 
regression: 
	java -cp dist/gramword.jar \
			org.teherba.common.RegressionTester $(TESTDIR)/all.tests $(TEST) 2>&1 \
	| tee $(TESTDIR)/regression.log
	grep FAILED $(TESTDIR)/regression.log
#
# Recreate all testcases which failed (i.e. remove xxx.prev.tst)
# Handle with care!
# Failing testcases are turned into "passed" and are manifested by this target!
recreate: recr1 regr2
recr0:
	grep -E '> FAILED' $(TESTDIR)/regression*.log | cut -f 3 -d ' ' | xargs -l -ißß echo rm -v test/ßß.prev.tst
recr1:
	grep -E '> FAILED' $(TESTDIR)/regression*.log | cut -f 3 -d ' ' | xargs -l -ißß rm -v test/ßß.prev.tst
regr2:
	make regression TEST=$(TEST) > x.tmp
# test whether all defined tests in mysql.tests have *.prev.tst results and vice versa
check_tests:
	grep -E "^TEST" $(TESTDIR)/all.tests | cut -b 6-8 | sort | uniq -c > $(TESTDIR)/tests_formal.tmp
	ls -1 $(TESTDIR)/*.prev.tst          | cut -b 6-8 | sort | uniq -c > $(TESTDIR)/tests_actual.tmp
	diff -y --suppress-common-lines --width=32 $(TESTDIR)/tests_formal.tmp $(TESTDIR)/tests_actual.tmp
#---------------------------------------------------
jfind:
	find src -iname "*.java" | xargs -l grep -H "$(JF)"
rmbak:
	find src -iname "*.bak"  | xargs -l rm -v
#---------------------------------------------------
zip:
	rm -f $(APPL).zip
	find . | grep -v "test/" | zip -@ $(APPL).zip
clean:
	find . -name "*.bak" | xargs -l rm	
#-----------
tgz: clean
	tar -czvf $(APPL)_`/bin/date +%Y%m%d`.tgz src dict lib test etc web *.wsd* *.xml makefile
#-----------------------------------------------------------------------------------
refactor:
	find . -type f | xargs -l perl refactor.pl
#--------------------
rund_sa:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s sasplit test/duden.txt > x.tmp
	wc x.tmp
wachstube:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s lexsplit test/wachstube.txt 2>&1 | tee x.tmp | less
runf:
	$(JAVA) org.teherba.gramword.GrammarFilter test/fraglich.txt			tempf.html 2> runf.tmp
	cmd /c start tempf.html
rung:
	$(JAVA) org.teherba.gramword.GrammarFilter test/gn_de.txt				tempg.html 2> rung.tmp
	cmd /c start tempg.html
	grep "#null" rung.tmp | sort | uniq -c | sort | tee  diffg.tmp
wict.vb:
	$(JAVA) org.teherba.gramword.GrammarFilter dict/vb/wictionary.vb.tmp	tempvb.html 2> runvb.tmp
	cmd /c start tempvb.html
rung_sa:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s sasplit test/gn_de.txt > x.tmp	   2> nul
	wc x.tmp
runj:
	$(JAVA) org.teherba.gramword.GrammarFilter -e UTF-8 test/johannes.txt 	tempj.html 2> runj.tmp
	cmd /c start tempj.html
	grep "#null" runj.tmp | sort | uniq -c | sort | tee  diffj.tmp
runj_pr:
	$(JAVA) org.teherba.gramword.GrammarFilter -e UTF-8 -m dict -s prsplit test/johannes.txt 2> runj.tmp | sort | uniq -c
runj_sa:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s sasplit test/johannes.txt 2> nul 
#| sort | uniq > x.tmp	   
#	wc x.tmp
runn:
	$(JAVA) org.teherba.gramword.GrammarFilter -e UTF-8 test/nu_decline.txt tempn.html 2> runn.tmp
	cmd /c start tempn.html
	grep "#null" runn.tmp | sort | uniq -c | sort | tee  diffn.tmp
runn2:
	$(JAVA) org.teherba.gramword.GrammarFilter -e UTF-8 -m dict test/nu_decline.txt 2> nul
runn3:
	$(JAVA) org.teherba.gramword.GrammarFilter -e UTF-8 -m text test/nu_decline.txt 2> nul
runt:
	$(JAVA) org.teherba.gramword.GrammarFilter test/taz10k.txt				tempt.html 2> runt.tmp
	cmd /c start tempt.html
runt_root:
	$(JAVA) org.teherba.gramword.GrammarFilter test/taz_sbroot.tmp			temptr.html 2> runtr.tmp
	cmd /c start temptr.html
runt_r2:
	grep -v "<span" temptr.html > runtr2.txt
	$(JAVA) org.teherba.gramword.GrammarFilter -e UTF-8 runtr2.txt 			temptr2.html 2> runtr2.tmp
	cmd /c start temptr2.html
runt_pr:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s prsplit test/taz500k.txt 	 
#	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s prsplit test/taz10k.txt	   		   2> nul
runt_lex:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s lexsplit test/taz500k.txt 2>&1 | tee x.tmp
	wc x.txt
runt_sa:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s sasplit test/taz500k.txt > x.tmp
	wc x.txt
runu:
	$(JAVA) org.teherba.gramword.GrammarFilter test/umlaut.txt				tempu.html 2> runu.tmp
	cmd /c start tempu.html
	grep "#null" runu.tmp | sort | uniq -c | sort | tee  diffu.tmp
runw:
	$(JAVA) org.teherba.gramword.GrammarFilter test/wiki.tmp				tempw.html 2> runw.tmp
	cmd /c start tempw.html
	grep "#null" runw.tmp | sort | uniq -c | sort | tee  diffw.tmp
runx4:
	$(JAVA) org.teherba.gramword.GrammarFilter test/quixote1-4.txt			tempx.html 2> runx.tmp
	cmd /c start tempx.html
	grep "#null" runx.tmp | sort | uniq -c | sort | tee  diffx.tmp
runx52:
	$(JAVA) org.teherba.gramword.GrammarFilter test/quixote1-52.txt			tempx.html 2> runx.tmp
	cmd /c start tempx.html
	grep "#null" runx.tmp | sort | uniq -c | sort | tee  diffx.tmp
runx_pr:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s prsplit test/quixote1-4.txt	2> nul | sort | uniq -c
runx_sa:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s sasplit test/quixote1-4.txt > x.tmp	   2> nul
	wc x.tmp
runx_lex:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s lexsplit test/quixote1-4.txt 2>&1
runz:
	$(JAVA) org.teherba.gramword.GrammarFilter test/zeit_2006_26.1.txt		tempz.html 2> runz.tmp
	cmd /c start tempz.html
	grep "#null" runz.tmp | sort | uniq -c | sort | tee  diffz.tmp
runz_sa:
	$(JAVA) org.teherba.gramword.GrammarFilter -m dict -s sasplit test/zeit_2006_26.1.txt > x.tmp	   2> nul
	wc x.tmp
runz_sb:
	cut -f 1 dict/Sb/zeit.raw | $(UNSHIELD) > x1.tmp
	$(JAVA) org.teherba.gramword.GrammarFilter -e UTF-8 x1.tmp zsa.html  2> x.tmp
	cmd /c start zsa.html
