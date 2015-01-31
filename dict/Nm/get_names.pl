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
# convert output of `sort -rn | uniq -c` into "dic" format
# UTF-8: ‰ˆ¸ƒ÷‹ﬂ
# @(#) $Id: get_names.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-08-13: new codes, and UTF-8 output
# 2006-06-03, Georg Fischer
#
# surname (Surn) if gender is missing, 
# christian name (Pren) if gender is present
#-------------------------------------------------------------------------
use strict;

    # binmode(STDIN , ":utf8");
    binmode(STDOUT, ":utf8");

    while (<>) {
        next if m/^\s*$/ || m/^\#/;
        my $position = "Pren";
        my $gender = "";
        my ($count, $name, $gender) = split;
        if (0) {
        } elsif ($gender eq "") {
            $gender = "";
            $position = "Surn";
        } elsif ($gender =~ m/f/i) {
            $gender = "Fm";
        } elsif ($gender =~ m/m/i) {
            $gender = "Ms";
        } elsif ($gender =~ m/x/i) {
            $gender = "Un";
        }
        print "$name\t=NmPers$position$gender\n";
    } # while
