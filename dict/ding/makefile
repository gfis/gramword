#!/bin/make

# makefile - for dict/ding
# @(#) $Id: makefile 976 2013-02-02 16:44:18Z gfis $
# 2013-02-06, Dr. Georg Fischer
# 
# ding 1.3-5 is a Ubuntu package containing the file 'de-en'
# which has word classifications in {...}.
#---------------------------------------
BASE=~/acrab/c/var/pt/natlan/morph/ding/de-en
GRAMWORD=java -classpath ~/work/webapps-super/gramword/dist/gramword.jar org.teherba.gramword
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8

all: extract
#----------
extract:
	perl extract_verbs.pl $(BASE) \
	| sort | uniq \
	| sed -e "s/$$/\t500/" \
	| tee ding.verbs.tmp
	wc ding.verbs.tmp
