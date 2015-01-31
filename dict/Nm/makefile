# makefile - for names
# @(#) $Id: makefile 36 2008-09-08 06:05:06Z gfis $
# 2006-07-18, Georg Fischer <punctum@punctum.com>

JAVA=java -classpath "../../dist/gramword.jar;../../lib/mysql.jar"
SHIELD=$(JAVA) org.teherba.gramword.ReEncode -s 
AVON=../../../../../pt/avon

all: city mountain river state

city:
	perl de_town.pl 	| sort | uniq > nm.de_city.dic
	perl xx_city.pl 	| sort | uniq > nm.xx_city.dic
mountain:
	perl de_mountain.pl	| sort | uniq > nm.de_mountain.dic
state:
	perl de_state.pl  	| sort | uniq > nm.de_state.dic
river:
	perl de_river.pl 	| sort | uniq > nm.de_river.dic
#---------------------
avon:
	perl avon3.pl $(AVON)/AVON95.LST > nm.de_city.dic
grin:
	grep -e "in	" surnam64.lst | grep -ve "ein	"
grei:
	grep -e "ei	" surnam64.lst 
grie:
	grep -e "ie	" surnam64.lst 
