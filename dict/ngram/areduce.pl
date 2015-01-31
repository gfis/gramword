#!/usr/bin/perl

# reduce.pl - grep words after 1945 only
# @(#) $Id: vbconj.pl 36 2008-09-08 06:05:06Z gfis $
# 2013-02-04, Dr. Georg Fischer
#
#-------------------------------------------------------------------------
use strict;

	while (<>) {
		my ($word, $year, $count, $books) = split;
		next if $year < 1945;
		$word =~ s{_[A-Z]+\Z}{}; # remove word class
		$word =~ s{\d.*}{}; # remove digits and anything behind
		if ((length($word) > 0) 
				and ($word !~ m{[\.\/\'\-\_\!\,\>\:]}) 
		     	and ($word !~ m{\A[A-Z][A-Z]})
		     	and ($word !~ m{\A[a-z].*[A-Z]})
		   		) {
			print "$word\t$count\n";	
		}
	} # while

__DATA__
Quarzphyllit_NOUN       2006    8       3
Quarzphyllit_NOUN       2007    3       1
Quarzphyllit_NOUN       2008    1       1
Quarzphyllit_NOUN       2009    9       1
Quarzsaud_NOUN  1837    1       1
Quarzsaud_NOUN  1852    2       2
Quarzsaud_NOUN  1853    1       1
Quarzsaud_NOUN  1854    1       1
Quarzsaud_NOUN  1855    1       1
