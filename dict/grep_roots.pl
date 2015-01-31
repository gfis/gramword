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
#------------------------------------------------------------
# Filter all substantives with 1 vowel sequence in the root,
# possibly ending with -e, -es, -en, -el, -er
# 2006-07-03, Dr. Georg Fischer <punctum@punctum.com>: copied from file_sb_end.pl
# activation:
#   perl filter_sb1.pl -o filter.tmp input > pass.tmp
#------------------------------------------------------------
use strict;
use locale;

# global variables
    my $filter_count = 0;
    my $pass_count = 0;
    my $colnorm = 1;
    my $debug = 0;
    my @new_row; # elements of rows, separated by \t
    
# evaluate arguments
    while (scalar @ARGV > 0 && ($ARGV[0] =~ m[\-])) {
        my $opt = shift (@ARGV);
        if (0) {}
        elsif ($opt =~ m[o]) {
        }
        elsif ($opt =~ m[t(est)?]) {
            $debug = 1;
        }
    } # while options   

# input loop - grep words
    while (<>) {
        s[\r?\n][]; # chompr
        @new_row = split(/\t/);
        my $word = $new_row[$colnorm + 1];
        my $found = "";
        if (($word) eq (lc $word)) {
            # no uppercase word
        }
        else {
            my $root = $new_row[$colnorm];
            $root =~ s[(es?|ens?|el[ns]?|er[ns]?)\Z][];
            if ($root =~ m[y]) { # ignore foreign words
            }
            elsif (($root =~ s[(aa|aeu?|ai|au|ee|ei|eu|ie|oe|ue|[aeiou])][\#]g) == 1) {
                $found = 1;
            }
        }
        if ($found ne "") {
            $filter_count ++;
            print $word, "\n";
        }   
        else {
            $pass_count ++;
        }
    } # while <>

    print STDERR sprintf ("%7d lines passed\n", $pass_count);
    print STDERR sprintf ("%7d lines filtered\n", $filter_count);
    