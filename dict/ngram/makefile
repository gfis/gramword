#!/bin/make

# makefile - for dict/ngram
# @(#) $Id: makefile 976 2013-02-02 16:44:18Z gfis $
# 2013-02-05, Dr. Georg Fischer
#---------------------------------------
GDIR=~/acrab/d/ebook/google-ngram
# occurrence files are $(GDIR)/words.?.tmp
GRAMWORD=java -classpath ~/work/webapps-super/gramword/dist/gramword.jar org.teherba.gramword
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8
LET=j
WORD=juckten

all: eval_all
#-------
eval_all:
	cp verbs.?.tmp save
	find $(GDIR) -name "words.?.tmp" -printf "%P\n" | cut -b 7 | sort | xargs -l -iqqq \
	make evaluate LET=qqq
	wc verbs.?.tmp
#-------
evaluate: occurs_create ev1 ev2 ev3
occurs_create:
	$(DBAT) -f ../occurs_create.sql
ev1:
	grep -vP "^[A-ZÄÖÜ]" $(GDIR)/words.$(LET).tmp \
	| $(DBAT) -r occurs
	$(DBAT) -n occurs
ev2:
	grep -P "(en|eln|ern)\t" $(GDIR)/words.$(LET).tmp \
	| grep -vP "^[A-ZÄÖÜ]" \
	>     check.$(LET).tmp
	wc    check.$(LET).tmp
ev3:
	$(GRAMWORD).flex.FlexTester -m 2 -l de -s VbIn check.$(LET).tmp \
	| tee verbs.$(LET).tmp
	wc    verbs.$(LET).tmp
#----------
# Test targets
sel:
	$(DBAT) -m csv -s ";" "SELECT entry, occur FROM occurs WHERE entry LIKE '%$(WORD)%'"
sel2:
	$(DBAT) "SELECT sum(occur) FROM occurs WHERE entry IN ('jagdkundige') AND entry <> 'jagdkundigen'"
	$(DBAT) "SELECT occur FROM occurs WHERE entry = 'jagdkundigen'"
	$(DBAT) "SELECT sum(occur) FROM occurs WHERE entry IN ('jagdkundige','jagdkundigst','jagdkundigt','jagdkundigte','jagdkundigtest','jagdkundigten','jagdkundigtet','jagdkundigter','jagdkundigtes','jagdkundigtem') AND entry <> 'jagdkundigen' UNION SELECT occur FROM occurs WHERE entry = 'jagdkundigen'"
deuinf:
	$(GRAMWORD).flex.DeuInflector Vb 1 $(WORD)
ftest:
	$(GRAMWORD).flex.FlexTester -d 2 -l de -s VbIn -m 1 -w $(WORD)
#---------------------------------------
# grep Ä words.a.tmp | tr '[:upper:]' '[:lower:]' | tr 'Äöü' 'äÖÜ'