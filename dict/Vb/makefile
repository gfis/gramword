# makefile - conjugate irregular verbs
# @(#) $Id: makefile 976 2013-02-02 16:44:18Z gfis $
# 2013-03-03: gather verbs from various sources
# 2006-05-28: UTF-8
# 2003-11-05: imm; problem with glimmen/klimmen in vbexpand.pl
# 2001-04-16, Georg Fischer <punctum@punctum.com>

all: gather ngram1 ding1 duden1

gather:
	find ../gutenberg.de ../karl-may ../leipzig ../ngram ../taz ../wikidump ../zeit -iname "verbs.*" \
	| xargs -l cut -f 1 \
	| sort | uniq -c > verbs.gather.tmp
	wc verbs.gather.tmp
ngram1:
	cut -f 1 ../ngram/check.*.tmp \
	| sed -e "s/^/      1\t/" \
	> ngram1.tmp
ding1:
	cut -f 1 ../ding/ding.verbs.tmp \
	| sed -e "s/^/    500\t/" \
	> ding1.tmp
duden1:
	cut -f 1 ../duden/duden.verbs.tmp \
	| sed -e "s/^/    100\t/" > duden1.tmp
	sort -k 2 duden1.tmp ding1.tmp ngram1.tmp verbs.gather.tmp > duden2.tmp
	perl sumocc.pl duden2.tmp > duden3.tmp
	grep 100 duden3.tmp | wc
	grep 100 duden3.tmp > duden.only.tmp
# de.vbconj.dic elrn

de.vbconj.dic: vbconj.pl verbform.de.html makefile
	perl vbconj.pl de verbform.de.html > $@
	wc $@
verbform.de.html: vbexpand.pl irverb.de.utf8 makefile
	perl vbexpand.pl de irverb.de.utf8 > $@
#	perl vbexpand.pl de irverb.de.utf8 | grep -vEf ir.weak.grep > $@

# extract roots of weak verbs
elrn: en.tmp eln.tmp ern.tmp
en.tmp:  vbroot.pl      vbur.srt
	perl vbroot.pl -en  vbur.srt > $@
eln.tmp: vbroot.pl      vbur.srt
	perl vbroot.pl -eln vbur.srt > $@
ern.tmp: vbroot.pl      vbur.srt
	perl vbroot.pl -ern vbur.srt > $@

clean:
	rm -f *.tmp *.bak
	rm -f *.html de.vbconj.dic
#---------------------------
linear:
	rm -f verbs.tmp
	perl linear_vbur.pl          vbur.srt 		    >> verbs.tmp
	perl linear_vbur.pl -s ieren vbur.ieren.srt 	>> verbs.tmp
	sort verbs.tmp > verbs.srt
	wc verbs.srt
#---------------------------
	