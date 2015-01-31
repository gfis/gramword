#!/usr/bin/perl

# German adjectives related to quantities and designations,
# some which have no comparative or superlative, 
# and some which are superlatives
# @(#) $Id: aj_quant.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-07-18: 4 fields
# 2006-06-23, Georg Fischer
# caution, stored in UTF-8 encoding: äöüÄÖÜß, output in UTF-8

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

# conjugations:
# dies      =AjN1M
# diese     =AjN1F
# dies      =AjN1N
# dieses    =AjG1M
# dieser    =AjG1F
# dieses    =AjG1N
# diesem    =AjD1M
# dieser    =AjD1F
# diesem    =AjD1N
# diesen    =AjA1M
# diese     =AjA1F
# dies      =AjA1N

use strict;
    
    # binmode(STDOUT, ":utf8");
    while (<DATA>) {
        next if m/^\#/;
        next if m/^\s*$/;
        my ($aj) = split;
        if ($aj !~ m/e$/) { 
            print "$aj\t=AjQant,\n"; # print valid form without "-e" 
        }
        else {
            $aj =~ s/e$//; # remove "-e", but this is not valid
        }
        # declinate them through
        for my $end (("e", "em", "en", "er", "es")) {
            print "$aj$end\t=AjQant,$aj,AjRtQant\n";
        }
    } # while DATA

__DATA__
# no comparative, superlative
manch
solch
welch
# ein
erst
einzeln
kein
# but: in keinster Weise
dies
einzig
gleich
tot
ganz
halb
optimal
maximal
bestimmt
einfach
vielfach
mehrfach
mannigfach
# normally not without -e:
alle
jede
jene
andere
beide
einige
weitere
erste
letzte
selbige
mehrere
