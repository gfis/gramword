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
# @(#) $Id: eval_join.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-01-04: Dbat
# 2006-06-05: Georg Fischer
#-------------------------------------------------------------------------
use strict;

    $/ = ""; # paragraph mode
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
    my $cmd;
    $block =~ s[\r?\n][ ]g;
    my ($outfile, $sql, $pstmt) = split (/\;/, $block);
    return if $outfile =~ m[\#]; # block is commented out
    $outfile .= ".man";
    if (-r $outfile) { 
        # outfile exists (was probably already edited)
    }
    else { # create new outfile
        $cmd = "$DBAT -x \"$sql\"";
        # print $cmd, "\n";
        open (OUT, ">", $outfile) || die "$0: cannot create \"$outfile\"\n";
        foreach my $line (split (/\r?\n/, `$cmd`)) {
            my @cols = split (/\t/, $line);
            eval ($pstmt);
        } # foreach
        close (OUT);
    }
    # print `vim $outfile`;
    print `$DBAT -f temp_create.sql`;
    print `cat $outfile | $DBAT -r temp`;
    print `$DBAT \"DELETE FROM forge WHERE entry in (SELECT entry FROM temp)\"`;
    print `$DBAT \"INSERT INTO forge (SELECT * FROM temp)\"`;
} # sub read_table

__DATA__
chen;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(b.entry, 'chen')
;
print OUT "$cols[0]\tSbN5XDim,$cols[1]\n";

# chenum;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(b.entry, 'chen', ':')
;
print OUT "$cols[0]\tSbN5XDim,$cols[1]\n";

# echenum;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(substring(b.entry, 1, length(b.entry) - 1), 'chen', ':')
  AND substring(b.entry, length(b.entry), 1) = 'e'
;
print OUT "$cols[0]\tSbN5XDim,$cols[1]\n";

# enchenum;
SELECT a.entry, b.entry FROM forge a, forge b 
WHERE a.entry = concat(substring(b.entry, 1, length(b.entry) - 2), 'chen', ':')
  AND substring(b.entry, length(b.entry) - 1, 2) = 'en'
;
print OUT "$cols[0]\tSbN5XDim,$cols[1]\n";

