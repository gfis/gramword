#!/usr/bin/perl

# sum occurrences of individual words
# 2013-03-03: corrected (Las Palmas)
# 2004-07-05: Georg Fischer
# precondition:
# 	file must be sorted by 2nd field
# activation:
# 	sort a b | uniq -c | sort -k 2 | perl sumocc.pl > ...
#-----------------------------------------------------------
use strict;

	my ($sum, $old) = (0, "");
	while (<>) {
		s[\r?\n][];
		s{\A\s+}{}; # ltrim
		s{\s+\Z}{}; # rtrim
		my ($nocc, $new) = split(/\s+/, $_, 2);
		if ($new eq $old) {
			$sum += $nocc;
		} else { # $new ne $old
			if ($sum > 0) {
				print sprintf("%7d\t%s\n", $sum, $old);
			}
			$sum = $nocc;
			$old = $new;
		}
	} # while <>
	if ($sum > 0) {
		print sprintf("%7d\t%s\n", $sum, $old);
	}

__DATA__
      1	ueppigster	ueppigster
      1	uer	uer
      1	uer	uer
      1	uer
      3	uer
      1	uerk
      1	uernberg
      1	uerzlich
      1	uerzlich
      1	ueterbog
