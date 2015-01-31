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

# prepare for raw db table loading of
# roots of words and grammatical type 
# @(#) $Id: load_roots.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-07-18: with enrel, morel 
# 2006-06-05, Georg Fischer
#-------------------------------------------------------------------------
use strict;

    # binmode(STDIN , ":utf8");
    # binmode(STDOUT, ":utf8");
    my $morph = "VbW";
    my $infend = "en";
    my $suffix = "";
    my $prefix = "";
    my @parts;
    while (<>) {
        next if m/^\#/ || m/^\s*$/; # skip comments and empty lines
        if (m/^\%/) { # processing instruction
            if (m/^\%morph\=(\w+)\,(.+)$/) {
                $morph = $1;
                $infend = $2;
            }
        }
        else { # root entry with optional prefixes
            s/\s*$//;
            @parts = split;
            my $ipart = 0;
            my $root = $parts[$ipart ++];
            if ($parts[$ipart] eq "-") { # root without prefix
                $prefix = $parts[$ipart ++];
                $prefix =~ s/\-//g;
                print "$prefix$root\t$morph\t$infend\tVbIn\n";
            } # without prefix
            while ($ipart < scalar(@parts)) { # all prefixes
                $prefix = $parts[$ipart ++];
                $prefix =~ s/\-//g;
                print "$prefix$root\t$morph\t$infend\tVbIn\n";
            } # while all prefixes
        } # root entry with optional prefixes
    } # while <>
__DATA__
# German verbs ending with "-ieren"
# @(#) $Id: load_roots.pl 36 2008-09-08 06:05:06Z gfis $
# caution, this file must be stored in UTF-8: äöüÄÖÜß
# 2006-06-05: without fieren, frieren, gieren ..., but with urgieren
# 2006-06-03, Georg Fischer: manually checked
#
%morph=VbW,ieren
abandonn    -
abbrevi -
abdiz   -
abduz   -
abonn   -
abort   -
absent  -
absorb  -
abstrah -
# abv   -
adapt   -
add - auf-
addiz   -
adhär  -
adjudiz -
adjust  -
administr   -
adopt   -
ador    -
# adrem -
adress  - um-
adsorb  -
adstring    -
affin   -
affiz   -
agglomer    -
# ...
