#!/usr/bin/make

# Copyright (c) 2006 Dr. Georg Fischer <punctum|punctum.com>
# @(#) $Id: makefile 807 2011-09-20 16:54:21Z gfis $
# 2011-09-20: dbat.jar separately
# 2010-10-19: all in 1 jar
# 2007-02-20: copied from gramword/dict/makefile

JAVA=java -classpath "../../dist/gramword.jar"
# DBAT=$(JAVA) org.teherba.dbat.Dbat -e UTF-8
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8
LOAD=$(JAVA) org.teherba.gramword.LoadDict -enc UTF-8 -enc UTF-8 -exp

all: infos

infos: load_books load_einh load_bibo
	$(DBAT) -n infos
infos_create:
	$(DBAT) -f ../infos_create.sql
load_books:
	perl books.pl > x.tmp 
	cat x.tmp | $(DBAT) -m csv -s "#" -r infos 
load_einh:
	$(DBAT) -m csv -s "#" -r infos < einh.books.csv
load_bibo:
	$(DBAT) -m csv -s "#" -r infos < bibo.books.csv

d2_books:
	ls -1 /cygdrive/c/var/pt/natlan/bible/d2/orig | cut -b 1-4 | uniq > d2_books.tmp
de_books:
	ls -1 /cygdrive/c/var/pt/natlan/bible/de/org | tr [a-z] [A-Z] | sed -e "s/.TXT//i" | sort > de_books.tmp
	
	