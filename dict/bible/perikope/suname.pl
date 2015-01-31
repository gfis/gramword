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
# read all Sunday names from de.wikipedia page
# @(#) $Id: suname.pl 36 2008-09-08 06:05:06Z gfis $
# 2007-03-05, Dr. Georg Fischer <punctum@punctum.com>

use strict;
    
    while (<>) {
        if (m/\'\'\'([^\']+)\'\'\'/) {
            my $suname = $1;
            my $code = "";
            my $num = "";
            if ($suname =~ m/(\d+)/) {
                $num = $1;
            }
            $code = "epi$num"   if $suname =~ m/Epipha/;
            $code = "trin$num"  if $suname =~ m/Trinitatis/;
            $code = "adv$num"   if $suname =~ m/Advent/;
            $code = "xmas$num"  if $suname =~ m/Christfest/;
            $code = "lent$num"  if $suname =~ m/Passionszeit/;
            $code = "east$num"  if $suname =~ m/nach Ostern/;
            my $sushort = $suname;
            $sushort =~ s/\:.+//;
            $sushort =~ s/Trinitatis/Trin./;
            $sushort =~ s/Epiphanias/Epiph./;
            $sushort =~ s/ Sonntag/ So./;
            $sushort =~ s/ nach /n./;
            $sushort =~ s/ Sonntag nach /So.n./;
            print "$code;$sushort;$suname;\n";
        }
    } # while <>
