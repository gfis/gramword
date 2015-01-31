#!/usr/bin/perl

#
#  Copyright 2006 Dr. Georg Fischer <punctum at punctum dot kom>
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#       http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
# evaluate words in TEMP table
# find pairs of correlated words
# manually edit the extracted list
# store their grammatical meaning
# @(#) $Id: eval_pairs.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-01-04: Dbat
# 2006-06-05: Georg Fischer
#-------------------------------------------------------------------------
use strict;

    $, = ""; # paragraph mode
    # binmode(STDIN , ":utf8");
    # binmode(STDOUT, ":utf8");
    my $DBAT = "java -classpath ../dist/gramword.jar;../lib/mysql.jar;../lib/dbat.jar"
            . " org.teherba.dbat.Dbat -e UTF-8";
    
    while (<DATA>) {
        s/\r?\n//; # chompr
        # my ($outfile, $pat1, $pat2) = split(/\t/);
        & read_table ($_);
    }
    
sub read_table {
    my ($block) = @_;
    $block =~ s[\r?\n][ ]g;
    my ($outfile, $from, $pstmt) = split (/\;/, $block);
    $outfile .= ".man";
    my %hash;
    my $cmd = "$DBAT \"SELECT a.entry, b.entry FROM $from\";
    foreach my $line (split (/\r?\n/, `$cmd`)) {
        my @cols = split (/\t/, $line);
        eval ($pstmt);
    } # foreach
}
sub dummy {
        print join ("\t", @cols), "\n";
        $hash{$cols[0]} = join(",", splice(@cols, 1));
    foreach my $entry (keys %hash) {
        if ($entry =~ m[$entrypat]) {
            my $line = $entry;
            # $line=~s/$entrypat/$1$2\=SbNDim\,$1/;
            eval("\$line=~s/\$entrypat/" . $outputpat . "/;");
            # print $entry, "\t", $hash{$entry}, "\n";
            print "$line\n";
        }
    }
    # print STDERR "$entrypat\t$outputpat\n";
}

__DATA__
chen;
temp a, temp b WHERE a.entry = concat(b.entry, 'chen');
print "$cols[0]\t=SbN5XDim,$cols[1]\n";
