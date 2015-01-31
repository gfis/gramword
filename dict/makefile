#!/usr/bin/make

# Copyright (c) 2006 Dr. Georg Fischer <punctum at punctum dot kom>
# @(#) $Id: makefile 807 2011-09-20 16:54:21Z gfis $
# 2011-09-20: dbat.jar separately
# 2010-10-19: load infos from subdirectories
# 2008-04-01: all in 1 jar
# 2007-02-28: + infos
# 2007-02-01: no org.punctum
# 2007-01-04: Dbat
# 2006-06-05, Georg Fischer

JAVA=java -classpath ../dist/gramword.jar
LOAD=$(JAVA) org.teherba.gramword.LoadDict -enc UTF-8 -enc UTF-8 -exp
# DBAT=$(JAVA) org.teherba.dbat.Dbat -e UTF-8
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8
SHIELD=$(JAVA) org.teherba.gramword.ReEncode -s 

all: words names roots suffix xiffus morphs infos

db:
	$(DBAT) "DROP   DATABASE worddb"
	$(DBAT) "CREATE DATABASE 'worddb' DEFAULT CHARACTER SET utf8 COLLATE utf8_bin"
create_ddl:
	sed -e "s/xiffus/words/g"	xiffus_create.sql > words_create.sql
	sed -e "s/xiffus/roots/g"	xiffus_create.sql > roots_create.sql
	sed -e "s/xiffus/suffix/g"	xiffus_create.sql > suffix_create.sql
	sed -e "s/xiffus/forge/g"	xiffus_create.sql > forge_create.sql
	sed -e "s/xiffus/temp/g"	xiffus_create.sql > temp_create.sql
	sed -e "s/xiffus/names/g"	xiffus_create.sql > names_create.sql
	sed -e "s/xiffus/infos/g" -e "/enrel/s/64/1024/" -e "/KEY/s/entry/entry,morph/" xiffus_create.sql > infos_create.sql

infos_create:
	$(DBAT) -f infos_create.sql
words_create:
	$(DBAT) -f words_create.sql
roots_create:
	$(DBAT) -f roots_create.sql
suffix_create:
	$(DBAT) -f suffix_create.sql
xiffus_create:
	$(DBAT) -f xiffus_create.sql
forge_create:
	$(DBAT) -f forge_create.sql
temp_create:
	$(DBAT) -f                     ..####################################################################### ......................................................................................................................................................................................................................................................####################################################################################### .#.... 

	$(DBAT) -f names_create.sql

infos: infos_create infos_bible infos_checkdig
infos_bible:
	cd bible ; make infos
	cd bible/cantata ; make 
	cd bible/perikope ; make
infos_checkdig:
	cd ../../checkdig/test/blz ; make infos

words: words_create load_strong load_special load_common \
		load_ar load_av load_nu load_pn load_pr \
		load_time delete_dass
	$(DBAT) -n words
load_strong:
	$(LOAD) Vb/de.vbconj.dic 		| $(DBAT) -r words
	$(DBAT)   -16 words
load_special:
	$(LOAD) Vb/de.vb_special.dic 	| $(DBAT) -r words
load_common: 
	$(LOAD) de.common.dic 			| $(DBAT) -r words
load_ar:
	$(LOAD) Pn/de.ar.dic			| $(DBAT) -r words
load_pn:
	$(LOAD) Pn/de.pn_pers.dic		| $(DBAT) -r words
	$(LOAD) Pn/de.pn_poss.dic		| $(DBAT) -r words
	$(LOAD) Pn/de.pn_undt.dic		| $(DBAT) -r words
load_pr:
	perl Pr/pr_rootgen.pl | $(LOAD) | $(DBAT) -r words
load_sb:
	$(LOAD) Sb/de.sb_irreg_vb.dic	| $(DBAT) -r words
	$(LOAD) Sb/de.sb_chemelem.dic	| $(DBAT) -r words
	$(LOAD) Sb/de.sb_aj.dic			| $(DBAT) -r words
	$(LOAD) Sb/de.sb_ei.dic			| $(DBAT) -r words
load_nu:
	$(LOAD) Nu/de.nu_words.dic 		| $(DBAT) -r words
