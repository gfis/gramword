# makefile - for adjectives
# @(#) $Id: makefile 36 2008-09-08 06:05:06Z gfis $
# 2006-06-24, Georg Fischer <punctum@punctum.com>

all: root color quant irreg suffix
	wc *.dic

root:
	perl aj_rootgen.pl  | sort > de.aj_root.dic
color:
	perl aj_color.pl | sort > de.aj_color.dic
quant:
	perl aj_quant.pl > de.aj_quant.dic
irreg:
	perl aj_irreg.pl > de.aj_irreg.dic
	
# "multiply" all typical adjective endings 
# with the declination endings 
# through gender, case, positive, comparative and superlative
suffix:
	perl ../crossproduct.pl aj.suffix_1.dic aj.decline.dic > aj.suffix.dic

wiki_no_more:
	perl aj_rootgen.pl  | sort | tr -d "\r" | tr "\n" " " > aj_wiki.txt
	
		