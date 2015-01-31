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
# check books from nordelbien.de/glaube
# 2007-02-07, Dr. Georg Fischer <punctum@punctum.com>: Dorothea = 97

use strict;

    my $file = "nordelbien.txt";
    open (IN, "<", $file) || die "cannot read \"$file\"";
    while (<IN>) {
        if (m/\/buch\/(.*)/) {
            my $rest = $1;
            print $rest, "\n";
        }
    } # while IN
__DATA__
1. Advent   1   #ff00aa violett <a href="http://bibel-online.net/buch/40.matthaeus/21.html#21,1">Mt 21,1-9</a>
1. Advent   2   #ff00aa violett <a href="http://bibel-online.net/buch/45.roemer/13.html#13,8">Röm 13,8-12(14)</a>
1. Advent   3   #ff00aa violett <a href="http://bibel-online.net/buch/24.jeremia/23.html#23,5">Jer 23,5-8</a>
1. Advent   4   #ff00aa violett <a href="http://bibel-online.net/buch/66.offenbarung/5.html#5,1">Offb 5,1-5(14)</a>
