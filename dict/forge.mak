#!/usr/bin/make

# @(#) $Id: forge.mak 807 2011-09-20 16:54:21Z gfis $
# 2011-09-20: dbat.jar separately
# 2007-02-01: no org.punctum
# 2007-01-04: Dbat
# 2006-06-05, Georg Fischer

JAVA=java -classpath "../dist/gramword.jar"
LOAD=$(JAVA) org.teherba.gramword.LoadDict -enc UTF-8 -enc UTF-8 -exp
# DBAT=$(JAVA) org.teherba.dbat.Dbat -e UTF-8
DBAT=java -classpath ~/work/gits/dbat/dist/dbat.jar org.teherba.dbat.Dbat -c worddb -e UTF-8
SHIELD=$(JAVA) org.teherba.gramword.ReEncode -s 

load_sb: temp_create forge_create load_forge
	$(DBAT) -n forge
forge_load: 
	$(DBAT) -f temp_create.sql
	$(DBAT) -f forge_create.sql
	cat Sb/duden.raw \
	| $(JAVA) org.teherba.gramword.LoadDict -enc UTF-8 \
	| $(DBAT) -r forge
forge_clean:
	$(DBAT) -f temp_create.sql
	$(DBAT) "update forge set morph = 'xx', enrel = '', morel = ''";
forge_rest:
	$(DBAT) "select * from forge where morph = 'xx' order by 1" | less
forge_eval:
	perl forge_eval.pl
forge_count:
	$(DBAT) "SELECT count(*) FROM forge WHERE morph =  'xx'"
	$(DBAT) "SELECT count(*) FROM forge WHERE morph <> 'xx'"
repeat:
	rm -f *.man
	$(DBAT) "update forge set morph = 'xx', enrel = '', morel = ''";
	# $(DBAT) "delete from temp";
	perl forge_eval.pl
forge_verb1:
	$(DBAT) "delete from temp"
	cut -f 1 Vb/vbur.srt | $(LOAD) | sed -e "s/$$/	VbInWeak/" > x.tmp
	$(JAVA) org.teherba.gramword.ReEncode -e UTF-8 -s x.tmp \
	| $(DBAT) -r temp	
forge_verb2:
	$(DBAT) "delete from temp"
	$(DBAT) -r temp < Sb/sb_irreg_vb.txt
	$(DBAT) -300 temp | less
forge_insert_enrel:
	$(DBAT) -f forge_create.sql
	$(DBAT) -r forge < forge.man.raw
	$(DBAT) -f temp_create.sql
	$(DBAT) "insert into temp (select enrel, morel, '','' from forge where length(enrel) > 0 and length(morel) > 0)"
	$(DBAT) "delete from forge where entry in (select entry from temp)"
	$(DBAT) "insert into forge (select * from temp)"
	$(DBAT) -n  forge
forge_2_load:
	$(DBAT) -f forge_create.sql
	$(JAVA) org.teherba.gramword.ReEncode -e UTF-8 -u Sb/de.sb_forge.dic \
	| $(JAVA) org.teherba.gramword.LoadDict -enc UTF-8 \
	| $(DBAT) -r forge
	$(DBAT) -f temp_create.sql
	$(DBAT) "insert into temp (select distinct enrel, morel, '','' from forge where length(enrel) > 0 and length(morel) > 0)"
	$(DBAT) "delete from forge where (entry, morph) in (select entry, morph from temp)"
	$(DBAT) "insert into forge (select * from temp)"
	$(DBAT) "delete from forge where substr(morph, 1, 2) not in ('Sb', 'Nm', 'Ex')"
	$(DBAT) -n  forge
sb_load:
	$(DBAT) "insert into roots (select entry, morph, enrel, morel from forge)"

load_man:
	$(DBAT) -f forge_create.sql
	$(DBAT) -r forge < forge.2.man
	find Sb -iname "*.man" | xargs -l perl load_man.pl 
dupl:
	$(DBAT) "select count(entry), entry from forge group by entry order by 1, 2" \
	| grep -E "2|3" | cut -f 2 | tr "\r" "\t" > forge.dupl.tmp
	grep -Hrf forge.dupl.tmp *.man Sb/*.man \
	| sed -e "s/.man:/.man	/" | sort -k 2 | less
diff_man:
	$(DBAT) -f forge_create.sql
	$(DBAT) -r forge < forge.2.man
	grep quatsch makefile > temp.tmp
	find Sb -iname "*.man" | xargs -l -ißß cat ßß >> temp.tmp
	$(DBAT) -f temp_create.sql
	$(DBAT) -r temp < temp.tmp
	$(DBAT) "select * from temp where entry not in (select entry from forge)"
