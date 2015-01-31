# makefile - for substantives
# @(#) $Id: makefile 36 2008-09-08 06:05:06Z gfis $
# 2006-06-26, Georg Fischer <punctum@punctum.com>

JAVA=java -classpath "../../dist/gramword.jar;../../lib/mysql.jar"
SHIELD=$(JAVA) org.teherba.gramword.ReEncode -s 
MORPH=../../../../../pt/natlan/morph

all: \
	de.sb_irreg_vb.dic \
	de.sb_chemelem.dic
	
de.sb_irreg_vb.dic: makefile sb_irreg_vb.pl
	perl sb_irreg_vb.pl \
	| grep -vE "^(Be|Emp|Ge|Ver)" \
	| $(SHIELD) -e UTF-8 > $@
de.sb_chemelem.dic: makefile de.sb_chemelem.pl
	perl de.sb_chemelem.pl \
	| $(SHIELD) -e UTF-8 > $@

raw: duden.raw 8multi.raw 

8multi.raw: makefile ../grep_roots.pl
	perl ../grep_roots.pl $(MORPH)/8multi/gt1.tmp \
	| cut -f 3 \
	| sed -e "s/$$/	=xx/" \
	| $(SHIELD) > $@
mini.raw:
	perl $(MORPH)/filter_sb1.pl -o x1.tmp $(MORPH)/8multi/combine2.tmp  > x2.tmp
	cut -f 3 x1.tmp \
	| sed -e "s/$$/	=xx/" \
	| $(SHIELD) > $@
zeit.raw:
	perl $(MORPH)/filter_sb1.pl -o x1.tmp $(MORPH)/zeit/combine2.tmp    > x2.tmp
	cut -f 3 x1.tmp \
	| sed -e "s/$$/	=xx/" \
	| $(SHIELD) > $@
duden.raw:
	perl $(MORPH)/filter_sb1.pl -o x1.tmp $(MORPH)/duden/combine2.tmp   > x2.tmp
	cut -f 3 x1.tmp \
	| sed -e "s/$$/	=xx/" \
	| $(SHIELD) > $@
	
schaft:
	perl $(MORPH)/filter_re.pl -e "schaft\Z" -o x1.tmp $(MORPH)/8multi/combine2.tmp  > x2.tmp
	less x1.tmp
vier:
	perl $(MORPH)/filter_re.pl -e "\Avier" -o x1.tmp $(MORPH)/8multi/combine2.tmp  > x2.tmp
	less x1.tmp
zwei:
	perl $(MORPH)/filter_re.pl -e "\Azwei.+ig" -o x1.tmp $(MORPH)/8multi/combine2.tmp  > x2.tmp
	less x1.tmp
drei:
	perl $(MORPH)/filter_re.pl -e "\Adrei" -o x1.tmp $(MORPH)/8multi/combine2.tmp  > x2.tmp
	less x1.tmp
acht:
	perl $(MORPH)/filter_re.pl -e "\Aacht.+ig" -o x1.tmp $(MORPH)/8multi/combine2.tmp  > x2.tmp
	less x1.tmp

in:
	perl $(MORPH)/filter_re.pl -e "in\\Z" -o x1.tmp $(MORPH)/duden/combine2.tmp  > x2.tmp
	less x1.tmp
	wc   x1.tmp
ee:
	perl $(MORPH)/filter_re.pl -e "ee\\Z" -o x1.tmp $(MORPH)/duden/combine2.tmp  > x2.tmp
	less x1.tmp 
	wc   x1.tmp
ei:
	perl $(MORPH)/filter_re.pl -e "ei\\Z" -o x1.tmp $(MORPH)/duden/combine2.tmp  > x2.tmp
	cat x1.tmp | grep -v frei | grep -v erlei | less
	wc   x1.tmp
8x:
	grep -E "G.rten	" $(MORPH)/8multi/gt1.tmp
y:
	grep -i y $(MORPH)/8multi/gt1.tmp
o:
	grep -E ".*o	" 8multi.raw | sort
a:
	grep -E ".*a	" 8multi.raw | sort
i:
	grep -E ".*i	" 8multi.raw | sort
