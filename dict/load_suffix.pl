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
# suffixes of words and their grammtical type
# uses UTF-8: äöüÄÖÜß 
# @(#) $Id: load_suffix.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-06-07: Georg Fischer
#-------------------------------------------------------------------------
use strict;

    binmode(STDIN , ":utf8");
    binmode(STDOUT, ":utf8");
    my $lang = "de";
    while (<>) {
        next if m/^\#/ || m/^\s*$/; # skip comments and empty lines
        if (m/^\%/) { # processing instruction
            if (m/^\%lang\=(.+)$/) {
                $lang = $1;
            }
        }
        else { # suffix entry with morpholgy
            s/\s//g;
            s/\=/\,/;
            if (m/^\,/) {
                $_ = "-" . $_;
            }
            my ($entry, $morph, $descr) = split (/\,/);
            print STDOUT "$entry\t$morph\t$descr\n";
        } # entry with morphology
    } # while <>
    
__DATA__
%lang=de
elnd     = Ajg
# participe
ent      = Ajp
ert      = Ajp
elt      = Ajp
# adverbs
erweise  = Av
bar      = Av

# senden, reiten
en         =VbInXX,en
e          =VbPr11,en
est        =VbPr12,en
et         =VbPr13,en
en         =VbPr91,en
et         =VbPr92,en
en         =VbPr93,en
