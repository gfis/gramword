# German adjectives with irregular comparative and/or superlative
# @(#) $Id: aj_irreg.pl 36 2008-09-08 06:05:06Z gfis $
# 2006-08-14: teuer
# 2006-08-11: don't write positive (already in aj_rootgen.pl)
# 2006-07-19: 4 fields; dunkel edel heikel simpel übel with -ler 
# 2006-06-23, Georg Fischer
#
# overwrite corresponding entries in aj_rootgen.pl and aj_color.pl
# type 1: umlaut in comparative and superlative
# type 2: -el -ler -elst
#
# caution, must be stored in UTF-8 encoding: äöüÄÖÜß, output in UTF-8

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
use strict;
    
    # binmode(STDOUT, ":utf8");
    while (<DATA>) {
        next if m/^\#/;
        next if m/^\s*$/;
        my ($aj, $comp, $super) = split;
        # print "$aj\t=AjPost\n";
        print "$comp\t=AjCmpr,$aj,AjPost\n";
        print "$super\t=AjSupl,$aj,AjPost\n";
    }

__DATA__
alt älter ältest
arg ärger ärgst
arm ärmer ärmst
brav bräver brävst
dumm dümmer dümmst
dunkel dunkler dunkelst
edel edler edelst
fromm frömmer frömmst
gesund gesünder gesündest
grob gröber gröbst
groß größer größt
gut besser best
hart härter härtest
heikel heikler heikelst
hoch höher höchst
jung jünger jüngst
kalt kälter kältest
klug klüger klügst
krank kränker kränkest
lang länger längst
nah näher nächst
nass nässer nässest
rot röter rötest
scharf schärfer schärfst
schwach schwächer schwächst
schwarz schwärzer schwärzest
simpel simpler simpelst
stark stärker stärkst
teuer teurer teuerst
viel mehr meist
warm wärmer wärmst
übel übler übelst
