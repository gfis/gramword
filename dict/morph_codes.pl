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
# count the used morph codes
# uses UTF-8: äöüÄÖÜß 
# @(#) $Id: morph_codes.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-09-02: Georg Fischer
#-------------------------------------------------------------------------
use strict;

    my %hash;
    while (<>) {
        my ($occur, $morph) = split;
        $morph =~ s/\..*//; # remove semantic details
        $morph =~ s/([A-Z0-9])/\;$1/g;
        foreach my $code (split (/\;/, substr ($morph, 1))) {
            if (! defined ($hash{$code})) {
                $hash{$code}  = $occur;
            }
            else {
                $hash{$code} += $occur;
            }
        } # foreach
        # print "$occur,$morph\n";
    } # while <>
    foreach my $key (sort keys %hash) {
        print sprintf ("%7s %s\n", $hash{$key}, $key);
    } # foreach my $key
__DATA__
     39 SbSgMsVulg
      1 SbSgMsVulgForg.Lt
     89 SbSgMsZool
      1 SbSgMsZoolForg.En
      1 SbSgMt
    218 SbSgNt
      1 SbSgNtAbbr
     13 SbSgNtBody
      1 SbSgNtBodyDialDimt
      6 SbSgNtBota
      1 SbSgNtCUrrForg.Us
      7 SbSgNtChem
      1 SbSgNtClthForg
      1 SbSgNtClthForg.En
      1 SbSgNtDa
      2 SbSgNtDial
    221 SbSgNtDimt
     24 SbSgNtDimtBody
      7 SbSgNtDimtBota
      6 SbSgNtDimtDial
      2 SbSgNtDimtMeto
      1 SbSgNtDimtMilt
     14 SbSgNtDimtNutr
