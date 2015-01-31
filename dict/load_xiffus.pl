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
# reversed suffixes of words and their grammtical type 
# @(#) $Id: load_xiffus.pl 36 2008-09-08 06:05:06Z gfis $
# must be stored in UTF-8: äöüÄÖÜß
# 2006-06-13: Georg Fischer
#-------------------------------------------------------------------------
use strict;
# use utf8;

    # binmode(STDIN , ":utf8");
    # binmode(STDOUT, ":utf8");
    print STDOUT "# must be stored in UTF-8 äöüÄÖÜß\n";
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
            $entry = & my_reverse ($entry);
            $entry =~ s/\xa4\xc3/\xc3\xa4/g; # ä
            $entry =~ s/\xb6\xc3/\xc3\xb6/g; # ö
            $entry =~ s/\xbc\xc3/\xc3\xbc/g; # ü
            $entry =~ s/\x84\xc3/\xc3\x84/g; # Ä
            $entry =~ s/\x96\xc3/\xc3\x96/g; # Ö
            $entry =~ s/\x9c\xc3/\xc3\x9c/g; # Ü
            $entry =~ s/\x9f\xc3/\xc3\x9f/g; # ß
            print STDOUT "$entry\t$morph\t$descr\n";
        } # entry with morphology
    } # while <>
    
sub my_reverse {
    my ($word) = @_;
    return join ("", reverse (split (/ */, $word)));
}
__DATA__
%lang=de
elnd     =Ajg
# participe
ent      =Ajp
ert      =Ajp
elt      =Ajp
# adverbs
erweise  =Av
bar      =Av
verlösche  =VbSCt13,verlöschen
verlöschen =VbSCt91,verlöschen
verlöscht  =VbSCt92,verlöschen
verlöschen =VbSCt93,verlöschen
vermaßen   =VbSIn0,vermaßen
vermaße    =VbSPr11,vermaßen
vermaßst   =VbSPr12,vermaßen
vermaßst   =VbSPr13,vermaßen
