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
# shields (or unshields) the first umlaut
# by putting (removing) a quote at the end of all fields
# @(#) $Id: shield_umlaut.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-07-05: Georg Fischer
#-------------------------------------------------------------------------
use strict;
use utf8;

    my %umlaut = 
            ( 'ä', 'a'
            , 'ö', 'o'
            , 'ü', 'u'
            , 'Ä', 'A'
            , 'Ö', 'O'
            , 'Ü', 'U'
            );
    my %lautum = 
            ( 'a', 'ä'
            , 'o', 'ö'
            , 'u', 'ü'
            , 'A', 'Ä'
            , 'O', 'Ö'
            , 'U', 'Ü'
            );
    my $dir = "sh";
    if ($ARGV[0] =~ m[\A\-u]) {
        $dir = "unsh";
        shift @ARGV;
    }
    my $icol;
    while (<>) {
        s/\r?\n//; # chompr
        my @cols = split (/\t/);
        if ($dir eq "sh") { # shield
            for ($icol = 0; $icol < scalar (@cols); $icol ++) {
                if ($cols[$icol] =~ m[[äöüÄÖÜ]]) {
                    $cols[$icol] =~ s[([äöüÄÖÜ])][$umlaut{$1}]e;
                    $cols[$icol] .= "\:";
                }
            }
        }
        else { # unshield
            for ($icol = 0; $icol < scalar (@cols); $icol ++) {
                if ($cols[$icol] =~ m[\:\Z]) {
                    $cols[$icol] =~ s[([aouAOU])][$lautum{$1}]e;
                    $cols[$icol] =~ s[\:\Z][];
                }
            }
        }
        print join("\t", @cols), "\n";
    }
