#!/usr/bin/perl

# expand condensed verb lists vbur.*.srt
# @(#) $Id: vbur.srt 975 2013-01-24 07:51:40Z gfis $
# caution, this file must be stored in UTF-8: äöüÄÖÜß
# 2013-01-25: Georg Fischer
#

use strict;

	my $suffix = "";
	if ($ARGV[0] =~ m{\A\-s}) {
		shift(@ARGV);
		$suffix = shift(@ARGV);
	}
	
	while (<>) {
		my $ch1 = ord(substr($_, 0, 1));
		if ($ch1 >= ord('a')) {
			s/\s+\Z//;
			my $line = $_;
			my @parts = split(/\s+/, $line);
			my $verb = shift(@parts);
			foreach my $part (@parts) {
				$part =~ s{[\-\/]}{}g;
				print "$part$verb$suffix\n";
			} # foreach $part
		} # letter, äöü
	} # while <>
__DATA__
%lang=de
aalen	/
aasen	/ ver-
# abenteuern	/
flauen	ab/
kanzeln	ab/
magern	ab/
nabeln	ab/
schotten	ab/
specken	ab/
# absträngen	/
wracken	ab/
achten	/ be- be-ob- be-gut/ er- miss/ ver-
ackern	/ be- durch/ um/
adeln	/
ahnden	/
ahnen	/ er-
