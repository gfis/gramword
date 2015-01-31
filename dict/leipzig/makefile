#!/bin/make

# makefile - for dict/leipzig
# @(#) $Id: makefile 976 2013-02-02 16:44:18Z gfis $
# 2013-02-06, Dr. Georg Fischer
# Caution: UTF-8 is essential
#---------------------------------------
BASE=~/acrab/c/var/pt/natlan/agram/leipzig/wortschatz.txt
GRAMWORD=java -classpath ~/work/webapps-super/gramword/dist/gramword.jar org.teherba.gramword
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8
LET=j
WORD=juckten

all: eval_all
clean:
	rm -f words.*.tmp check.*.tmp
	ls -al
#-------
prepare:
	echo a b c d e f g h i j k l m n o p q r s t u v w x y z ä ö ü | tr " " "\n" | xargs -iqqq echo qqq
#-------
eval_all:
	cp verbs.*.tmp save
	echo a b c d e f g h i j k l m n o p q r s t u v w x y z ä ö ü | tr " " "\n" | xargs -iqqq \
	make evaluate LET=qqq
	wc verbs.*.tmp
#-------
evaluate: occurs_create ev0 ev1 ev2 ev3
occurs_create:
	$(DBAT) -f ../occurs_create.sql
ev0:
	tr -d "\r" < $(BASE) | iconv -f ISO-8859-1 -t UTF-8 | grep -P "^$(LET)" \
	| sed -e "s/$$/\t1/" \
	> words.$(LET).tmp
ev1:
	cat words.$(LET).tmp \
	| $(DBAT) -r occurs
	$(DBAT) -n occurs
ev2:
	grep -P "(en|eln|ern)\t" words.$(LET).tmp \
	| grep -vP "^[A-Z]" \
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
ueb:
	grep -P "^ü" words.ü.tmp| cut -c 1-5 | sort | uniq -c