#!/usr/bin/perl

# replace CSS class= by color= background=, and morph= by title=
# @(#) $Id$
# Copyright (c) 2016 Dr. Georg Fischer <punctum@punctum.com>
# 2006-04-21: copied from client.pl
#
# Usage:
#   perl web/unclass.pl web/wordtype.html
#------------------------------------------------------------------
#
#  Copyright 2016 Dr. Georg Fischer <punctum at punctum dot kom>
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
#------------------------------------------------------------------

use strict;
    my %hash = ();
    open(ALL, "<", "all.css");
    while (<ALL>) {
        #.Ab { color:white    ; background:goldenrod  }
        #.Aj { color:black    ; background:lightblue  }
        s/\s+\Z//; # chompr
        if (m[^\s*\.(\w+)\s*\{\s*color\s*\:\s*(\w+)\s*\;\s*background(\-color)?\s*\:\s*(\w+)]) { # ]) {
            my $class      = $1;
            my $color      = $2;
            my $background = $4;
            $hash{$class} = "$color:$background";
            # print "$class = $hash{$class}\n";
        } # if
    } # while <ALL>

    while (<>) {
        s/\s+\Z//; # chompr
        my $line = $_;
        while ($line =~ m{\<span class=\"(\w+)\" morph=\"(\w*)\"\>}) {
            my $class = $1;
            my $morph = $2;
            my ($color, $background) = split(/\:/, $hash{$class});
            $line =~    s{\<span class=\"(\w+)\" morph=\"(\w*)\"\>}
                         {\<span style=\"color:$color;background:$background\" title=\"$morph\"\>};
        } # while <>
        print "$line\n";
    } # while <ALL>
__DATA__
<span class="Pr" morph="">Nachdem</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Aj" morph="Qant">alle</span> <span class="Aj" morph="Qant">diese</span> <span class="Sb" morph="Pl">Vorkehrungen</span> <span class="Vb" morph="SPa0">getroffen</span>, <span class="Vb" morph="SIp11">wollte</span> <span class="Pn" morph="SgPersNomvMs3">er</span> <span class="Un" morph="">nicht</span>
<span class="Aj" morph="Cmpr">länger</span> <span class="Vb" morph="SIn0">warten</span>, <span class="Vb" morph="SIn0">sein</span> <span class="Vb" morph="SCs93">Vorhaben</span> <span class="Pr" morph="Shor">ins</span> <span class="Sb" morph="SgNt">Werk</span> <span class="Pr" morph="Prim">zu</span> setzen; <span class="Pn" morph="SgPersNomvNt3">es</span> drängte <span class="Pn" morph="SgPersAccv3Ms">ihn</span>