load_av: 
	$(LOAD) Av/de.av.dic 			| $(DBAT) -r words
load_time:
	$(LOAD) de.time.dic 			| $(DBAT) -r words
delete_dass:
	$(DBAT) "delete from words where entry like '%dass' and morph like 'ExNrul%'"

names: names_create
	for dic in Nm/*.dic ; do echo $$dic ; $(LOAD) $$dic | $(DBAT) -r names  ; done
	perl Nm/get_names.pl  Nm/prenom1024.srt | $(LOAD) 	| $(DBAT) -r names
	perl Nm/get_names.pl  Nm/surnam1024.srt	| $(LOAD) 	| $(DBAT) -r names
	$(DBAT) -n names

roots: roots_create weak_verbs root_aj root_sb
	$(DBAT) -n roots
weak_verbs: load_roots.pl
	perl load_roots.pl Vb/vbur.ieren.srt 	| $(LOAD) 	| $(DBAT) -r roots
	perl Vb/vbroot.pl -en Vb/vbur.srt \
	| perl load_roots.pl 					| $(LOAD) 	| $(DBAT) -r roots
	perl Vb/vbroot.pl -eln Vb/vbur.srt \
	| perl load_roots.pl 					| $(LOAD)	| $(DBAT) -r roots
	perl Vb/vbroot.pl -ern Vb/vbur.srt \
	| perl load_roots.pl 					| $(LOAD)	| $(DBAT) -r roots
# TODO: what about strong verbs in vbur.srt?
# TODO: what about sein, tun?
root_aj:
	$(LOAD) Aj/de.aj_color.dic 	| $(DBAT) -r roots
	$(LOAD) Aj/de.aj_irreg.dic 	| $(DBAT) -r roots
	$(LOAD) Aj/de.aj_quant.dic 	| $(DBAT) -r roots
	$(LOAD) Aj/de.aj_root.dic 	| $(DBAT) -r roots
root_sb: forge
	$(DBAT) "insert into roots (select entry, morph, '', '' from forge)"
	$(DBAT) -n roots

suffix: suffix_create
	$(LOAD) Sb/sb.suffix.dic 	| $(DBAT) -r suffix
	$(LOAD) Vb/vb.suffix.dic 	| $(DBAT) -r suffix
	$(LOAD) Aj/aj.suffix.dic 	| $(DBAT) -r suffix
	$(LOAD) Av/av.suffix.dic	| $(DBAT) -r suffix
	$(LOAD) Nu/nu.suffix.dic	| $(DBAT) -r suffix
	$(DBAT) -n suffix

xiffus: xiffus_create
	$(LOAD) -rev 0 Sb/sb.suffix.dic	| $(DBAT) -r xiffus
	$(LOAD) -rev 0 Vb/de.vbconj.dic	| $(DBAT) -r xiffus
	$(LOAD) -rev 0 Aj/aj.suffix.dic	| $(DBAT) -r xiffus
	$(LOAD) -rev 0 Av/av.suffix.dic	| $(DBAT) -r xiffus
	$(DBAT) -n xiffus
	
forge:
	make -f forge.mak forge_2_load

morphs:
	rm -f morphs.tmp
	touch morphs.tmp
	$(DBAT) -x "select distinct morph from words"  >> morphs.tmp
	$(DBAT) -x "select distinct morph from roots"  >> morphs.tmp
	$(DBAT) -x "select distinct morph from suffix" >> morphs.tmp
	$(DBAT) -x "select distinct morph from xiffus" >> morphs.tmp
	$(DBAT) -x "select distinct morph from names"  >> morphs.tmp
	$(DBAT) -x "select distinct morel from words"  >> morphs.tmp
	$(DBAT) -x "select distinct morel from roots"  >> morphs.tmp
	$(DBAT) -x "select distinct morel from suffix" >> morphs.tmp
	$(DBAT) -x "select distinct morel from xiffus" >> morphs.tmp
	$(DBAT) -x "select distinct morel from names"  >> morphs.tmp
	sort morphs.tmp | uniq -c \
	| perl morph_codes.pl > morph_codes.lst
