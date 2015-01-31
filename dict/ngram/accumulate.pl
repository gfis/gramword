#!/usr/bin/perl

# accumulate.pl - accumulate words after 1945 only
# @(#) $Id: vbconj.pl 36 2008-09-08 06:05:06Z gfis $
# 2013-02-04, Dr. Georg Fischer
#
#-------------------------------------------------------------------------
use strict;

	my $old_word  = "";
	my $old_count = 0;
	while (<>) {
		# print "debug: $old_word $old_count, new line: $_";
		my ($word, $count) = split;
		if ($word ne $old_word) {
			if ($old_word ne "") {
				&output();
			}
			$old_word = $word;
		} # group change
		$old_count += $count;
	} # while
	&output();

sub output {
	print "$old_word\t$old_count\n";
	$old_count = 0;
} # output

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
