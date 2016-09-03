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

# vbroot.pl - extract roots of German verbs with specified infinitive ending
# @(#) $Id: vbroot.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-07-18: expanded morphems
# 2006-06-05, Georg Fischer
#
# activation:
#    perl vbroot.pl [-en|-ern|-eln|-ieren] verbs.lst > en.tmp
#-------------------------------------------------------------------------
use strict;

    # binmode(STDIN , ":utf8");
    # binmode(STDOUT, ":utf8");
    my $opt = "en";
    if ($ARGV[0] =~ m/^\-/) {
        $opt = substr (shift (@ARGV), 1); # e.g. "en"
    }
    print "# generated by perl vbroot.pl -$opt " . join (" ", @ARGV) . "\n";
    print "%morph=VbRtWeak,$opt\n";
    while (<>) { # process input lines
        if (! m/^#/ && ! m/^\s*\Z/) { # line is non-comment, non-empty
            if (s/^(.+)$opt\t/$1\t/) {
                print;
            }
        } # non-comment
    } # while <>

__DATA__
%lang=de
aalen   -
aasen   - ver-
# abenteuern    -
abflauen    -
abkanzeln   -
abmagern    -
abnabeln    -
abschotten  -
abspecken   -
# absträngen   -
abwracken   -
achten  - be- er- miss- ver-
ackern  - be- durch- um-
adeln   -